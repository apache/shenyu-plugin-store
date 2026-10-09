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

package org.apache.shenyu.springboot.starter.plugin.logging.huawei.lts;

import com.google.common.util.concurrent.SettableFuture;
import com.huaweicloud.lts.producer.Producer;
import com.huaweicloud.lts.producer.exception.ProducerException;
import com.huaweicloud.lts.producer.model.log.LogItem;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.utils.Singleton;
import org.apache.shenyu.plugin.api.RemoteAddressResolver;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.huawei.lts.LoggingHuaweiLtsPlugin;
import org.apache.shenyu.plugin.huawei.lts.client.HuaweiLtsLogCollectClient;
import org.apache.shenyu.plugin.huawei.lts.collector.HuaweiLtsLogCollector;
import org.apache.shenyu.plugin.huawei.lts.config.HuaweiLogCollectConfig;
import org.apache.shenyu.plugin.huawei.lts.handler.LoggingHuaweiLtsPluginDataHandler;
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
 * Credential-free gateway-to-Huawei-LTS boundary contract test.
 */
public final class LoggingHuaweiLtsGatewayContractTest {

    /**
     * Cleanup collector and cached fixture data.
     *
     * @throws Exception exception
     */
    @AfterEach
    public void tearDown() throws Exception {
        HuaweiLtsLogCollector.getInstance().close();
        GatewayFixtures.cleanBaseDataCache();
    }

    /**
     * Gateway traffic reaches the local SDK boundary with status, headers, and body fields.
     *
     * @throws Exception exception
     */
    @Test
    public void testGatewayTrafficReachesHuaweiProducerBoundary() throws Exception {
        CountDownLatch sent = new CountDownLatch(1);
        AtomicReference<List<LogItem>> capturedLogs = new AtomicReference<>();
        AtomicReference<String> capturedStream = new AtomicReference<>();
        installHuaweiProducer(sent, capturedLogs, capturedStream, "stream", false);
        startCollector(logConfig("stream"));

        assertGatewayResponse("/contract?source=huawei", "huawei-response-body");

        Assertions.assertTrue(sent.await(3, TimeUnit.SECONDS));
        String payload = capturedLogs.get().get(0).getContents().get(0).getLog();
        Assertions.assertEquals("stream", capturedStream.get());
        Assertions.assertTrue(payload.contains("status=202"), payload);
        Assertions.assertTrue(payload.contains("Content-Type"), payload);
        Assertions.assertTrue(payload.contains("huawei-response-body"), payload);
        Assertions.assertTrue(payload.contains("/contract?source=huawei"), payload);
    }

    /**
     * SDK send failures and config updates keep the gateway path stable.
     *
     * @throws Exception exception
     */
    @Test
    public void testSendFailureConfigUpdateAndRepeatedStart() throws Exception {
        CountDownLatch failedSend = new CountDownLatch(1);
        installHuaweiProducer(failedSend, new AtomicReference<>(), new AtomicReference<>(), "stream-fail", true);
        startCollector(logConfig("stream-fail"));

        assertGatewayResponse("/contract?source=huawei-failure", "huawei-response-body");
        Assertions.assertTrue(failedSend.await(3, TimeUnit.SECONDS));

        CountDownLatch updatedSend = new CountDownLatch(1);
        AtomicReference<String> capturedStream = new AtomicReference<>();
        installHuaweiProducer(updatedSend, new AtomicReference<>(), capturedStream, "stream-updated", false);
        HuaweiLogCollectConfig.INSTANCE.setHuaweiLtsLogConfig(logConfig("stream-updated"));
        HuaweiLtsLogCollector.getInstance().start();

        assertGatewayResponse("/contract?source=huawei-updated", "huawei-response-body");
        Assertions.assertTrue(updatedSend.await(3, TimeUnit.SECONDS));
        Assertions.assertEquals("stream-updated", capturedStream.get());
    }

    private void assertGatewayResponse(final String path, final String body) {
        ShenyuGatewayTestServer.contextRunner()
                .withUserConfiguration(LoggingHuaweiLtsPluginConfiguration.class)
                .withBean(ShenyuConfig.class, this::shenyuConfig)
                .withBean(RemoteAddressResolver.class, TestRemoteAddressResolver::new)
                .run(context -> {
                    SpringBeanUtils.getInstance().setApplicationContext(context);
                    Singleton.INST.single(ShenyuConfig.class, context.getBean(ShenyuConfig.class));
                    Assertions.assertTrue(context.getBean(ShenyuPlugin.class) instanceof LoggingHuaweiLtsPlugin);
                    ShenyuPlugin loggingPlugin = new RouteBypassHuaweiPlugin();
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

    private void startCollector(final HuaweiLogCollectConfig.HuaweiLtsLogConfig config) {
        HuaweiLogCollectConfig.INSTANCE.setHuaweiLtsLogConfig(config);
        HuaweiLtsLogCollector.getInstance().start();
        HuaweiLtsLogCollector.getInstance().start();
    }

    private void installHuaweiProducer(final CountDownLatch sent, final AtomicReference<List<LogItem>> capturedLogs,
                                       final AtomicReference<String> capturedStream, final String stream,
                                       final boolean fail) throws Exception {
        Producer producer = Mockito.mock(Producer.class);
        Mockito.when(producer.send(anyString(), anyString(), anyList())).thenAnswer(invocation -> {
            capturedStream.set(invocation.getArgument(1));
            capturedLogs.set(invocation.getArgument(2));
            sent.countDown();
            if (fail) {
                throw new ProducerException("local send failure");
            }
            return SettableFuture.create();
        });
        HuaweiLtsLogCollectClient client = LoggingHuaweiLtsPluginDataHandler.getHuaweiLtsLogCollectClient();
        ReflectionTestUtils.setField(client, "producer", producer);
        ReflectionTestUtils.setField(client, "projectId", "project");
        ReflectionTestUtils.setField(client, "logGroupId", "group");
        ReflectionTestUtils.setField(client, "logStreamId", stream);
        ReflectionTestUtils.setField(client, "threadExecutor", new ThreadPoolExecutor(1, 1, 1000L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>()));
        ((AtomicBoolean) ReflectionTestUtils.getField(client, "isStarted")).set(true);
    }

    private HuaweiLogCollectConfig.HuaweiLtsLogConfig logConfig(final String stream) {
        HuaweiLogCollectConfig.HuaweiLtsLogConfig config = new HuaweiLogCollectConfig.HuaweiLtsLogConfig();
        config.setProjectId("project");
        config.setLogGroupId("group");
        config.setLogStreamId(stream);
        config.setAccessKeyId("access-key-id");
        config.setAccessKeySecret("access-key-secret");
        config.setRegionName("region");
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

    private static final class RouteBypassHuaweiPlugin extends LoggingHuaweiLtsPlugin {

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            SelectorData selectorData = new SelectorData();
            selectorData.setId("selector-huawei");
            selectorData.setPluginId("plugin-huawei");
            selectorData.setPluginName(named());
            RuleData ruleData = new RuleData();
            ruleData.setId("rule-huawei");
            ruleData.setSelectorId(selectorData.getId());
            ruleData.setPluginName(named());
            ruleData.setNamespaceId(Constants.SYS_DEFAULT_NAMESPACE_ID);
            return doExecute(exchange, chain, selectorData, ruleData);
        }
    }

    private static final class TestRemoteAddressResolver implements RemoteAddressResolver {
    }
}
