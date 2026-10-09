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

package org.apache.shenyu.plugin.logging.pulsar;

import org.apache.pulsar.client.api.Consumer;
import org.apache.pulsar.client.api.Message;
import org.apache.pulsar.client.api.Producer;
import org.apache.pulsar.client.api.PulsarClient;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.enums.PluginEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.logging.common.entity.ShenyuRequestLog;
import org.apache.shenyu.plugin.logging.pulsar.handler.LoggingPulsarPluginDataHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.awaitility.Awaitility;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.web.server.ServerWebExchange;
import org.testcontainers.containers.PulsarContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.DockerImageName;

import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * E2E tests for Pulsar logging through the real ShenYu gateway pipeline.
 */
public final class PulsarLoggingGatewayE2ETest {

    private static final DockerImageName PULSAR_IMAGE = DockerImageName.parse("apachepulsar/pulsar:2.10.1");

    @Test
    public void shouldProduceGatewayAccessLogsAndRecoverAfterRefresh() throws Exception {
        try (PulsarContainer pulsar = new PulsarContainer(PULSAR_IMAGE)
                .withLabel("shenyu-migration-task", "logging-pulsar")
                .waitingFor(Wait.forLogMessage(".*Started Pulsar Broker service.*", 1))
                .withStartupTimeout(Duration.ofMinutes(5))
                .withEnv("PULSAR_MEM", "-Xms128m -Xmx512m -XX:MaxDirectMemorySize=256m")
                .withCreateContainerCmdModifier(cmd -> cmd.getHostConfig().withMemory(768L * 1024L * 1024L))) {
            pulsar.start();
            waitUntilPulsarAcceptsClientConnections(pulsar);
            runGatewayScenario(pulsar);
        }
    }

    private void waitUntilPulsarAcceptsClientConnections(final PulsarContainer pulsar) {
        Awaitility.await().atMost(Duration.ofMinutes(2)).untilAsserted(() -> {
            try (PulsarClient client = PulsarClient.builder().serviceUrl(pulsar.getPulsarBrokerUrl()).build();
                 Producer<byte[]> producer = client.newProducer().topic(topicName()).create()) {
                producer.send("ready".getBytes(StandardCharsets.UTF_8));
            }
        });
    }

    private void runGatewayScenario(final PulsarContainer pulsar) throws Exception {
        final ApplicationContext previousContext = SpringBeanUtils.getInstance().getApplicationContext();
        final LoggingPulsarPluginDataHandler dataHandler = new LoggingPulsarPluginDataHandler();
        final String firstTopic = topicName();
        final String secondTopic = topicName();
        final LoggingPulsarPlugin plugin = new LoggingPulsarPlugin();
        try (GenericApplicationContext context = testContext();
             PulsarClient client = PulsarClient.builder().serviceUrl(pulsar.getPulsarBrokerUrl()).build();
             Consumer<byte[]> firstConsumer = consumer(client, firstTopic);
             Consumer<byte[]> secondConsumer = consumer(client, secondTopic);
             ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(List.of(plugin),
                     TerminalResponsePlugin.ok("pulsar-ok"))) {
            SpringBeanUtils.getInstance().setApplicationContext(context);
            produceGatewayAccessLogsAndRecoverAfterRefresh(pulsar, dataHandler, server, firstTopic, secondTopic,
                    firstConsumer, secondConsumer, plugin);
        } finally {
            disablePlugin(dataHandler);
            SpringBeanUtils.getInstance().setApplicationContext(previousContext);
        }
    }

