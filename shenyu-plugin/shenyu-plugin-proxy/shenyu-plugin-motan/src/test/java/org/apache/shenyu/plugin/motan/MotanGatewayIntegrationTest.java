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

package org.apache.shenyu.plugin.motan;

import com.weibo.api.motan.config.ProtocolConfig;
import com.weibo.api.motan.config.RefererConfig;
import com.weibo.api.motan.config.RegistryConfig;
import com.weibo.api.motan.config.ServiceConfig;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.ConditionData;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.enums.MatchModeEnum;
import org.apache.shenyu.common.enums.OperatorEnum;
import org.apache.shenyu.common.enums.ParamTypeEnum;
import org.apache.shenyu.common.enums.SelectorTypeEnum;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.context.ShenyuContext;
import org.apache.shenyu.plugin.api.result.DefaultShenyuResult;
import org.apache.shenyu.plugin.api.result.ShenyuResult;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.motan.cache.ApplicationConfigCache;
import org.apache.shenyu.plugin.motan.constant.MotanPluginConstants;
import org.apache.shenyu.plugin.motan.handler.MotanPluginDataHandler;
import org.apache.shenyu.plugin.motan.proxy.MotanProxyService;
import org.apache.shenyu.plugin.motan.response.MotanMessageWriter;
import org.apache.shenyu.plugin.response.ResponsePlugin;
import org.apache.shenyu.plugin.response.strategy.MessageWriter;
import org.apache.shenyu.web.handler.ShenyuWebHandler;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.core.io.buffer.DataBufferUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.http.server.reactive.ReactorHttpHandlerAdapter;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.adapter.WebHttpHandlerBuilder;
import reactor.core.publisher.Mono;
import reactor.netty.DisposableServer;
import reactor.netty.http.client.HttpClient;
import reactor.netty.http.server.HttpServer;

import java.io.IOException;
import java.net.ServerSocket;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Gateway-level Motan integration tests using a real Motan provider.
 */
public final class MotanGatewayIntegrationTest {

    private static final String GROUP = "motan-shenyu-rpc";

    private GenericApplicationContext applicationContext;

    private ServiceConfig<EchoService> firstProvider;

    private ServiceConfig<EchoService> secondProvider;

    @BeforeEach
    public void setUp() {
        cleanCaches();
        applicationContext = new GenericApplicationContext();
        applicationContext.registerBean(ShenyuConfig.class, ShenyuConfig::new);
        applicationContext.registerBean(ShenyuResult.class, DefaultShenyuResult::new);
        registerLegacySelectorTrie(applicationContext);
        applicationContext.refresh();
        SpringBeanUtils.getInstance().setApplicationContext(applicationContext);
    }

    @AfterEach
    public void tearDown() {
        if (Objects.nonNull(firstProvider)) {
            firstProvider.unexport();
        }
        if (Objects.nonNull(secondProvider)) {
            secondProvider.unexport();
        }
        cleanCaches();
        SpringBeanUtils.getInstance().setApplicationContext(null);
        if (Objects.nonNull(applicationContext)) {
            applicationContext.close();
        }
    }

    @Test
    public void gatewayInvokesRealMotanProviderThroughDirectUrl() {
        int port = availablePort();
        firstProvider = exportProvider(port, value -> "first:" + value);
        MotanPlugin plugin = new MotanPlugin(new MotanProxyService());
        MetaData metaData = metadata();
        SelectorData selectorData = cacheMotanRoute(plugin, port, metaData.getPath());

        try (Gateway gateway = Gateway.start(plugin, responsePlugin(), metaData)) {
            GatewayResponse response = gateway.exchange(HttpMethod.POST, metaData.getPath(), "{\"value\":\"alpha\"}");

            assertThat(response.getStatusCode()).isEqualTo(200);
            assertThat(response.getBody()).isEqualTo("first:alpha");
            RefererConfig<?> reference = ApplicationConfigCache.getInstance()
                    .get(ApplicationConfigCache.getInstance().generateUpstreamCacheKey(selectorData.getId(), metaData.getPath(),
                            ApplicationConfigCache.getInstance().getUpstream(selectorData.getId())));
            assertThat(reference.getRef()).isNotNull();
        }
    }

