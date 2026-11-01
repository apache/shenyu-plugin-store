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

import io.etcd.jetcd.Client;
import org.apache.shenyu.infra.etcd.client.EtcdClient;
import org.junit.jupiter.api.Test;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.images.builder.Transferable;
import org.testcontainers.utility.DockerImageName;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Full Admin HTTP API to gateway E2E with store artifacts in the runtime images.
 */
class EtcdDeploymentIT {

    private static final String NAMESPACE = "649330b6-c2d7-4edc-be8e-8a54df9eb385";

    @Test
    void externalArtifactsSupportAdminApiAndGatewayRegistration() throws Exception {
        try (Network network = Network.newNetwork();
                GenericContainer<?> etcd = etcd(network);
                GenericContainer<?> admin = admin(network);
                GenericContainer<?> backend = backend(network);
                GenericContainer<?> gateway = gateway(network)) {
            etcd.start();
            backend.start();
            admin.start();
            Path state = Files.createTempFile("etcd-deployment-", ".json");
            runScenario("prepare", state, admin, gateway);
            gateway.start();
            EtcdClient probe = EtcdClient.builder()
                    .client(Client.builder().endpoints("http://" + etcd.getHost() + ":" + etcd.getMappedPort(2379)).build())
                    .ttl(30).timeout(5000).build();
            try {
                assertThat(probe.getKeysMapByPrefix("/" + NAMESPACE + "/shenyu/plugin/")).isNotEmpty();
                awaitInstances(probe, true);
                runScenario("verify", state, admin, gateway);
                gateway.close();
                awaitInstances(probe, false);
            } finally {
                probe.close();
            }
            Files.deleteIfExists(state);
        }
    }

    private static GenericContainer<?> etcd(final Network network) {
        return new GenericContainer<>(DockerImageName.parse("quay.io/coreos/etcd:v3.5.21"))
                .withNetwork(network).withNetworkAliases("etcd").withExposedPorts(2379)
                .withCommand("etcd", "--listen-client-urls=http://0.0.0.0:2379", "--advertise-client-urls=http://etcd:2379")
                .waitingFor(Wait.forHttp("/health").forPort(2379));
    }

    private static GenericContainer<?> admin(final Network network) {
        return new GenericContainer<>(DockerImageName.parse("shenyu-plugin-store-admin:etcd"))
                .withNetwork(network).withExposedPorts(9095)
                .withEnv("ADMIN_JVM", "-Xms128m -Xmx768m")
                .withEnv("spring.profiles.active", "h2")
                .withEnv("shenyu.sync.websocket.enabled", "false")
                .withEnv("shenyu.sync.etcd.url", "http://etcd:2379")
                .waitingFor(Wait.forHttp("/actuator/health").forPort(9095).withStartupTimeout(Duration.ofMinutes(3)));
    }

    private static GenericContainer<?> backend(final Network network) {
        String config = "server { listen 9080; location / { return 200 'etcd-e2e-upstream'; } }";
        return new GenericContainer<>(DockerImageName.parse("nginx:1.27.4-alpine"))
                .withNetwork(network).withNetworkAliases("plugin-store-backend")
                .withCopyToContainer(Transferable.of(config), "/etc/nginx/conf.d/default.conf");
    }

    private static GenericContainer<?> gateway(final Network network) {
        return new GenericContainer<>(DockerImageName.parse("shenyu-plugin-store-bootstrap:etcd"))
                .withNetwork(network).withExposedPorts(9195)
                .withEnv("BOOT_JVM", "-Xms128m -Xmx768m")
                .withEnv("shenyu.namespace", NAMESPACE)
                .withEnv("shenyu.sync.websocket.urls", "false")
                .withEnv("shenyu.sync.etcd.url", "http://etcd:2379,http://etcd:2379")
                .withEnv("shenyu.register.enabled", "true")
                .withEnv("shenyu.register.registerType", "etcd")
                .withEnv("shenyu.register.serverLists", "http://etcd:2379")
                .withEnv("shenyu.register.props.name", "etcd-e2e-gateway")
                .withEnv("shenyu.register.props.etcdTTL", "2")
                .waitingFor(Wait.forHttp("/actuator/health").forPort(9195).withStartupTimeout(Duration.ofMinutes(3)));
    }

    private static void runScenario(final String action, final Path state,
                                     final GenericContainer<?> admin, final GenericContainer<?> gateway) throws Exception {
        Path root = Path.of(System.getProperty("user.dir")).toAbsolutePath();
        while (!Files.isRegularFile(root.resolve("script/plugin-store/etcd-deployment-e2e.py"))) {
            root = root.getParent();
            if (Objects.isNull(root)) {
                throw new IllegalStateException("Cannot find plugin-store E2E script");
            }
        }
        ProcessBuilder builder = new ProcessBuilder(System.getProperty("etcd.test.python", "python3"),
                root.resolve("script/plugin-store/etcd-deployment-e2e.py").toString(), action);
        builder.environment().put("SHENYU_ADMIN_URL", "http://" + admin.getHost() + ":" + admin.getMappedPort(9095));
        if ("verify".equals(action)) {
            builder.environment().put("SHENYU_GATEWAY_URL", "http://" + gateway.getHost() + ":" + gateway.getMappedPort(9195));
        }
        builder.environment().put("SHENYU_NAMESPACE_ID", NAMESPACE);
        builder.environment().put("ETCD_E2E_STATE", state.toString());
        Process process = builder.inheritIO().start();
        try {
            assertThat(process.waitFor(180, TimeUnit.SECONDS)).isTrue();
            assertThat(process.exitValue()).isZero();
        } finally {
            if (process.isAlive()) {
                process.destroyForcibly();
            }
        }
    }

    private static void awaitInstances(final EtcdClient client, final boolean present) throws InterruptedException {
        String prefix = "/shenyu/register/instance/etcd-e2e-gateway/";
        long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(30);
        while (System.nanoTime() < deadline) {
            if (client.getKeysMapByPrefix(prefix).isEmpty() != present) {
                return;
            }
            Thread.sleep(100);
        }
        assertThat(client.getKeysMapByPrefix(prefix).isEmpty()).isEqualTo(!present);
    }
}
