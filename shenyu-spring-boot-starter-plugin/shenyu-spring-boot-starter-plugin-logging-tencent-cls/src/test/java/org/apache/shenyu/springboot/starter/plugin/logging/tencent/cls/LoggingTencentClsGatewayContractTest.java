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

package org.apache.shenyu.springboot.starter.plugin.logging.tencent.cls;

import com.google.common.util.concurrent.SettableFuture;
import com.tencentcloudapi.cls.producer.AsyncProducerClient;
import com.tencentcloudapi.cls.producer.common.LogItem;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.utils.Singleton;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.apache.shenyu.plugin.tencent.cls.LoggingTencentClsPlugin;
import org.apache.shenyu.plugin.tencent.cls.client.TencentClsLogCollectClient;
import org.apache.shenyu.plugin.tencent.cls.collector.TencentClsSlsLogCollector;
import org.apache.shenyu.plugin.tencent.cls.config.TencentLogCollectConfig;
import org.apache.shenyu.plugin.tencent.cls.handler.LoggingTencentClsPluginDataHandler;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyString;

/**
 * Credential-free gateway-to-Tencent-CLS boundary contract test.
 */
public final class LoggingTencentClsGatewayContractTest {

    /**
     * Cleanup collector and cached fixture data.
     *
     * @throws Exception exception
     */
    @AfterEach
    public void tearDown() throws Exception {
        TencentClsSlsLogCollector.getInstance().close();
        GatewayFixtures.cleanBaseDataCache();
    }

    /**
     * Gateway traffic reaches the local SDK boundary with status, headers, and body fields.
     *
     * @throws Exception exception
     */
    @Test
    public void testGatewayTrafficReachesTencentProducerBoundary() throws Exception {
        CountDownLatch sent = new CountDownLatch(1);
        AtomicReference<List<LogItem>> capturedLogs = new AtomicReference<>();
        AtomicReference<String> capturedTopic = new AtomicReference<>();
        installTencentProducer(sent, capturedLogs, capturedTopic, "topic", false);
        startCollector(logConfig("topic"));

        assertGatewayResponse("/contract?source=tencent", "tencent-response-body");

        Assertions.assertTrue(sent.await(3, TimeUnit.SECONDS));
        String payload = capturedLogs.get().get(0).mContents.toString();
        Assertions.assertEquals("topic", capturedTopic.get());
        Assertions.assertTrue(payload.contains("status"), payload);
        Assertions.assertTrue(payload.contains("202"), payload);
        Assertions.assertTrue(payload.contains("Content-Type"), payload);
        Assertions.assertTrue(payload.contains("tencent-response-body"), payload);
        Assertions.assertTrue(payload.contains("/contract?source=tencent"), payload);
    }

    /**
     * SDK send failures and config updates keep the gateway path stable.
     *
     * @throws Exception exception
     */
    @Test
    public void testSendFailureConfigUpdateAndRepeatedStart() throws Exception {
        CountDownLatch failedSend = new CountDownLatch(1);
        installTencentProducer(failedSend, new AtomicReference<>(), new AtomicReference<>(), "topic-fail", true);
        startCollector(logConfig("topic-fail"));

        assertGatewayResponse("/contract?source=tencent-failure", "tencent-response-body");
        Assertions.assertTrue(failedSend.await(3, TimeUnit.SECONDS));

        CountDownLatch updatedSend = new CountDownLatch(1);
        AtomicReference<String> capturedTopic = new AtomicReference<>();
        installTencentProducer(updatedSend, new AtomicReference<>(), capturedTopic, "topic-updated", false);
        TencentLogCollectConfig.INSTANCE.setTencentClsLogConfig(logConfig("topic-updated"));
        TencentClsSlsLogCollector.getInstance().start();

        assertGatewayResponse("/contract?source=tencent-updated", "tencent-response-body");
        Assertions.assertTrue(updatedSend.await(3, TimeUnit.SECONDS));
        Assertions.assertEquals("topic-updated", capturedTopic.get());
    }

