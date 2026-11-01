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

package org.example.shenyu;

import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.condition.EnabledIfSystemProperty;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** Opt-in loopback HTTP smoke using the existing real gateway fixture. */
@EnabledIfSystemProperty(named = "contract.smoke", matches = "true")
class ExternalGatewaySmokeTest {

    @Test
    void realHttpRequestTraversesTheGateway() {
        ShenyuPlugin plugin = new ShenyuPlugin() {
            @Override
            public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
                exchange.getResponse().getHeaders().add("X-External-Plugin", "yes");
                return chain.execute(exchange);
            }

            @Override
            public int getOrder() {
                return 0;
            }
        };
        try (ShenyuGatewayTestServer gateway = ShenyuGatewayTestServer.start(List.of(plugin))) {
            var response = gateway.get("/external-consumer-smoke");
            assertEquals(200, response.getStatusCode());
            assertEquals("shenyu-store-test-support", response.getBody());
            assertEquals("yes", response.getHeaders().getFirst("X-External-Plugin"));
        }
    }
}