    @Test
    public void gatewayRejectsInvalidBodyAndMetadataBeforeRpc() {
        int port = availablePort();
        firstProvider = exportProvider(port, value -> "unused:" + value);
        MotanPlugin plugin = new MotanPlugin(new MotanProxyService());
        MetaData metaData = metadata();
        cacheMotanRoute(plugin, port, metaData.getPath());

        try (Gateway gateway = Gateway.start(plugin, responsePlugin(), metaData)) {
            GatewayResponse emptyBody = gateway.exchange(HttpMethod.POST, metaData.getPath(), null);

            assertThat(emptyBody.getStatusCode()).isEqualTo(500);
            assertThat(emptyBody.getBody()).contains(MotanPluginConstants.MOTAN_HAVE_BODY_PARAM_MESSAGE);
        }

        MetaData invalidMetaData = metadata();
        invalidMetaData.setMethodName("");
        cacheMotanRoute(plugin, port, invalidMetaData.getPath());
        try (Gateway gateway = Gateway.start(plugin, responsePlugin(), invalidMetaData)) {
            GatewayResponse invalidMetadata = gateway.exchange(HttpMethod.POST, invalidMetaData.getPath(), "{\"value\":\"alpha\"}");

            assertThat(invalidMetadata.getStatusCode()).isEqualTo(500);
            assertThat(invalidMetadata.getBody()).contains("Meta data error");
        }
    }

    @Test
    public void selectorRefreshSwitchesDirectUrlAndCleanlyClosesOldReference() {
        int firstPort = availablePort();
        int secondPort = availablePort();
        firstProvider = exportProvider(firstPort, value -> "first:" + value);
        secondProvider = exportProvider(secondPort, value -> "second:" + value);
        MotanPlugin plugin = new MotanPlugin(new MotanProxyService());
        MetaData metaData = metadata();
        SelectorData selectorData = cacheMotanRoute(plugin, firstPort, metaData.getPath());
        MotanPluginDataHandler handler = new MotanPluginDataHandler();

        try (Gateway gateway = Gateway.start(plugin, responsePlugin(), metaData)) {
            GatewayResponse first = gateway.exchange(HttpMethod.POST, metaData.getPath(), "{\"value\":\"alpha\"}");
            assertThat(first.getBody()).isEqualTo("first:alpha");

            MotanUpstreamSnapshot firstSnapshot = upstreamSnapshot(selectorData, metaData);
            final RefererConfig<?> oldReference = ApplicationConfigCache.getInstance().get(firstSnapshot.cacheKey);

            selectorData.setHandle(upstreamHandle(secondPort));
            handler.handlerSelector(selectorData);
            assertThat(rawRef(oldReference)).isNull();

            GatewayResponse second = gateway.exchange(HttpMethod.POST, metaData.getPath(), "{\"value\":\"beta\"}");
            assertThat(second.getBody()).isEqualTo("second:beta");

            BaseDataCache.getInstance().removeSelectData(selectorData);
            handler.removeSelector(selectorData);

            assertThat(ApplicationConfigCache.getInstance().get(firstSnapshot.cacheKey).getServiceInterface()).isNull();
        }
    }