    private void assertGatewayResponse(final String path, final String body) {
        ShenyuGatewayTestServer.contextRunner()
                .withUserConfiguration(LoggingTencentClsPluginConfiguration.class)
                .withBean(ShenyuConfig.class, this::shenyuConfig)
                .withBean(RemoteAddressResolver.class, TestRemoteAddressResolver::new)
                .run(context -> {
                    SpringBeanUtils.getInstance().setApplicationContext(context);
                    Singleton.INST.single(ShenyuConfig.class, context.getBean(ShenyuConfig.class));
                    Assertions.assertTrue(context.getBean(ShenyuPlugin.class) instanceof LoggingTencentClsPlugin);
                    ShenyuPlugin loggingPlugin = new RouteBypassTencentPlugin();
                    TerminalResponsePlugin terminal = TerminalResponsePlugin.response(HttpStatus.ACCEPTED,
                            body, MediaType.TEXT_PLAIN);
                    try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Collections.singletonList(loggingPlugin),
                            terminal)) {
                        GatewayResponse response = server.get(path);
                        Assertions.assertEquals(HttpStatus.ACCEPTED.value(), response.getStatusCode());
                        Assertions.assertEquals(body, response.getBody());
                    }
                });
    }

    private void startCollector(final TencentLogCollectConfig.TencentClsLogConfig config) {
        TencentLogCollectConfig.INSTANCE.setTencentClsLogConfig(config);
        TencentClsSlsLogCollector.getInstance().start();
        TencentClsSlsLogCollector.getInstance().start();
    }

    private void installTencentProducer(final CountDownLatch sent, final AtomicReference<List<LogItem>> capturedLogs,
                                        final AtomicReference<String> capturedTopic, final String topic,
                                        final boolean fail) throws Exception {
        AsyncProducerClient producer = Mockito.mock(AsyncProducerClient.class);
        Mockito.when(producer.putLogs(anyString(), anyList(), Mockito.any())).thenAnswer(invocation -> {
            capturedTopic.set(invocation.getArgument(0));
            capturedLogs.set(invocation.getArgument(1));
            sent.countDown();
            if (fail) {
                throw new IllegalStateException("local send failure");
            }
            return SettableFuture.create();
        });
        TencentClsLogCollectClient client = LoggingTencentClsPluginDataHandler.getTencentClsLogCollectClient();
        ReflectionTestUtils.setField(client, "client", producer);
        ReflectionTestUtils.setField(client, "topic", topic);
        ReflectionTestUtils.setField(client, "threadExecutor", new ThreadPoolExecutor(1, 1, 1000L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>()));
        ((AtomicBoolean) ReflectionTestUtils.getField(client, "isStarted")).set(true);
    }

    private TencentLogCollectConfig.TencentClsLogConfig logConfig(final String topic) {
        TencentLogCollectConfig.TencentClsLogConfig config = new TencentLogCollectConfig.TencentClsLogConfig();
        config.setEndpoint("127.0.0.1");
        config.setSecretId("secret-id");
        config.setSecretKey("secret-key");
        config.setTopic(topic);
        config.setSampleRate("1");
        config.setMaxResponseBody(4096);
        config.setBufferQueueSize(16);
        return config;
    }

    private ShenyuConfig shenyuConfig() {
        ShenyuConfig shenyuConfig = new ShenyuConfig();
        shenyuConfig.getSelectorMatchCache().getCache().setEnabled(false);
        shenyuConfig.getRuleMatchCache().getCache().setEnabled(false);
        return shenyuConfig;
    }

    private static final class RouteBypassTencentPlugin extends LoggingTencentClsPlugin {

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            SelectorData selectorData = new SelectorData();
            selectorData.setId("selector-tencent");
            selectorData.setPluginId("plugin-tencent");
            selectorData.setPluginName(named());
            RuleData ruleData = new RuleData();
            ruleData.setId("rule-tencent");
            ruleData.setSelectorId(selectorData.getId());
            ruleData.setPluginName(named());
            ruleData.setNamespaceId(Constants.SYS_DEFAULT_NAMESPACE_ID);
            return doExecute(exchange, chain, selectorData, ruleData);
        }
    }

    private static final class TestRemoteAddressResolver implements RemoteAddressResolver {
    }
}
