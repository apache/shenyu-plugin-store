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

package org.apache.shenyu.plugin.hystrix;

import com.netflix.hystrix.Hystrix;
import com.netflix.hystrix.HystrixCircuitBreaker;
import com.netflix.hystrix.HystrixCommandKey;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.convert.rule.HystrixHandle;
import org.apache.shenyu.common.enums.HystrixIsolationModeEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.result.DefaultShenyuResult;
import org.apache.shenyu.plugin.api.result.ShenyuResult;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.MatchDataCache;
import org.apache.shenyu.plugin.base.utils.CacheKeyUtils;
import org.apache.shenyu.plugin.hystrix.handler.HystrixPluginDataHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Arrays;
import java.util.Collections;
import java.util.concurrent.atomic.AtomicInteger;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 * Gateway-level tests for the externalized Hystrix plugin artifact.
 */
public final class HystrixGatewayE2ETest {

    @BeforeEach
    public void setUp() {
        ConfigurableApplicationContext context = mock(ConfigurableApplicationContext.class);
        when(context.getBean(ShenyuConfig.class)).thenReturn(new ShenyuConfig());
        when(context.getBean(ShenyuResult.class)).thenReturn(new DefaultShenyuResult());
        SpringBeanUtils.getInstance().setApplicationContext(context);
        Hystrix.reset();
        GatewayFixtures.cleanBaseDataCache();
        MatchDataCache.getInstance().cleanSelectorData();
        MatchDataCache.getInstance().cleanRuleDataData();
        HystrixPluginDataHandler.CACHED_HANDLE.get().getAllCache().clear();
    }

    @AfterEach
    public void cleanUp() {
        Hystrix.reset();
        GatewayFixtures.cleanBaseDataCache();
        MatchDataCache.getInstance().cleanSelectorData();
        MatchDataCache.getInstance().cleanRuleDataData();
        HystrixPluginDataHandler.CACHED_HANDLE.get().getAllCache().clear();
        SpringBeanUtils.getInstance().setApplicationContext(null);
    }

