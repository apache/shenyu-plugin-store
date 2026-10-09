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

package org.apache.shenyu.springboot.sync.data.consul;

import com.ecwid.consul.v1.ConsulClient;
import com.ecwid.consul.v1.QueryParams;
import org.apache.shenyu.admin.listener.consul.ConsulDataChangedInit;
import org.apache.shenyu.admin.listener.consul.ConsulDataChangedListener;
import org.apache.shenyu.admin.service.SyncDataService;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.ConditionData;
import org.apache.shenyu.common.dto.DiscoverySyncData;
import org.apache.shenyu.common.dto.DiscoveryUpstreamData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.dto.convert.rule.impl.DivideRuleHandle;
import org.apache.shenyu.common.enums.DataEventTypeEnum;
import org.apache.shenyu.common.enums.MatchModeEnum;
import org.apache.shenyu.common.enums.OperatorEnum;
import org.apache.shenyu.common.enums.ParamTypeEnum;
import org.apache.shenyu.common.enums.PluginEnum;
import org.apache.shenyu.common.enums.RpcTypeEnum;
import org.apache.shenyu.common.enums.SelectorTypeEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.loadbalancer.cache.UpstreamCacheManager;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.context.ShenyuContextDecorator;
import org.apache.shenyu.plugin.api.result.DefaultShenyuResult;
import org.apache.shenyu.plugin.api.result.ShenyuResult;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.CommonDiscoveryUpstreamDataSubscriber;
import org.apache.shenyu.plugin.base.cache.CommonPluginDataSubscriber;
import org.apache.shenyu.plugin.base.cache.MatchDataCache;
import org.apache.shenyu.plugin.base.cache.PluginHandlerEvent;
import org.apache.shenyu.plugin.base.handler.DiscoveryUpstreamDataHandler;
import org.apache.shenyu.plugin.base.handler.PluginDataHandler;
import org.apache.shenyu.plugin.divide.DividePlugin;
import org.apache.shenyu.plugin.divide.context.DivideShenyuContextDecorator;
import org.apache.shenyu.plugin.divide.handler.DividePluginDataHandler;
import org.apache.shenyu.plugin.divide.handler.DivideUpstreamDataHandler;
import org.apache.shenyu.plugin.global.DefaultShenyuContextBuilder;
import org.apache.shenyu.plugin.global.GlobalPlugin;
import org.apache.shenyu.plugin.httpclient.NettyHttpClientPlugin;
import org.apache.shenyu.plugin.response.ResponsePlugin;
import org.apache.shenyu.plugin.response.strategy.MessageWriter;
import org.apache.shenyu.plugin.response.strategy.NettyClientMessageWriter;
import org.apache.shenyu.plugin.uri.URIPlugin;
import org.apache.shenyu.registry.api.config.RegisterConfig;
import org.apache.shenyu.registry.api.entity.InstanceEntity;
import org.apache.shenyu.registry.consul.ConsulInstanceRegisterRepository;
import org.apache.shenyu.sync.data.consul.ConsulSyncDataService;
import org.apache.shenyu.sync.data.consul.config.ConsulConfig;
import org.apache.shenyu.web.handler.ShenyuWebHandler;
import org.apache.shenyu.web.loader.ShenyuLoaderService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.http.server.reactive.ReactorHttpHandlerAdapter;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.server.adapter.HttpWebHandlerAdapter;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.DockerImageName;
import reactor.core.publisher.Mono;
import reactor.netty.DisposableServer;
import reactor.netty.http.client.HttpClient;
import reactor.netty.http.server.HttpServer;

import java.net.URI;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Properties;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

/**
 * Real Consul server integration tests.
 */
public final class ConsulRealServerTest {

    private static final DockerImageName CONSUL_IMAGE = DockerImageName.parse("consul:1.15.4");

    private static final int CONSUL_PORT = 8500;

