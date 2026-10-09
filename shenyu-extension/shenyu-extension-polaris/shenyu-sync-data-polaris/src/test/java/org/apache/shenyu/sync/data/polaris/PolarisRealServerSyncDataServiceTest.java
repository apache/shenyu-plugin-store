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

package org.apache.shenyu.sync.data.polaris;

import com.tencent.polaris.api.config.Configuration;
import com.tencent.polaris.configuration.api.core.ConfigFilePublishService;
import com.tencent.polaris.configuration.api.core.ConfigFileService;
import com.tencent.polaris.configuration.factory.ConfigFileServiceFactory;
import com.tencent.polaris.configuration.factory.ConfigFileServicePublishFactory;
import com.tencent.polaris.factory.ConfigAPIFactory;
import com.tencent.polaris.factory.config.ConfigurationImpl;
import org.apache.shenyu.admin.config.properties.PolarisProperties;
import org.apache.shenyu.admin.listener.polaris.PolarisDataChangedListener;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.enums.DataEventTypeEnum;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.AbstractShenyuPlugin;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.CommonPluginDataSubscriber;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.apache.shenyu.sync.data.polaris.config.PolarisConfig;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.function.Supplier;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Real Polaris standalone integration coverage for admin publish, sync watch, and gateway behavior.
 */
@Testcontainers
public final class PolarisRealServerSyncDataServiceTest {

    private static final int POLARIS_HTTP_PORT = 8090;

    private static final int POLARIS_NAMING_GRPC_PORT = 8091;

    private static final int POLARIS_CONFIG_GRPC_PORT = 8093;

    private static final DockerImageName POLARIS_IMAGE = DockerImageName
            .parse("polarismesh/polaris-standalone@sha256:22c75382080a260e5d9fc9839b6657ae73f3154e308b8da881e1fab58653911c");

    @Container
    private static final GenericContainer<?> POLARIS = new GenericContainer<>(POLARIS_IMAGE)
            .withExposedPorts(POLARIS_HTTP_PORT, POLARIS_NAMING_GRPC_PORT, POLARIS_CONFIG_GRPC_PORT)
            .waitingFor(Wait.forHttp("/")
                    .forPort(POLARIS_HTTP_PORT)
                    .forResponsePredicate(body -> body.contains("Polaris Server")))
            .withStartupTimeout(Duration.ofMinutes(2));

    private GenericApplicationContext applicationContext;

    @BeforeAll
    public static void verifyRealPolarisServer() {
        assertThat(POLARIS.isRunning()).isTrue();
    }

    @AfterEach
    public void cleanUp() {
        GatewayFixtures.cleanBaseDataCache();
        if (Objects.nonNull(applicationContext)) {
            applicationContext.close();
        }
        SpringBeanUtils.getInstance().setApplicationContext(null);
    }

