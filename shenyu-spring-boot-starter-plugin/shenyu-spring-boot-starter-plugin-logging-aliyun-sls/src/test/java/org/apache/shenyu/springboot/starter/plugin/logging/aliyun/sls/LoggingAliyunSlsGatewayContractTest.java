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

package org.apache.shenyu.springboot.starter.plugin.logging.aliyun.sls;

import com.aliyun.openservices.aliyun.log.producer.Producer;
import com.aliyun.openservices.log.Client;
import com.aliyun.openservices.log.common.LogItem;
import com.google.common.util.concurrent.SettableFuture;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.utils.Singleton;
import org.apache.shenyu.plugin.aliyun.sls.LoggingAliyunSlsPlugin;
import org.apache.shenyu.plugin.aliyun.sls.client.AliyunSlsLogCollectClient;
import org.apache.shenyu.plugin.aliyun.sls.collector.AliyunSlsLogCollector;
import org.apache.shenyu.plugin.aliyun.sls.config.AliyunLogCollectConfig;
import org.apache.shenyu.plugin.aliyun.sls.handler.LoggingAliyunSlsPluginDataHandler;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
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
 * Credential-free gateway-to-Aliyun-SLS boundary contract test.
 */
public final class LoggingAliyunSlsGatewayContractTest {

    /**
     * Cleanup collector and cached fixture data.
     *
     * @throws Exception exception
     */
    @AfterEach
    public void tearDown() throws Exception {
        AliyunSlsLogCollector.getInstance().close();
        GatewayFixtures.cleanBaseDataCache();
    }

    /**
     * Gateway traffic reaches the local SDK boundary with status, headers, and body fields.
     *
     * @throws Exception exception
     */
    @Test
    public void testGatewayTrafficReachesAliyunProducerBoundary() throws Exception {
        CountDownLatch sent = new CountDownLatch(1);
        AtomicReference<List<LogItem>> capturedLogs = new AtomicReference<>();
        AtomicReference<String> capturedTopic = new AtomicReference<>();
        installAliyunProducer(sent, capturedLogs, capturedTopic, "topic", false);
        startCollector(logConfig("topic"));

        assertGatewayResponse("/contract?source=aliyun", "aliyun-response-body");

        Assertions.assertTrue(sent.await(3, TimeUnit.SECONDS));
        String payload = capturedLogs.get().get(0).ToJsonString();
        Assertions.assertEquals("topic", capturedTopic.get());
        Assertions.assertTrue(payload.contains("\\\"status\\\":202"), payload);
        Assertions.assertTrue(payload.contains("Content-Type"), payload);
        Assertions.assertTrue(payload.contains("aliyun-response-body"), payload);
        Assertions.assertTrue(payload.contains("/contract?source=aliyun"), payload);
    }

    /**
     * SDK send failures and config updates keep the gateway path stable.
     *
     * @throws Exception exception
     */
    @Test
    public void testSendFailureConfigUpdateAndRepeatedStart() throws Exception {
        CountDownLatch failedSend = new CountDownLatch(1);
        installAliyunProducer(failedSend, new AtomicReference<>(), new AtomicReference<>(), "topic-fail", true);
        startCollector(logConfig("topic-fail"));

        assertGatewayResponse("/contract?source=aliyun-failure", "aliyun-response-body");
        Assertions.assertTrue(failedSend.await(3, TimeUnit.SECONDS));

        CountDownLatch updatedSend = new CountDownLatch(1);
        AtomicReference<String> capturedTopic = new AtomicReference<>();
        installAliyunProducer(updatedSend, new AtomicReference<>(), capturedTopic, "topic-updated", false);
        AliyunLogCollectConfig.INSTANCE.setAliyunSlsLogConfig(logConfig("topic-updated"));
        AliyunSlsLogCollector.getInstance().start();

        assertGatewayResponse("/contract?source=aliyun-updated", "aliyun-response-body");
        Assertions.assertTrue(updatedSend.await(3, TimeUnit.SECONDS));
        Assertions.assertEquals("topic-updated", capturedTopic.get());
    }

