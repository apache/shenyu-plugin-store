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

package org.apache.shenyu.plugin.logging.rabbitmq;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.GetResponse;
import com.fasterxml.jackson.databind.JsonNode;
import net.jpountz.lz4.LZ4Factory;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.enums.PluginEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.common.utils.JsonUtils;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.logging.common.entity.LZ4CompressData;
import org.apache.shenyu.plugin.logging.common.entity.ShenyuRequestLog;
import org.apache.shenyu.plugin.logging.rabbitmq.handler.LoggingRabbitmqPluginDataHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.awaitility.Awaitility;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.web.server.ServerWebExchange;
import org.testcontainers.containers.RabbitMQContainer;
import org.testcontainers.utility.DockerImageName;

import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Base64;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * E2E tests for RabbitMQ logging through the real ShenYu gateway pipeline.
 */
public final class RabbitmqLoggingGatewayE2ETest {

    private static final DockerImageName RABBITMQ_IMAGE = DockerImageName.parse("rabbitmq:3.12-management-alpine")
            .asCompatibleSubstituteFor("rabbitmq");

    @Test
    public void shouldPublishGatewayAccessLogsAndRecoverAfterRefresh() throws Exception {
        try (RabbitMQContainer rabbit = new RabbitMQContainer(RABBITMQ_IMAGE)
                .withLabel("shenyu-migration-task", "logging-rabbitmq")) {
            rabbit.start();
            runGatewayScenario(rabbit);
        }
    }

    private void runGatewayScenario(final RabbitMQContainer rabbit) throws Exception {
        final ApplicationContext previousContext = SpringBeanUtils.getInstance().getApplicationContext();
        final LoggingRabbitmqPluginDataHandler dataHandler = new LoggingRabbitmqPluginDataHandler();
        try (GenericApplicationContext context = testContext()) {
            SpringBeanUtils.getInstance().setApplicationContext(context);
            publishGatewayAccessLogsAndRecoverAfterRefresh(rabbit, dataHandler);
        } finally {
            disablePlugin(dataHandler);
            SpringBeanUtils.getInstance().setApplicationContext(previousContext);
        }
    }