    private static final java.net.http.HttpClient HTTP_CLIENT = java.net.http.HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(2))
            .build();

    @Test
    void shouldDriveGatewayRouteLifecycleThroughRealConsul() throws Exception {
        try (GenericContainer<?> consul = new GenericContainer<>(CONSUL_IMAGE)
                .withExposedPorts(CONSUL_PORT)
                .withCommand("agent", "-dev", "-client", "0.0.0.0")
                .waitingFor(Wait.forHttp("/v1/status/leader").forPort(CONSUL_PORT).forStatusCode(200))) {
            consul.start();
            final String host = consul.getHost();
            final Integer port = consul.getMappedPort(CONSUL_PORT);
            final ConsulClient consulClient = new ConsulClient(host, port);
            final String namespace = "consul-gateway-it-" + System.nanoTime();
            final String otherNamespace = namespace + "-other";
            final String selectorId = "selector" + System.nanoTime();
            final String ruleId = "rule" + System.nanoTime();
            final String basePath = "/consul/gateway/" + selectorId;
            final AtomicReference<String> upstreamBody = new AtomicReference<>("created");
            final AtomicInteger upstreamHits = new AtomicInteger();
            final ConsulDataChangedListener adminListener = new ConsulDataChangedListener(consulClient);
            final DisposableServer upstream = upstreamServer(upstreamBody, upstreamHits);
            ShenyuGatewayTestServer gateway = null;
            ConsulInstanceRegisterRepository registry = new ConsulInstanceRegisterRepository();
            try {
                clearGatewayCaches(selectorId);
                gateway = ShenyuGatewayTestServer.start(namespace, host, port, adminListener, selectorId,
                        "127.0.0.1:" + upstream.port(), basePath);
                assertGatewayRouteLifecycle(adminListener, gateway, upstreamBody, upstreamHits, namespace,
                        otherNamespace, selectorId, ruleId, basePath);
                assertRegistryLifecycle(registry, consulClient, host, port);
            } finally {
                Optional.ofNullable(gateway).ifPresent(ShenyuGatewayTestServer::close);
                registry.close();
                upstream.disposeNow();
                consulClient.deleteKVValues(namespace);
                consulClient.deleteKVValues(otherNamespace);
                clearGatewayCaches(selectorId);
            }
        }
    }

    @Test
    void shouldSyncAdminChangesAndRegistryInstancesThroughRealConsul() {
        try (GenericContainer<?> consul = new GenericContainer<>(CONSUL_IMAGE)
                .withExposedPorts(CONSUL_PORT)
                .withCommand("agent", "-dev", "-client", "0.0.0.0")
                .waitingFor(Wait.forHttp("/v1/status/leader").forPort(CONSUL_PORT).forStatusCode(200))) {
            consul.start();
            final String host = consul.getHost();
            final Integer port = consul.getMappedPort(CONSUL_PORT);
            final ConsulClient consulClient = new ConsulClient(host, port);
            final String namespace = "consul-it-" + System.nanoTime();
            final String pluginName = "divide";
            final String selectorId = "selector-a";
            final String ruleId = "rule-a";

            final ConsulDataChangedListener adminListener = new ConsulDataChangedListener(consulClient);
            final RecordingPluginSubscriber subscriber = new RecordingPluginSubscriber();
            final ConsulSyncDataService syncService = new ConsulSyncDataService(shenyuConfig(namespace), consulClient,
                    consulConfig(host, port), subscriber, Collections.emptyList(), Collections.emptyList(),
                    Collections.emptyList(), Collections.emptyList());
            final ConsulInstanceRegisterRepository registry = new ConsulInstanceRegisterRepository();
            try {
                adminListener.onPluginChanged(List.of(pluginData(namespace, pluginName, "created")),
                        DataEventTypeEnum.CREATE);
                adminListener.onSelectorChanged(List.of(selectorData(namespace, pluginName, selectorId, "created")),
                        DataEventTypeEnum.CREATE);
                adminListener.onRuleChanged(List.of(ruleData(namespace, pluginName, selectorId, ruleId, "created")),
                        DataEventTypeEnum.CREATE);

                awaitUntilAsserted(() -> assertThat(subscriber.plugins).extracting(PluginData::getConfig)
                        .contains("created"));
                awaitUntilAsserted(() -> assertThat(subscriber.selectors).extracting(SelectorData::getId)
                        .contains(selectorId));
                awaitUntilAsserted(() -> assertThat(subscriber.rules).extracting(RuleData::getId).contains(ruleId));

                adminListener.onPluginChanged(List.of(pluginData(namespace, pluginName, "updated")),
                        DataEventTypeEnum.UPDATE);
                awaitUntilAsserted(() -> assertThat(subscriber.plugins).extracting(PluginData::getConfig)
                        .contains("updated"));

                adminListener.onPluginChanged(List.of(pluginData(namespace, pluginName, "deleted")),
                        DataEventTypeEnum.DELETE);
                awaitUntilAsserted(() -> assertThat(subscriber.removedPlugins).extracting(PluginData::getName)
                        .contains(pluginName));

                registry.init(registerConfig(host, port));
                registry.persistInstance(instance("shenyu-consul-it", "127.0.0.1", 9195));
                awaitUntilAsserted(() -> assertThat(registry.selectInstances("shenyu-consul-it"))
                        .extracting(InstanceEntity::getPort)
                        .contains(9195));
                registry.persistInstance(instance("shenyu-consul-it", "127.0.0.1", 9295));
                awaitUntilAsserted(() -> assertThat(registry.selectInstances("shenyu-consul-it"))
                        .extracting(InstanceEntity::getPort)
                        .contains(9295));
                registry.close();
                awaitUntilAsserted(() -> assertThat(consulClient.getHealthServices("shenyu-consul-it", false,
                        QueryParams.DEFAULT).getValue()).isEmpty());
            } finally {
                syncService.close();
                registry.close();
                consulClient.deleteKVValues(namespace);
            }
        }
    }

    private static void assertGatewayRouteLifecycle(final ConsulDataChangedListener adminListener,
                                                    final ShenyuGatewayTestServer gateway,
                                                    final AtomicReference<String> upstreamBody,
                                                    final AtomicInteger upstreamHits,
                                                    final String namespace,
                                                    final String otherNamespace,
                                                    final String selectorId,
                                                    final String ruleId,
                                                    final String basePath) throws Exception {
        awaitUntilAsserted(() -> assertThat(BaseDataCache.getInstance().obtainPluginData(PluginEnum.DIVIDE.getName()))
                .isNotNull());
        awaitUntilAsserted(() -> assertThat(UpstreamCacheManager.getInstance().findUpstreamListBySelectorId(selectorId))
                .hasSize(1));
        assertNoUpstreamHit(gateway, basePath + "/initial", upstreamHits);
        adminListener.onRuleChanged(List.of(ruleData(otherNamespace, selectorId, ruleId, basePath + "/initial")),
                DataEventTypeEnum.CREATE);
        assertNoUpstreamHit(gateway, basePath + "/initial", upstreamHits);
        assertThat(BaseDataCache.getInstance().obtainRuleData(selectorId)).isNull();
        adminListener.onRuleChanged(List.of(ruleData(namespace, selectorId, ruleId, basePath + "/initial")),
                DataEventTypeEnum.CREATE);
        awaitUntilAsserted(() -> assertThat(BaseDataCache.getInstance().obtainRuleData(selectorId))
                .extracting(RuleData::getId)
                .contains(ruleId));
        assertGatewayBody(gateway, basePath + "/initial", "created", upstreamHits);
        upstreamBody.set("updated");
        assertGatewayRuleUpdate(adminListener, gateway, upstreamHits, namespace, selectorId, ruleId, basePath);
    }

    private static void assertGatewayRuleUpdate(final ConsulDataChangedListener adminListener,
                                                final ShenyuGatewayTestServer gateway,
                                                final AtomicInteger upstreamHits,
                                                final String namespace,
                                                final String selectorId,
                                                final String ruleId,
                                                final String basePath) throws Exception {
        adminListener.onRuleChanged(List.of(ruleData(namespace, selectorId, ruleId, basePath + "/updated")),
                DataEventTypeEnum.UPDATE);
        awaitUntilAsserted(() -> assertThat(onlyRule(selectorId).getConditionDataList())
                .extracting(ConditionData::getParamValue)
                .containsExactly(basePath + "/updated"));
        assertNoUpstreamHit(gateway, basePath + "/initial", upstreamHits);
        assertGatewayBody(gateway, basePath + "/updated", "updated", upstreamHits);
        adminListener.onRuleChanged(List.of(ruleData(namespace, selectorId, ruleId, basePath + "/updated")),
                DataEventTypeEnum.DELETE);
        awaitUntilAsserted(() -> assertThat(BaseDataCache.getInstance().obtainRuleData(selectorId)).isNull());
        assertNoUpstreamHit(gateway, basePath + "/updated", upstreamHits);
    }

    private static void assertRegistryLifecycle(final ConsulInstanceRegisterRepository registry,
                                                final ConsulClient consulClient,
                                                final String host,
                                                final Integer port) {
        registry.init(registerConfig(host, port));
        registry.persistInstance(instance("shenyu-consul-it", "127.0.0.1", 9195));
        awaitUntilAsserted(() -> assertThat(registry.selectInstances("shenyu-consul-it"))
                .extracting(InstanceEntity::getPort)
                .contains(9195));
        registry.persistInstance(instance("shenyu-consul-it", "127.0.0.1", 9295));
        awaitUntilAsserted(() -> assertThat(registry.selectInstances("shenyu-consul-it"))
                .extracting(InstanceEntity::getPort)
                .contains(9295));
        registry.close();
        awaitUntilAsserted(() -> assertThat(consulClient.getHealthServices("shenyu-consul-it", false,
                QueryParams.DEFAULT).getValue()).isEmpty());
    }

    private static DisposableServer upstreamServer(final AtomicReference<String> upstreamBody,
                                                   final AtomicInteger upstreamHits) {
        return HttpServer.create()
                .host("127.0.0.1")
                .port(0)
                .handle((request, response) -> {
                    upstreamHits.incrementAndGet();
                    response.header(HttpHeaders.CONTENT_TYPE, MediaType.TEXT_PLAIN_VALUE);
                    return response.sendString(Mono.just(upstreamBody.get() + ":" + request.path()));
                })
                .bindNow();
    }

    private static void assertGatewayBody(final ShenyuGatewayTestServer gateway,
                                          final String path,
                                          final String expected,
                                          final AtomicInteger upstreamHits) throws Exception {
        final int before = upstreamHits.get();
        final HttpResponse<String> response = gateway.get(path);
        assertThat(response.body()).isEqualTo(expected + ":" + path.substring(1));
        assertThat(upstreamHits.get()).isEqualTo(before + 1);
    }

    private static void assertNoUpstreamHit(final ShenyuGatewayTestServer gateway,
                                            final String path,
                                            final AtomicInteger upstreamHits) throws Exception {
        final int before = upstreamHits.get();
        final HttpResponse<String> response = gateway.get(path);
        assertThat(response.body()).doesNotContain("created", "updated");
        assertThat(upstreamHits.get()).isEqualTo(before);
    }

    private static RuleData onlyRule(final String selectorId) {
        final List<RuleData> rules = BaseDataCache.getInstance().obtainRuleData(selectorId);
        assertThat(rules).hasSize(1);
        return rules.get(0);
    }

    private static void clearGatewayCaches(final String selectorId) {
        BaseDataCache.getInstance().cleanPluginData();
        BaseDataCache.getInstance().cleanSelectorData();
        BaseDataCache.getInstance().cleanRuleData();
        MatchDataCache.getInstance().cleanSelectorData();
        MatchDataCache.getInstance().cleanRuleDataData();
        UpstreamCacheManager.getInstance().removeByKey(selectorId);
    }

    private static ShenyuConfig shenyuConfig(final String namespace) {
        final ShenyuConfig shenyuConfig = new ShenyuConfig();
        shenyuConfig.setNamespace(namespace);
        return shenyuConfig;
    }

    private static ConsulConfig consulConfig(final String host, final Integer port) {
        final ConsulConfig consulConfig = new ConsulConfig();
        consulConfig.setUrl("http://" + host + ":" + port);
        consulConfig.setWaitTime(1000);
        consulConfig.setWatchDelay(25);
        return consulConfig;
    }

    private static RegisterConfig registerConfig(final String host, final Integer port) {
        final Properties properties = new Properties();
        properties.setProperty("checkTtl", "2");
        properties.setProperty("waitTime", "1");
        properties.setProperty("watchDelay", "1");
        final RegisterConfig registerConfig = new RegisterConfig();
        registerConfig.setServerLists(host + ":" + port);
        registerConfig.setProps(properties);
        return registerConfig;
    }

    private static PluginData pluginData(final String namespace, final String pluginName, final String config) {
        return PluginData.builder()
                .id(pluginName)
                .name(pluginName)
                .enabled(true)
                .config(config)
                .namespaceId(namespace)
                .build();
    }

    private static PluginData gatewayPluginData(final String namespace) {
        return PluginData.builder()
                .id(PluginEnum.DIVIDE.getName())
                .name(PluginEnum.DIVIDE.getName())
                .enabled(true)
                .sort(PluginEnum.DIVIDE.getCode())
                .namespaceId(namespace)
                .build();
    }

    private static SelectorData selectorData(final String namespace,
                                             final String pluginName,
                                             final String selectorId,
                                             final String handle) {
        return SelectorData.builder()
                .id(selectorId)
                .name(selectorId)
                .pluginName(pluginName)
                .enabled(true)
                .handle(handle)
                .namespaceId(namespace)
                .build();
    }

    private static SelectorData gatewaySelectorData(final String namespace,
                                                    final String selectorId,
                                                    final String basePath) {
        return SelectorData.builder()
                .id(selectorId)
                .name(selectorId)
                .pluginName(PluginEnum.DIVIDE.getName())
                .enabled(true)
                .logged(false)
                .continued(true)
                .sort(1)
                .type(SelectorTypeEnum.CUSTOM_FLOW.getCode())
                .matchMode(MatchModeEnum.AND.getCode())
                .conditionList(List.of(uriCondition(OperatorEnum.STARTS_WITH.getAlias(), basePath)))
                .namespaceId(namespace)
                .build();
    }

    private static RuleData ruleData(final String namespace,
                                     final String pluginName,
                                     final String selectorId,
                                     final String ruleId,
                                     final String handle) {
        return RuleData.builder()
                .id(ruleId)
                .name(ruleId)
                .pluginName(pluginName)
                .selectorId(selectorId)
                .enabled(true)
                .handle(handle)
                .namespaceId(namespace)
                .build();
    }

    private static RuleData ruleData(final String namespace,
                                     final String selectorId,
                                     final String ruleId,
                                     final String path) {
        final DivideRuleHandle handle = DivideRuleHandle.newInstance();
        handle.setRetry(0);
        return RuleData.builder()
                .id(ruleId)
                .name(ruleId)
                .pluginName(PluginEnum.DIVIDE.getName())
                .selectorId(selectorId)
                .enabled(true)
                .loged(false)
                .sort(1)
                .matchMode(MatchModeEnum.AND.getCode())
                .handle(GsonUtils.getInstance().toJson(handle))
                .conditionDataList(List.of(uriCondition(OperatorEnum.EQ.getAlias(), path)))
                .namespaceId(namespace)
                .build();
    }

    private static ConditionData uriCondition(final String operator, final String value) {
        final ConditionData conditionData = new ConditionData();
        conditionData.setParamType(ParamTypeEnum.URI.getName());
        conditionData.setOperator(operator);
        conditionData.setParamValue(value);
        return conditionData;
    }

    private static DiscoverySyncData discoverySyncData(final String namespace,
                                                       final String selectorId,
                                                       final String upstreamUrl) {
        final DiscoveryUpstreamData upstreamData = new DiscoveryUpstreamData();
        upstreamData.setId(selectorId + "-upstream");
        upstreamData.setProtocol("http://");
        upstreamData.setUrl(upstreamUrl);
        upstreamData.setStatus(0);
        upstreamData.setWeight(100);
        upstreamData.setNamespaceId(namespace);
        final DiscoverySyncData syncData = new DiscoverySyncData();
        syncData.setSelectorId(selectorId);
        syncData.setSelectorName(selectorId);
        syncData.setPluginName(PluginEnum.DIVIDE.getName());
        syncData.setNamespaceId(namespace);
        syncData.setUpstreamDataList(List.of(upstreamData));
        return syncData;
    }

    private static InstanceEntity instance(final String appName, final String host, final int port) {
        return InstanceEntity.builder()
                .appName(appName)
                .host(host)
                .port(port)
                .build();
    }

    private static void awaitUntilAsserted(final Runnable assertion) {
        final long deadline = System.nanoTime() + Duration.ofSeconds(10).toNanos();
        AssertionError last = null;
        while (System.nanoTime() < deadline) {
            try {
                assertion.run();
                return;
            } catch (AssertionError ex) {
                last = ex;
                sleep();
            }
        }
        if (Objects.nonNull(last)) {
            throw last;
        }
    }

    private static void sleep() {
        try {
            Thread.sleep(100L);
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException(ex);
        }
    }

    private static final class ShenyuGatewayTestServer implements AutoCloseable {

        private final GenericApplicationContext applicationContext;

        private final ConsulSyncDataService syncService;

        private final DisposableServer server;

        private ShenyuGatewayTestServer(final GenericApplicationContext applicationContext,
                                        final ConsulSyncDataService syncService,
                                        final DisposableServer server) {
            this.applicationContext = applicationContext;
            this.syncService = syncService;
            this.server = server;
        }

        private static ShenyuGatewayTestServer start(final String namespace,
                                                     final String consulHost,
                                                     final Integer consulPort,
                                                     final ConsulDataChangedListener adminListener,
                                                     final String selectorId,
                                                     final String upstreamUrl,
                                                     final String basePath) throws Exception {
            final ShenyuConfig shenyuConfig = shenyuConfig(namespace);
            final GenericApplicationContext applicationContext = new GenericApplicationContext();
            applicationContext.registerBean(ShenyuConfig.class, () -> shenyuConfig);
            applicationContext.registerBean(ShenyuResult.class, DefaultShenyuResult::new);
            applicationContext.refresh();
            SpringBeanUtils.getInstance().setApplicationContext(applicationContext);

            final ShenyuWebHandler handler = new ShenyuWebHandler(plugins(), mock(ShenyuLoaderService.class),
                    shenyuConfig);
            final ApplicationEventPublisher eventPublisher = event -> {
                if (event instanceof PluginHandlerEvent) {
                    handler.onApplicationEvent((PluginHandlerEvent) event);
                }
            };
            final CommonPluginDataSubscriber pluginSubscriber = new CommonPluginDataSubscriber(
                    pluginDataHandlers(), eventPublisher, shenyuConfig.getSelectorMatchCache(),
                    shenyuConfig.getRuleMatchCache());
            final CommonDiscoveryUpstreamDataSubscriber upstreamSubscriber = new CommonDiscoveryUpstreamDataSubscriber(
                    discoveryUpstreamDataHandlers());
            final ConsulClient consulClient = new ConsulClient(consulHost, consulPort);
            final ConsulSyncDataService syncService = new ConsulSyncDataService(shenyuConfig, consulClient,
                    consulConfig(consulHost, consulPort), pluginSubscriber, Collections.emptyList(),
                    Collections.emptyList(), Collections.emptyList(), List.of(upstreamSubscriber));
            final HttpHandler httpHandler = new HttpWebHandlerAdapter(handler);
            final DisposableServer server = HttpServer.create()
                    .host("127.0.0.1")
                    .port(0)
                    .handle(new ReactorHttpHandlerAdapter(httpHandler))
                    .bindNow();
            final ShenyuGatewayTestServer gateway = new ShenyuGatewayTestServer(applicationContext, syncService,
                    server);
            final ConsulDataChangedInit initializer = new ConsulDataChangedInit(consulClient);
            ReflectionTestUtils.setField(initializer, "syncDataService", new GatewayAdminSyncDataService(
                    adminListener, namespace, selectorId, upstreamUrl, basePath));
            initializer.run();
            return gateway;
        }

        private static List<ShenyuPlugin> plugins() {
            final Map<String, ShenyuContextDecorator> decorators = Map.of(RpcTypeEnum.HTTP.getName(),
                    new DivideShenyuContextDecorator());
            final Map<String, MessageWriter> writers = Map.of(RpcTypeEnum.HTTP.getName(),
                    new NettyClientMessageWriter());
            return List.of(
                    new GlobalPlugin(new DefaultShenyuContextBuilder(decorators)),
                    new DividePlugin(),
                    new URIPlugin(),
                    new NettyHttpClientPlugin(HttpClient.create(), Constants.BYTES_PER_MB),
                    new ResponsePlugin(writers));
        }

        private static List<PluginDataHandler> pluginDataHandlers() {
            return List.of(new DividePluginDataHandler());
        }

        private static List<DiscoveryUpstreamDataHandler> discoveryUpstreamDataHandlers() {
            return List.of(new DivideUpstreamDataHandler());
        }

        private HttpResponse<String> get(final String path) throws Exception {
            final HttpRequest request = HttpRequest.newBuilder(URI.create("http://127.0.0.1:"
                            + server.port() + path))
                    .timeout(Duration.ofSeconds(5))
                    .GET()
                    .build();
            return HTTP_CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
        }

        @Override
        public void close() {
            syncService.close();
            server.disposeNow();
            applicationContext.close();
        }
    }

    private static final class GatewayAdminSyncDataService implements SyncDataService {

        private final ConsulDataChangedListener adminListener;

        private final String namespace;

        private final String selectorId;

        private final String upstreamUrl;

        private final String basePath;

        private GatewayAdminSyncDataService(final ConsulDataChangedListener adminListener,
                                            final String namespace,
                                            final String selectorId,
                                            final String upstreamUrl,
                                            final String basePath) {
            this.adminListener = adminListener;
            this.namespace = namespace;
            this.selectorId = selectorId;
            this.upstreamUrl = upstreamUrl;
            this.basePath = basePath;
        }

        @Override
        public boolean syncAll(final DataEventTypeEnum type) {
            adminListener.onPluginChanged(List.of(gatewayPluginData(namespace)), type);
            adminListener.onSelectorChanged(List.of(gatewaySelectorData(namespace, selectorId, basePath)), type);
            adminListener.onDiscoveryUpstreamChanged(List.of(discoverySyncData(namespace, selectorId, upstreamUrl)),
                    type);
            return true;
        }

        @Override
        public boolean syncAllByNamespaceId(final DataEventTypeEnum type, final String namespaceId) {
            return syncAll(type);
        }

        @Override
        public boolean syncPluginData(final String id) {
            return syncAll(DataEventTypeEnum.UPDATE);
        }

        @Override
        public boolean syncPluginData(final String namespaceId, final String pluginId) {
            return syncAll(DataEventTypeEnum.UPDATE);
        }
    }

    private static final class RecordingPluginSubscriber implements org.apache.shenyu.sync.data.api.PluginDataSubscriber {

        private final Queue<PluginData> plugins = new ConcurrentLinkedQueue<>();

        private final Queue<PluginData> removedPlugins = new ConcurrentLinkedQueue<>();

        private final Queue<SelectorData> selectors = new ConcurrentLinkedQueue<>();

        private final Queue<RuleData> rules = new ConcurrentLinkedQueue<>();

        @Override
        public void onSubscribe(final PluginData pluginData) {
            plugins.add(pluginData);
        }

        @Override
        public void unSubscribe(final PluginData pluginData) {
            removedPlugins.add(pluginData);
        }

        @Override
        public void onSelectorSubscribe(final SelectorData selectorData) {
            selectors.add(selectorData);
        }

        @Override
        public void onRuleSubscribe(final RuleData ruleData) {
            rules.add(ruleData);
        }
    }
}
