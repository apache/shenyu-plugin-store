/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.shenyu.springboot.sync.data.etcd;

import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.DockerImageName;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * Disposable real etcd server; CI uses Testcontainers, developer hosts can select a native binary.
 */
final class EtcdTestServer implements AutoCloseable {

    private static final int ETCD_PORT = 2379;

    private final String binary = System.getProperty("etcd.test.binary");

    private GenericContainer<?> container;

    private Process process;

    private Path dataDirectory;

    private int port;

    private int peerPort;

    void start() throws Exception {
        if (Objects.isNull(binary)) {
            port = availablePort();
            container = new GenericContainer<>(DockerImageName.parse("quay.io/coreos/etcd:v3.5.21"))
                    .withExposedPorts(ETCD_PORT)
                    .withCommand("etcd", "--listen-client-urls=http://0.0.0.0:2379", "--advertise-client-urls=http://127.0.0.1:2379")
                    .waitingFor(Wait.forHttp("/health").forPort(ETCD_PORT).forStatusCode(200));
            // Reconnecting clients must keep the same endpoint when Docker restarts the server.
            container.setPortBindings(List.of(port + ":" + ETCD_PORT));
            container.start();
            port = container.getMappedPort(ETCD_PORT);
        } else {
            port = availablePort();
            peerPort = availablePort();
            dataDirectory = Files.createTempDirectory("shenyu-etcd-test-");
            startProcess();
        }
    }

    String getHost() {
        return Objects.isNull(container) ? "127.0.0.1" : container.getHost();
    }

    int getPort() {
        return port;
    }

    void interrupt() throws Exception {
        if (Objects.nonNull(container)) {
            container.getDockerClient().stopContainerCmd(container.getContainerId()).withTimeout(2).exec();
            container.getDockerClient().startContainerCmd(container.getContainerId()).exec();
            waitForHealth();
        } else {
            stopProcess();
            startProcess();
        }
    }

    private void startProcess() throws Exception {
        String clientUrl = "http://127.0.0.1:" + port;
        String peerUrl = "http://127.0.0.1:" + peerPort;
        process = new ProcessBuilder(binary, "--data-dir=" + dataDirectory,
                "--listen-client-urls=" + clientUrl, "--advertise-client-urls=" + clientUrl,
                "--listen-peer-urls=" + peerUrl, "--initial-advertise-peer-urls=" + peerUrl,
                "--initial-cluster=default=" + peerUrl)
                .redirectErrorStream(true).redirectOutput(dataDirectory.resolve("server.log").toFile()).start();
        waitForHealth();
    }

    private void waitForHealth() throws Exception {
        HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(1)).build();
        HttpRequest request = HttpRequest.newBuilder(URI.create("http://" + getHost() + ":" + port + "/health"))
                .timeout(Duration.ofSeconds(1)).GET().build();
        long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(30);
        while (System.nanoTime() < deadline) {
            try {
                if (http.send(request, HttpResponse.BodyHandlers.ofString()).statusCode() == 200) {
                    return;
                }
            } catch (IOException ignored) {
                // The process has not opened its listener yet.
            }
            Thread.sleep(100);
        }
        throw new IllegalStateException("etcd did not become healthy; inspect " + dataDirectory);
    }

    private static int availablePort() throws IOException {
        try (ServerSocket socket = new ServerSocket(0)) {
            return socket.getLocalPort();
        }
    }

    private void stopProcess() throws InterruptedException {
        if (Objects.nonNull(process)) {
            process.destroy();
            if (!process.waitFor(10, TimeUnit.SECONDS)) {
                process.destroyForcibly().waitFor(10, TimeUnit.SECONDS);
            }
        }
    }

    @Override
    public void close() throws Exception {
        if (Objects.nonNull(container)) {
            container.close();
        }
        stopProcess();
    }
}