    private void publishGatewayAccessLogsAndRecoverAfterRefresh(final RabbitMQContainer rabbit,
                                                                final LoggingRabbitmqPluginDataHandler dataHandler)
            throws Exception {
        final LoggingRabbitmqPlugin plugin = new LoggingRabbitmqPlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}")
                .getSelectorData().setPluginId("plugin-rabbitmq");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(List.of(plugin),
                TerminalResponsePlugin.ok("rabbitmq-ok"))) {
            final String firstQueue = uniqueName("queue");
            final String secondQueue = uniqueName("queue");
            configurePlugin(dataHandler, rabbit, firstQueue, uniqueName("exchange"), "rk.one");
            GatewayResponse firstResponse = server.get("/rabbitmq-e2e");
            assertEquals(200, firstResponse.getStatusCode());
            assertEquals("rabbitmq-ok", firstResponse.getBody());
            ShenyuRequestLog first = consumeLog(rabbit, firstQueue);
            assertEquals(200, first.getStatus());
            assertEquals("/rabbitmq-e2e", first.getPath());
            assertTrue(first.getResponseBody().contains("rabbitmq-ok"));

            configurePlugin(dataHandler, rabbit, secondQueue, uniqueName("exchange"), "rk.two");
            GatewayResponse secondResponse = server.get("/rabbitmq-e2e");
            assertEquals(200, secondResponse.getStatusCode());
            ShenyuRequestLog second = consumeLog(rabbit, secondQueue);
            assertEquals(200, second.getStatus());
            assertEquals("/rabbitmq-e2e", second.getPath());

            configureUnavailable(dataHandler);
            configurePlugin(dataHandler, rabbit, secondQueue, uniqueName("exchange"), "rk.recovered");
            GatewayResponse recoveredResponse = server.get("/rabbitmq-e2e");
            assertEquals(200, recoveredResponse.getStatusCode());
            assertEquals(200, consumeLog(rabbit, secondQueue).getStatus());
        }
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

    private void configurePlugin(final LoggingRabbitmqPluginDataHandler dataHandler, final RabbitMQContainer rabbit,
                                 final String queue, final String exchange, final String routingKey) {
        final String config = "{\"host\":\"" + rabbit.getHost() + "\",\"port\":" + rabbit.getAmqpPort()
                + ",\"username\":\"" + rabbit.getAdminUsername() + "\",\"password\":\""
                + rabbit.getAdminPassword() + "\",\"virtualHost\":\"/\",\"exchangeName\":\"" + exchange
                + "\",\"queueName\":\"" + queue + "\",\"routingKey\":\"" + routingKey
                + "\",\"exchangeType\":\"direct\",\"durable\":true,\"exclusive\":false,"
                + "\"autoDelete\":false,\"sampleRate\":\"1\",\"bufferQueueSize\":16}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void configureUnavailable(final LoggingRabbitmqPluginDataHandler dataHandler) {
        final String config = "{\"host\":\"127.0.0.1\",\"port\":1,\"username\":\"guest\",\"password\":\"guest\","
                + "\"virtualHost\":\"/\",\"exchangeName\":\"broken\",\"queueName\":\"broken\","
                + "\"routingKey\":\"broken\",\"exchangeType\":\"direct\",\"durable\":true,\"exclusive\":false,"
                + "\"autoDelete\":false,\"sampleRate\":\"1\",\"bufferQueueSize\":16}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void disablePlugin(final LoggingRabbitmqPluginDataHandler dataHandler) {
        PluginData disabled = pluginData("{}");
        disabled.setEnabled(Boolean.FALSE);
        dataHandler.handlerPlugin(disabled);
    }

    private PluginData pluginData(final String config) {
        PluginData pluginData = new PluginData();
        pluginData.setId("plugin-rabbitmq");
        pluginData.setName(PluginEnum.LOGGING_RABBITMQ.getName());
        pluginData.setEnabled(Boolean.TRUE);
        pluginData.setSort(PluginEnum.LOGGING_RABBITMQ.getCode());
        pluginData.setConfig(config);
        return pluginData;
    }

    private ShenyuRequestLog consumeLog(final RabbitMQContainer rabbit, final String queueName) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(rabbit.getHost());
        factory.setPort(rabbit.getAmqpPort());
        factory.setUsername(rabbit.getAdminUsername());
        factory.setPassword(rabbit.getAdminPassword());
        try (Connection connection = factory.newConnection(); Channel channel = connection.createChannel()) {
            AtomicReference<ShenyuRequestLog> received = new AtomicReference<>();
            Awaitility.await().atMost(Duration.ofSeconds(20)).untilAsserted(() -> {
                GetResponse response = channel.basicGet(queueName, true);
                if (Objects.nonNull(response)) {
                    received.set(decode(response.getBody()));
                }
                assertTrue(Objects.nonNull(received.get()));
            });
            return received.get();
        }
    }

    private ShenyuRequestLog decode(final byte[] body) {
        JsonNode node = JsonUtils.toJsonNode(new String(body, StandardCharsets.UTF_8));
        LZ4CompressData compressed = new LZ4CompressData(node.get("length").asInt(),
                Base64.getDecoder().decode(node.get("compressedData").asText()));
        byte[] restored = new byte[compressed.getLength()];
        LZ4Factory.fastestInstance().safeDecompressor().decompress(compressed.getCompressedData(), 0,
                compressed.getCompressedData().length, restored, 0);
        return GsonUtils.getInstance().fromJson(new String(restored, StandardCharsets.UTF_8), ShenyuRequestLog.class);
    }

    private String uniqueName(final String prefix) {
        return prefix + "." + UUID.randomUUID().toString().replace("-", "");
    }
}