    private static void registerLegacySelectorTrie(final GenericApplicationContext context) {
        try {
            Class<?> trieClass = Class.forName("org.apache.shenyu.plugin.base.trie.ShenyuTrie");
            registerLegacyTrie(context, trieClass, "shenyuSelectorTrie");
            registerLegacyTrie(context, trieClass, "shenyuRuleTrie");
        } catch (final ClassNotFoundException ignored) {
            // ShenYu 2.7.2 no longer requires the legacy trie beans.
        } catch (final ReflectiveOperationException ex) {
            throw new IllegalStateException("Failed to create legacy trie beans", ex);
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static void registerLegacyTrie(final GenericApplicationContext context, final Class<?> trieClass, final String beanName)
            throws ReflectiveOperationException {
        Object trie = trieClass.getConstructor(Long.class, String.class).newInstance(1024L, "pathPattern");
        context.registerBean(beanName, (Class) trieClass, () -> trie);
    }

    private static void cleanCaches() {
        ApplicationConfigCache.getInstance().invalidateAll();
        BaseDataCache.getInstance().cleanPluginData();
        BaseDataCache.getInstance().cleanSelectorData();
        BaseDataCache.getInstance().cleanRuleData();
    }

    private static ResponsePlugin responsePlugin() {
        Map<String, MessageWriter> writerMap = new LinkedHashMap<>();
        MotanMessageWriter writer = new MotanMessageWriter();
        writer.supportTypes().forEach(type -> writerMap.put(type, writer));
        return new ResponsePlugin(writerMap);
    }

    private static SelectorData cacheMotanRoute(final ShenyuPlugin plugin, final int providerPort, final String path) {
        PluginData pluginData = PluginData.builder()
                .id(id("plugin"))
                .name(plugin.named())
                .enabled(true)
                .sort(plugin.getOrder())
                .build();
        BaseDataCache.getInstance().cachePluginData(pluginData);
        SelectorData selectorData = SelectorData.builder()
                .id(id("selector"))
                .pluginName(plugin.named())
                .name("motan-direct-selector")
                .enabled(true)
                .logged(false)
                .continued(false)
                .sort(1)
                .matchMode(MatchModeEnum.AND.getCode())
                .type(SelectorTypeEnum.CUSTOM_FLOW.getCode())
                .matchRestful(false)
                .handle(upstreamHandle(providerPort))
                .conditionList(Collections.singletonList(uriCondition(path)))
                .build();
        BaseDataCache.getInstance().cacheSelectData(selectorData);
        new MotanPluginDataHandler().handlerPlugin(new PluginData("motan-plugin", plugin.named(),
                "{\"registerProtocol\":\"local\",\"registerAddress\":\"127.0.0.1:0\",\"threadpool\":\"cached\",\"corethreads\":0,\"threads\":8,\"queues\":0}",
                "0", true, null));
        new MotanPluginDataHandler().handlerSelector(selectorData);
        return selectorData;
    }

    private static String upstreamHandle(final int providerPort) {
        return "{\"protocol\":\"motan2\",\"directUrl\":\"127.0.0.1:" + providerPort + "\",\"serialization\":\"simple\"}";
    }

    private static ConditionData uriCondition(final String pattern) {
        ConditionData conditionData = new ConditionData();
        conditionData.setParamType(ParamTypeEnum.URI.getName());
        conditionData.setOperator(OperatorEnum.MATCH.getAlias());
        conditionData.setParamName("/");
        conditionData.setParamValue(pattern);
        return conditionData;
    }

    private static MetaData metadata() {
        MetaData metaData = new MetaData();
        metaData.setId(id("metadata"));
        metaData.setAppName("motan-test");
        metaData.setContextPath("/motan");
        metaData.setPath("/motan/echo/" + id("path"));
        metaData.setRpcType(MotanPluginConstants.MOTAN);
        metaData.setServiceName(EchoService.class.getName());
        metaData.setMethodName("echo");
        metaData.setParameterTypes("java.lang.String");
        metaData.setRpcExt("{\"group\":\"" + GROUP + "\",\"rpcProtocol\":\"motan2\",\"timeout\":3000}");
        metaData.setEnabled(true);
        return metaData;
    }

    private static ServiceConfig<EchoService> exportProvider(final int port, final EchoService service) {
        ProtocolConfig protocolConfig = new ProtocolConfig();
        protocolConfig.setId("motan2");
        protocolConfig.setName("motan2");
        protocolConfig.setSerialization("simple");
        RegistryConfig registryConfig = new RegistryConfig();
        registryConfig.setRegProtocol("local");
        registryConfig.setAddress("127.0.0.1:0");
        registryConfig.setRegister(false);
        ServiceConfig<EchoService> serviceConfig = new ServiceConfig<>();
        serviceConfig.setInterface(EchoService.class);
        serviceConfig.setRef(service);
        serviceConfig.setGroup(GROUP);
        serviceConfig.setVersion("1.0");
        serviceConfig.setExport("motan2:" + port);
        serviceConfig.setProtocol(protocolConfig);
        serviceConfig.setRegistry(registryConfig);
        serviceConfig.export();
        return serviceConfig;
    }

    private static int availablePort() {
        try (ServerSocket socket = new ServerSocket(0)) {
            return socket.getLocalPort();
        } catch (IOException e) {
            throw new IllegalStateException("Failed to allocate a local port", e);
        }
    }

    private static String id(final String prefix) {
        return prefix + '-' + UUID.randomUUID();
    }

    private static MotanUpstreamSnapshot upstreamSnapshot(final SelectorData selectorData, final MetaData metaData) {
        return new MotanUpstreamSnapshot(ApplicationConfigCache.getInstance().generateUpstreamCacheKey(selectorData.getId(), metaData.getPath(),
                ApplicationConfigCache.getInstance().getUpstream(selectorData.getId())));
    }

    private static Object rawRef(final RefererConfig<?> reference) {
        try {
            return FieldUtils.readDeclaredField(reference, "ref", true);
        } catch (IllegalAccessException e) {
            throw new IllegalStateException("Failed to read Motan reference", e);
        }
    }

    /**
     * Echo service exported by Motan.
     */
    public interface EchoService {

        /**
         * Echo request value.
         *
         * @param value request value
         * @return response value
         */
        String echo(String value);
    }

    private interface GatewayResponse {

        int getStatusCode();

        String getBody();
    }

    private static final class MotanUpstreamSnapshot {

        private final String cacheKey;

        private MotanUpstreamSnapshot(final String cacheKey) {
            this.cacheKey = cacheKey;
        }
    }

    private static final class Gateway implements AutoCloseable {

        private static final Duration REQUEST_TIMEOUT = Duration.ofSeconds(10);

        private final DisposableServer server;

        private final WebClient webClient;

        private Gateway(final DisposableServer server) {
            this.server = server;
            this.webClient = WebClient.builder()
                    .baseUrl("http://" + server.host() + ':' + server.port())
                    .clientConnector(new ReactorClientHttpConnector(HttpClient.create()))
                    .build();
        }

        private static Gateway start(final ShenyuPlugin motanPlugin, final ShenyuPlugin responsePlugin, final MetaData metaData) {
            HttpHandler httpHandler = WebHttpHandlerBuilder.webHandler(new ShenyuWebHandler(
                            List.of(new BodyCapturePlugin(metaData), motanPlugin, responsePlugin), null, new ShenyuConfig()))
                    .build();
            DisposableServer server = HttpServer.create()
                    .host("127.0.0.1")
                    .port(0)
                    .handle(new ReactorHttpHandlerAdapter(httpHandler))
                    .bindNow();
            return new Gateway(server);
        }

        private GatewayResponse exchange(final HttpMethod method, final String path, final String body) {
            WebClient.RequestBodySpec request = webClient.method(method).uri(path);
            WebClient.RequestHeadersSpec<?> headersSpec = Objects.isNull(body) ? request : request.bodyValue(body);
            return headersSpec.exchangeToMono(response -> response.toEntity(String.class))
                    .map(entity -> new HttpGatewayResponse(entity.getStatusCode().value(), HttpHeaders.readOnlyHttpHeaders(entity.getHeaders()),
                            Objects.requireNonNullElse(entity.getBody(), "")))
                    .block(REQUEST_TIMEOUT);
        }

        @Override
        public void close() {
            server.disposeNow();
        }
    }

    private static final class BodyCapturePlugin implements ShenyuPlugin {

        private final MetaData metaData;

        private BodyCapturePlugin(final MetaData metaData) {
            this.metaData = metaData;
        }

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            ShenyuContext context = new ShenyuContext();
            context.setRpcType(MotanPluginConstants.MOTAN);
            context.setHttpMethod(exchange.getRequest().getMethod().name());
            context.setPath(exchange.getRequest().getURI().getRawPath());
            context.setContextPath(metaData.getContextPath());
            context.setRealUrl(exchange.getRequest().getURI().toString());
            context.setStartDateTime(LocalDateTime.now());
            exchange.getAttributes().put(Constants.CONTEXT, context);
            exchange.getAttributes().put(Constants.META_DATA, metaData);
            return DataBufferUtils.join(exchange.getRequest().getBody())
                    .defaultIfEmpty(exchange.getResponse().bufferFactory().wrap(new byte[0]))
                    .flatMap(buffer -> {
                        byte[] bytes = new byte[buffer.readableByteCount()];
                        buffer.read(bytes);
                        DataBufferUtils.release(buffer);
                        exchange.getAttributes().put(Constants.PARAM_TRANSFORM, new String(bytes, StandardCharsets.UTF_8));
                        return chain.execute(exchange);
                    });
        }

        @Override
        public int getOrder() {
            return 0;
        }

        @Override
        public String named() {
            return "motan-test-body-capture";
        }
    }

    private static final class HttpGatewayResponse implements GatewayResponse {

        private final int statusCode;

        @SuppressWarnings("unused")
        private final HttpHeaders headers;

        private final String body;

        private HttpGatewayResponse(final int statusCode, final HttpHeaders headers, final String body) {
            this.statusCode = statusCode;
            this.headers = headers;
            this.body = body;
        }

        @Override
        public int getStatusCode() {
            return statusCode;
        }

        @Override
        public String getBody() {
            return body;
        }
    }
}
