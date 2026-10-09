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

package org.apache.shenyu.plugin.logging.clickhouse;

import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.enums.PluginEnum;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.logging.clickhouse.handler.LoggingClickHousePluginDataHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.awaitility.Awaitility;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.web.server.ServerWebExchange;
import org.testcontainers.clickhouse.ClickHouseContainer;
import org.testcontainers.utility.DockerImageName;

import java.net.InetSocketAddress;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * E2E tests for ClickHouse logging through the real ShenYu gateway pipeline.
 */
public final class ClickHouseLoggingGatewayE2ETest {

    private static final DockerImageName CLICKHOUSE_IMAGE = DockerImageName.parse("clickhouse/clickhouse-server:23.8-alpine")
            .asCompatibleSubstituteFor("clickhouse/clickhouse-server");

    private static final int CLICKHOUSE_HTTP_PORT = 8123;

    @Test
    public void shouldInsertGatewayAccessLogsAndRecoverAfterRefresh() throws Exception {
        try (ClickHouseContainer clickHouse = new ClickHouseContainer(CLICKHOUSE_IMAGE)
                .withLabel("shenyu-migration-task", "logging-clickhouse")) {
            clickHouse.start();
            runGatewayScenario(clickHouse);
        }
    }

    private void runGatewayScenario(final ClickHouseContainer clickHouse) throws Exception {
        final ApplicationContext previousContext = SpringBeanUtils.getInstance().getApplicationContext();
        final LoggingClickHousePluginDataHandler dataHandler = new LoggingClickHousePluginDataHandler();
        try (GenericApplicationContext context = testContext()) {
            SpringBeanUtils.getInstance().setApplicationContext(context);
            insertGatewayAccessLogsAndRecoverAfterRefresh(clickHouse, dataHandler);
        } finally {
            disablePlugin(dataHandler);
            SpringBeanUtils.getInstance().setApplicationContext(previousContext);
        }
    }

    private void insertGatewayAccessLogsAndRecoverAfterRefresh(final ClickHouseContainer clickHouse,
                                                               final LoggingClickHousePluginDataHandler dataHandler)
            throws Exception {
        final LoggingClickHousePlugin plugin = new LoggingClickHousePlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}")
                .getSelectorData().setPluginId("plugin-clickhouse");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(List.of(plugin),
                TerminalResponsePlugin.ok("clickhouse-ok"))) {
            final String firstDatabase = databaseName();
            final String secondDatabase = databaseName();
            configurePlugin(dataHandler, clickHouse, firstDatabase, "\"ttl\":\"\"");
            GatewayResponse firstResponse = server.get("/clickhouse-e2e");
            assertEquals(200, firstResponse.getStatusCode());
            assertEquals("clickhouse-ok", firstResponse.getBody());
            String first = queryLatest(clickHouse, firstDatabase);
            assertTrue(first.contains("200\t/clickhouse-e2e"));
            assertTrue(first.contains("clickhouse-ok"));

            configurePlugin(dataHandler, clickHouse, secondDatabase, "");
            GatewayResponse secondResponse = server.get("/clickhouse-e2e");
            assertEquals(200, secondResponse.getStatusCode());
            String second = queryLatest(clickHouse, secondDatabase);
            assertTrue(second.contains("200\t/clickhouse-e2e"));

            configureUnavailable(dataHandler);
            configurePlugin(dataHandler, clickHouse, secondDatabase, "");
            GatewayResponse recoveredResponse = server.get("/clickhouse-e2e");
            assertEquals(200, recoveredResponse.getStatusCode());
            assertTrue(queryLatest(clickHouse, secondDatabase).contains("200\t/clickhouse-e2e"));
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

    private void configurePlugin(final LoggingClickHousePluginDataHandler dataHandler,
                                 final ClickHouseContainer clickHouse, final String database,
                                 final String ttlEntry) {
        final String ttl = ttlEntry.isEmpty() ? "" : "," + ttlEntry;
        final String config = "{\"host\":\"" + clickHouse.getHost() + "\",\"port\":\""
                + clickHouse.getMappedPort(CLICKHOUSE_HTTP_PORT) + "\",\"database\":\"" + database
                + "\",\"username\":\"" + clickHouse.getUsername() + "\",\"password\":\""
                + clickHouse.getPassword() + "\",\"engine\":\"MergeTree\",\"sampleRate\":\"1\","
                + "\"bufferQueueSize\":16" + ttl + "}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void configureUnavailable(final LoggingClickHousePluginDataHandler dataHandler) {
        final String config = "{\"host\":\"127.0.0.1\",\"port\":\"1\",\"database\":\"broken\","
                + "\"username\":\"default\",\"password\":\"\",\"engine\":\"MergeTree\","
                + "\"sampleRate\":\"1\",\"bufferQueueSize\":16}";
        dataHandler.handlerPlugin(pluginData(config));
    }

    private void disablePlugin(final LoggingClickHousePluginDataHandler dataHandler) {
        PluginData disabled = pluginData("{}");
        disabled.setEnabled(Boolean.FALSE);
        dataHandler.handlerPlugin(disabled);
    }

    private PluginData pluginData(final String config) {
        PluginData pluginData = new PluginData();
        pluginData.setId("plugin-clickhouse");
        pluginData.setName(PluginEnum.LOGGING_CLICK_HOUSE.getName());
        pluginData.setEnabled(Boolean.TRUE);
        pluginData.setSort(PluginEnum.LOGGING_CLICK_HOUSE.getCode());
        pluginData.setConfig(config);
        return pluginData;
    }

    private String queryLatest(final ClickHouseContainer clickHouse, final String database) {
        AtomicReference<String> row = new AtomicReference<>();
        Awaitility.await().atMost(Duration.ofSeconds(30)).untilAsserted(() -> {
            String query = "SELECT status,path,responseBody FROM `" + database
                    + "`.request_log ORDER BY timeLocal DESC LIMIT 1 FORMAT TabSeparated";
            String result = query(clickHouse, query);
            if (!result.isBlank()) {
                row.set(result.trim());
            }
            assertTrue(Objects.nonNull(row.get()));
        });
        return row.get();
    }

    private String query(final ClickHouseContainer clickHouse, final String query) throws Exception {
        String encoded = URLEncoder.encode(query, StandardCharsets.UTF_8);
        URI uri = URI.create("http://" + clickHouse.getHost() + ":"
                + clickHouse.getMappedPort(CLICKHOUSE_HTTP_PORT) + "/?query=" + encoded);
        HttpRequest request = HttpRequest.newBuilder(uri).GET().build();
        HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
        assertEquals(200, response.statusCode(), response.body());
        return response.body();
    }

    private String databaseName() {
        return "shenyu_" + UUID.randomUUID().toString().replace("-", "");
    }
}