    @Test
    public void adminPublishesPolarisConfigThatSyncSubscriberAppliesToRealGateway() {
        ShenyuConfig shenyuConfig = new ShenyuConfig();
        registerShenyuConfig(shenyuConfig);
        EchoMatchedRulePlugin plugin = new EchoMatchedRulePlugin();
        GatewayFixtures.CachedPluginData route = GatewayFixtures.cachePluginRoute(plugin, "polaris-v1");
        GatewayFixtures.cleanBaseDataCache();

        String group = "shenyu-" + UUID.randomUUID();
        Configuration configuration = polarisConfiguration();
        ConfigFileService configFileService = ConfigFileServiceFactory.createConfigFileService(configuration);
        ConfigFilePublishService publishService = ConfigFileServicePublishFactory.createConfigFilePublishService(configuration);
        PolarisDataChangedListener listener = new PolarisDataChangedListener(polarisProperties(group), configFileService, publishService);
        PolarisSyncDataService syncDataService = new PolarisSyncDataService(polarisConfig(group), configFileService,
                pluginDataSubscriber(shenyuConfig), Collections.emptyList(), Collections.emptyList(), Collections.emptyList(),
                Collections.emptyList(), shenyuConfig);

        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(List.of(plugin),
                TerminalResponsePlugin.response(HttpStatus.NOT_FOUND, "polaris-miss", MediaType.TEXT_PLAIN))) {
            assertThat(server.get("/polaris/route").getBody()).isEqualTo("polaris-miss");

            publishRoute(listener, route, DataEventTypeEnum.CREATE);

            eventually(() -> server.get("/polaris/route").getBody(), "polaris-v1");

            route.getRuleData().setHandle("polaris-v2");
            listener.onRuleChanged(List.of(route.getRuleData()), DataEventTypeEnum.CREATE);
            eventually(() -> server.get("/polaris/route").getBody(), "polaris-v2");

            listener.onRuleChanged(List.of(route.getRuleData()), DataEventTypeEnum.DELETE);
            eventually(() -> server.get("/polaris/route").getBody(), "polaris-miss");

            route.getRuleData().setHandle("polaris-v3");
            listener.onRuleChanged(List.of(route.getRuleData()), DataEventTypeEnum.CREATE);
            eventually(() -> server.get("/polaris/route").getBody(), "polaris-v3");

            syncDataService.close();
            route.getRuleData().setHandle("polaris-v4");
            listener.onRuleChanged(List.of(route.getRuleData()), DataEventTypeEnum.CREATE);
            GatewayFixtures.cleanBaseDataCache();
            try (PolarisSyncDataService ignored = new PolarisSyncDataService(polarisConfig(group), configFileService,
                    pluginDataSubscriber(shenyuConfig), Collections.emptyList(), Collections.emptyList(), Collections.emptyList(),
                    Collections.emptyList(), shenyuConfig)) {
                eventually(() -> BaseDataCache.getInstance().obtainPluginData(plugin.named()).getName(), plugin.named());
                eventually(() -> server.get("/polaris/route").getBody(), "polaris-v4");
            }
        } finally {
            syncDataService.close();
        }
    }

    private static CommonPluginDataSubscriber pluginDataSubscriber(final ShenyuConfig shenyuConfig) {
        return new CommonPluginDataSubscriber(Collections.emptyList(), event -> {
        }, shenyuConfig.getSelectorMatchCache(), shenyuConfig.getRuleMatchCache());
    }

    private static void publishRoute(final PolarisDataChangedListener listener, final GatewayFixtures.CachedPluginData route,
                                     final DataEventTypeEnum eventType) {
        final PluginData pluginData = route.getPluginData();
        final SelectorData selectorData = route.getSelectorData();
        final RuleData ruleData = route.getRuleData();
        listener.onPluginChanged(List.of(pluginData), eventType);
        eventually(() -> BaseDataCache.getInstance().obtainPluginData(pluginData.getName()).getName(), pluginData.getName());
        listener.onSelectorChanged(List.of(selectorData), eventType);
        eventually(() -> BaseDataCache.getInstance().obtainSelectorData(pluginData.getName()).get(0).getId(), selectorData.getId());
        listener.onRuleChanged(List.of(ruleData), eventType);
        eventually(() -> BaseDataCache.getInstance().obtainRuleData(selectorData.getId()).get(0).getHandle(), ruleData.getHandle());
    }

    private static Configuration polarisConfiguration() {
        ConfigurationImpl configuration = (ConfigurationImpl) ConfigAPIFactory.defaultConfig();
        configuration.getGlobal().getServerConnector().setAddresses(List.of(polarisAddress(POLARIS_NAMING_GRPC_PORT)));
        configuration.getGlobal().getSystem().getDiscoverCluster().setSameAsBuiltin(true);
        configuration.getGlobal().getSystem().getHealthCheckCluster().setSameAsBuiltin(true);
        configuration.getConfigFile().getServerConnector().setAddresses(List.of(polarisAddress(POLARIS_CONFIG_GRPC_PORT)));
        configuration.getConfigFile().getServerConnector().setPersistDir("target/polaris/backup/config");
        return configuration;
    }

    private static String polarisAddress(final int exposedPort) {
        return POLARIS.getHost() + ':' + POLARIS.getMappedPort(exposedPort);
    }

    private static PolarisProperties polarisProperties(final String group) {
        PolarisProperties properties = new PolarisProperties();
        properties.setUrl(polarisAddress(POLARIS_CONFIG_GRPC_PORT));
        properties.setNamespace("default");
        properties.setFileGroup(group);
        return properties;
    }

    private static PolarisConfig polarisConfig(final String group) {
        PolarisConfig config = new PolarisConfig();
        config.setUrl(polarisAddress(POLARIS_CONFIG_GRPC_PORT));
        config.setNamespace("default");
        config.setFileGroup(group);
        return config;
    }

    private void registerShenyuConfig(final ShenyuConfig shenyuConfig) {
        applicationContext = new GenericApplicationContext();
        applicationContext.registerBean(ShenyuConfig.class, () -> shenyuConfig);
        applicationContext.refresh();
        SpringBeanUtils.getInstance().setApplicationContext(applicationContext);
    }

    private static void eventually(final Supplier<String> actual, final String expected) {
        AssertionError lastError = null;
        long deadline = System.nanoTime() + Duration.ofSeconds(60).toNanos();
        while (System.nanoTime() < deadline) {
            try {
                assertThat(actual.get()).isEqualTo(expected);
                return;
            } catch (AssertionError | RuntimeException ex) {
                lastError = ex instanceof AssertionError ? (AssertionError) ex : new AssertionError(ex);
                sleep();
            }
        }
        throw Objects.isNull(lastError) ? new AssertionError("Condition was not satisfied") : lastError;
    }

    private static void sleep() {
        try {
            Thread.sleep(500L);
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new AssertionError(ex);
        }
    }

    private static final class EchoMatchedRulePlugin extends AbstractShenyuPlugin {

        @Override
        protected Mono<Void> doExecute(final ServerWebExchange exchange, final ShenyuPluginChain chain,
                                       final SelectorData selector, final RuleData rule) {
            byte[] bytes = rule.getHandle().getBytes(StandardCharsets.UTF_8);
            exchange.getResponse().setStatusCode(HttpStatus.OK);
            exchange.getResponse().getHeaders().setContentType(MediaType.TEXT_PLAIN);
            exchange.getResponse().getHeaders().setContentLength(bytes.length);
            return exchange.getResponse().writeWith(Mono.just(exchange.getResponse().bufferFactory().wrap(bytes)));
        }

        @Override
        public int getOrder() {
            return 0;
        }

        @Override
        public String named() {
            return "polaris-real-e2e";
        }
    }
}