    private void produceGatewayAccessLogsAndRecoverAfterRefresh(final PulsarContainer pulsar,
                                                                final LoggingPulsarPluginDataHandler dataHandler,
                                                                final ShenyuGatewayTestServer server,
                                                                final String firstTopic, final String secondTopic,
                                                                final Consumer<byte[]> firstConsumer,
                                                                final Consumer<byte[]> secondConsumer,
                                                                final LoggingPulsarPlugin plugin) {
        GatewayFixtures.cachePluginRoute(plugin, "{}")
                .getSelectorData().setPluginId("plugin-pulsar");
        configurePlugin(dataHandler, pulsar.getPulsarBrokerUrl(), firstTopic);
        GatewayResponse firstResponse = server.get("/pulsar-e2e");
        assertEquals(200, firstResponse.getStatusCode());
        assertEquals("pulsar-ok", firstResponse.getBody());
        ShenyuRequestLog first = receiveLog(firstConsumer);
        assertEquals(200, first.getStatus());
        assertEquals("/pulsar-e2e", first.getPath());
        assertTrue(first.getResponseBody().contains("pulsar-ok"));

        configurePlugin(dataHandler, pulsar.getPulsarBrokerUrl(), secondTopic);
        GatewayResponse secondResponse = server.get("/pulsar-e2e");
        assertEquals(200, secondResponse.getStatusCode());
        ShenyuRequestLog second = receiveLog(secondConsumer);
        assertEquals(200, second.getStatus());
        assertEquals("/pulsar-e2e", second.getPath());

        configureUnavailable(dataHandler);
        configurePlugin(dataHandler, pulsar.getPulsarBrokerUrl(), secondTopic);
        GatewayResponse recoveredResponse = server.get("/pulsar-e2e");
        assertEquals(200, recoveredResponse.getStatusCode());
        assertEquals(200, receiveLog(secondConsumer).getStatus());
    }

    private GenericApplicationContext testContext() {
        GenericApplicationContext context = new GenericApplicationContext();
        context.registerBean(ShenyuConfig.class, ShenyuConfig::new);
        context.registerBean(RemoteAddressResolver.class, () -> new RemoteAddressResolver() {
            @Override
            public InetSocketAddress resolve(final ServerWebExchange exchange) {
                return new InetSocketAddress("127.0.0.1", 12345);
            }
        });
        context.refresh();
        return context;
    }

    private Consumer<byte[]> consumer(final PulsarClient client, final String topic) throws Exception {
        return client.newConsumer().topic(topic).subscriptionName("sub-" + UUID.randomUUID()).subscribe();
    }

    private void configurePlugin(final LoggingPulsarPluginDataHandler dataHandler, final String serviceUrl,
                                 final String topic) {
        final String config = "{\"serviceUrl\":\"" + serviceUrl + "\",\"topic\":\"" + topic
                + "\",\"compressAlg\":\"\",\"sampleRate\":\"1\",\"bufferQueueSize\":16}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void configureUnavailable(final LoggingPulsarPluginDataHandler dataHandler) {
        final String config = "{\"serviceUrl\":\"\",\"topic\":\"broken\",\"compressAlg\":\"\","
                + "\"sampleRate\":\"1\",\"bufferQueueSize\":16}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void disablePlugin(final LoggingPulsarPluginDataHandler dataHandler) {
        PluginData disabled = pluginData("{}");
        disabled.setEnabled(Boolean.FALSE);
        dataHandler.handlerPlugin(disabled);
    }

    private PluginData pluginData(final String config) {
        PluginData pluginData = new PluginData();
        pluginData.setId("plugin-pulsar");
        pluginData.setName(PluginEnum.LOGGING_PULSAR.getName());
        pluginData.setEnabled(Boolean.TRUE);
        pluginData.setSort(PluginEnum.LOGGING_PULSAR.getCode());
        pluginData.setConfig(config);
        return pluginData;
    }

    private ShenyuRequestLog receiveLog(final Consumer<byte[]> consumer) {
        AtomicReference<ShenyuRequestLog> received = new AtomicReference<>();
        Awaitility.await().atMost(Duration.ofSeconds(30)).untilAsserted(() -> {
            Message<byte[]> message = consumer.receive(1, TimeUnit.SECONDS);
            if (Objects.nonNull(message)) {
                received.set(GsonUtils.getInstance().fromJson(new String(message.getValue(), StandardCharsets.UTF_8),
                        ShenyuRequestLog.class));
                consumer.acknowledge(message);
            }
            assertTrue(Objects.nonNull(received.get()));
        });
        return received.get();
    }

    private String topicName() {
        return "persistent://public/default/shenyu-" + UUID.randomUUID().toString().replace("-", "");
    }
}