    private void assertGatewayResponse(final String path, final String body) {
        ShenyuGatewayTestServer.contextRunner()
                .withUserConfiguration(LoggingAliyunSlsPluginConfiguration.class)
                .withBean(ShenyuConfig.class, this::shenyuConfig)
                .withBean(RemoteAddressResolver.class, TestRemoteAddressResolver::new)
                .run(context -> {
                    SpringBeanUtils.getInstance().setApplicationContext(context);
                    Singleton.INST.single(ShenyuConfig.class, context.getBean(ShenyuConfig.class));
                    Assertions.assertTrue(context.getBean(ShenyuPlugin.class) instanceof LoggingAliyunSlsPlugin);
                    ShenyuPlugin loggingPlugin = new RouteBypassAliyunPlugin();
                    TerminalResponsePlugin terminal = TerminalResponsePlugin.response(HttpStatus.ACCEPTED,
                            "aliyun-response-body", MediaType.TEXT_PLAIN);
                    try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Collections.singletonList(loggingPlugin),
                            terminal)) {
                        GatewayResponse response = server.get(path);
                        Assertions.assertEquals(HttpStatus.ACCEPTED.value(), response.getStatusCode());
                        Assertions.assertEquals(body, response.getBody());
                    }
                });
    }

    private void startCollector(final AliyunLogCollectConfig.AliyunSlsLogConfig config) {
        AliyunLogCollectConfig.INSTANCE.setAliyunSlsLogConfig(config);
        AliyunSlsLogCollector.getInstance().start();
        AliyunSlsLogCollector.getInstance().start();
    }

    private void installAliyunProducer(final CountDownLatch sent, final AtomicReference<List<LogItem>> capturedLogs,
                                      final AtomicReference<String> capturedTopic, final String topic,
                                      final boolean fail) throws Exception {
        Producer producer = Mockito.mock(Producer.class);
        Mockito.when(producer.send(anyString(), anyString(), anyString(), anyString(), anyList())).thenAnswer(invocation -> {
            capturedLogs.set(invocation.getArgument(4));
            capturedTopic.set(invocation.getArgument(2));
            sent.countDown();
            if (fail) {
                throw new IllegalStateException("local send failure");
            }
            return SettableFuture.create();
        });
        AliyunSlsLogCollectClient client = LoggingAliyunSlsPluginDataHandler.getAliyunSlsLogCollectClient();
        ReflectionTestUtils.setField(client, "client", Mockito.mock(Client.class));
        ReflectionTestUtils.setField(client, "producer", producer);
        ReflectionTestUtils.setField(client, "projectName", "project");
        ReflectionTestUtils.setField(client, "logStore", "logstore");
        ReflectionTestUtils.setField(client, "topic", topic);
        ReflectionTestUtils.setField(client, "threadExecutor", new ThreadPoolExecutor(1, 1, 1000L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>()));
        ((AtomicBoolean) ReflectionTestUtils.getField(client, "isStarted")).set(true);
    }

    private AliyunLogCollectConfig.AliyunSlsLogConfig logConfig(final String topic) {
        AliyunLogCollectConfig.AliyunSlsLogConfig config = new AliyunLogCollectConfig.AliyunSlsLogConfig();
        config.setAccessId("access-id");
        config.setAccessKey("access-key");
        config.setHost("http://127.0.0.1");
        config.setProjectName("project");
        config.setLogStoreName("logstore");
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

    private static final class RouteBypassAliyunPlugin extends LoggingAliyunSlsPlugin {

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            SelectorData selectorData = new SelectorData();
            selectorData.setId("selector-aliyun");
            selectorData.setPluginId("plugin-aliyun");
            selectorData.setPluginName(named());
            RuleData ruleData = new RuleData();
            ruleData.setId("rule-aliyun");
            ruleData.setSelectorId(selectorData.getId());
            ruleData.setPluginName(named());
            ruleData.setNamespaceId(Constants.SYS_DEFAULT_NAMESPACE_ID);
            return doExecute(exchange, chain, selectorData, ruleData);
        }
    }

    private static final class TestRemoteAddressResolver implements RemoteAddressResolver {
    }
}