    @Test
    public void testGatewaySuccess() {
        HystrixPlugin plugin = new HystrixPlugin();
        GatewayFixtures.CachedPluginData route = cacheRoute(plugin, hystrixHandle("success", 1000L));
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Collections.singletonList(plugin))) {
            GatewayResponse response = server.get("/success");
            assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK.value());
            assertThat(response.getBody()).isEqualTo("shenyu-store-test-support");
            assertThat(BaseDataCache.getInstance().obtainRuleData(route.getSelectorData().getId()))
                    .contains(route.getRuleData());
        }
    }

    @Test
    public void testGatewayTimeoutUsesHystrixFallbackResponse() {
        HystrixPlugin plugin = new HystrixPlugin();
        cacheRoute(plugin, hystrixHandle("timeout", 50L));
        DelayedTerminalPlugin delayedTerminal = new DelayedTerminalPlugin(Duration.ofMillis(250), "late");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, delayedTerminal))) {
            GatewayResponse response = server.get("/timeout");
            assertThat(response.getStatusCode()).isEqualTo(HttpStatus.GATEWAY_TIMEOUT.value());
            assertThat(response.getBody()).contains("timeout");
        }
    }

    @Test
    public void testGatewayOpensCircuitAfterFailures() throws InterruptedException {
        HystrixPlugin plugin = new HystrixPlugin();
        String commandKey = "circuit";
        cacheRoute(plugin, hystrixHandle(commandKey, 500L));
        FailingTerminalPlugin failingTerminal = new FailingTerminalPlugin();
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, failingTerminal))) {
            assertThat(server.get("/circuit").getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR.value());
            assertThat(server.get("/circuit").getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR.value());
            assertCircuitOpenEventually(server, commandKey);
            int invocationsWhenOpen = failingTerminal.getInvocations();
            assertThat(server.get("/circuit").getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR.value());
            assertThat(failingTerminal.getInvocations()).isEqualTo(invocationsWhenOpen);
        }
    }

    @Test
    public void testGatewayRuleRefreshAppliesNewTimeoutAndCloseCleansRouteCache() {
        HystrixPlugin plugin = new HystrixPlugin();
        GatewayFixtures.CachedPluginData route = cacheRoute(plugin, hystrixHandle("refresh-fast", 50L));
        DelayedTerminalPlugin delayedTerminal = new DelayedTerminalPlugin(Duration.ofMillis(120), "refreshed");
        ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, delayedTerminal));
        try {
            GatewayResponse timedOut = server.get("/refresh");
            assertThat(timedOut.getStatusCode()).isEqualTo(HttpStatus.GATEWAY_TIMEOUT.value());
            HystrixHandle refreshed = hystrixHandle("refresh-slow", 1000L);
            route.getRuleData().setHandle(GsonUtils.getInstance().toJson(refreshed));
            new HystrixPluginDataHandler().handlerRule(route.getRuleData());
            GatewayResponse response = server.get("/refresh");
            assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK.value());
            assertThat(response.getBody()).isEqualTo("refreshed");
        } finally {
            server.close();
        }
        assertThat(BaseDataCache.getInstance().obtainPluginData(plugin.named())).isNull();
    }

    private GatewayFixtures.CachedPluginData cacheRoute(final HystrixPlugin plugin, final HystrixHandle handle) {
        GatewayFixtures.CachedPluginData route = GatewayFixtures.cachePluginRoute(plugin, GsonUtils.getInstance().toJson(handle));
        HystrixPluginDataHandler.CACHED_HANDLE.get().cachedHandle(CacheKeyUtils.INST.getKey(route.getRuleData()), handle);
        return route;
    }

    private HystrixHandle hystrixHandle(final String commandKey, final long timeout) {
        HystrixHandle handle = new HystrixHandle();
        handle.setGroupKey("store-hystrix-e2e");
        handle.setCommandKey(commandKey);
        handle.setCallBackUri(null);
        handle.setExecutionIsolationStrategy(HystrixIsolationModeEnum.SEMAPHORE.getCode());
        handle.setTimeout(timeout);
        handle.setMaxConcurrentRequests(10);
        handle.setRequestVolumeThreshold(2);
        handle.setErrorThresholdPercentage(50);
        handle.setSleepWindowInMilliseconds(5000);
        return handle;
    }

    private void assertCircuitOpenEventually(final ShenyuGatewayTestServer server, final String commandKey) throws InterruptedException {
        HystrixCircuitBreaker circuitBreaker = HystrixCircuitBreaker.Factory.getInstance(
                HystrixCommandKey.Factory.asKey(commandKey));
        assertThat(circuitBreaker).isNotNull();
        for (int i = 0; i < 10 && !circuitBreaker.isOpen(); i++) {
            Thread.sleep(100L);
            server.get("/circuit");
        }
        assertThat(circuitBreaker.isOpen()).isTrue();
    }

    private static Mono<Void> write(final ServerWebExchange exchange, final HttpStatus status, final String body) {
        final byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponse().setStatusCode(status);
        exchange.getResponse().getHeaders().setContentType(MediaType.TEXT_PLAIN);
        exchange.getResponse().getHeaders().setContentLength(bytes.length);
        final DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(bytes);
        return exchange.getResponse().writeWith(Mono.just(buffer));
    }

    private static final class DelayedTerminalPlugin implements ShenyuPlugin {

        private final Duration delay;

        private final String body;

        private DelayedTerminalPlugin(final Duration delay, final String body) {
            this.delay = delay;
            this.body = body;
        }

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            return Mono.delay(delay).then(write(exchange, HttpStatus.OK, body));
        }

        @Override
        public int getOrder() {
            return Integer.MAX_VALUE - 1;
        }

        @Override
        public String named() {
            return "hystrix-delayed-terminal";
        }
    }

    private static final class FailingTerminalPlugin implements ShenyuPlugin {

        private final AtomicInteger invocations = new AtomicInteger();

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            invocations.incrementAndGet();
            return Mono.error(new IllegalStateException("backend failure"));
        }

        @Override
        public int getOrder() {
            return Integer.MAX_VALUE - 1;
        }

        @Override
        public String named() {
            return "hystrix-failing-terminal";
        }

        private int getInvocations() {
            return invocations.get();
        }
    }

}
