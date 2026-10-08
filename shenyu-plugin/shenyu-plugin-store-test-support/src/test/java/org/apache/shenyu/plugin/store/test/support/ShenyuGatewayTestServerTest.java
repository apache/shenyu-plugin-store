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

package org.apache.shenyu.plugin.store.test.support;

import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Tests for {@link ShenyuGatewayTestServer}.
 */
public final class ShenyuGatewayTestServerTest {

    @AfterEach
    public void cleanUp() {
        GatewayFixtures.cleanBaseDataCache();
    }

    @Test
    public void returnsTerminalResponseFromRealHttpGateway() {
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start()) {
            GatewayResponse response = server.get("/hello");

            assertThat(response.getStatusCode()).isEqualTo(200);
            assertThat(response.getBody()).isEqualTo("shenyu-store-test-support");
        }
    }

    @Test
    public void returnsNonSuccessTerminalResponseWithoutThrowing() {
        TerminalResponsePlugin terminalResponse = TerminalResponsePlugin.response(HttpStatus.BAD_REQUEST, "blocked", MediaType.TEXT_PLAIN);
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Collections.emptyList(), terminalResponse)) {
            GatewayResponse response = server.get("/blocked");

            assertThat(response.getStatusCode()).isEqualTo(400);
            assertThat(response.getBody()).isEqualTo("blocked");
        }
    }

    @Test
    public void executesSuppliedPluginBeforeTerminalResponse() {
        AtomicBoolean executed = new AtomicBoolean(false);
        ShenyuPlugin plugin = new ShenyuPlugin() {
            @Override
            public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
                executed.set(true);
                return chain.execute(exchange);
            }

            @Override
            public int getOrder() {
                return 0;
            }

            @Override
            public String named() {
                return "store-test-plugin";
            }
        };

        GatewayFixtures.cachePluginRoute(plugin, "{}");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Collections.singletonList(plugin))) {
            GatewayResponse response = server.get("/plugin");

            assertThat(response.getStatusCode()).isEqualTo(200);
            assertThat(executed).isTrue();
        }
    }
}
