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
import org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit;
import org.apache.shenyu.plugin.store.test.support.TerminalResponsePlugin;
import org.junit.jupiter.api.Test;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Sinks;
import reactor.test.StepVerifier;

import java.time.Duration;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.SHORT_CIRCUIT;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.TRANSFORM;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.WRAPPER;
import static org.junit.jupiter.api.Assertions.assertEquals;

class ExternalPluginContractTest {

    @Test
    void transformationUsesPackagedKitAndActualRootHandler() {
        AtomicInteger effects = new AtomicInteger();
        ShenyuPlugin transformer = new Transformer(effects);
        try (var session = LegacyPluginContractKit.open("external-transformer", TRANSFORM, List.of(transformer), exchange -> {
            assertEquals("yes", exchange.getRequest().getHeaders().getFirst("X-Transformed"));
            return TerminalResponsePlugin.ok("transformed").execute(exchange, current -> Mono.empty());
        })) {
            LegacyPluginContractKit.assertDeferred("external-transformer", session::publisher, effects::longValue);
            session.verifyComplete(1);
            assertEquals(1, effects.get());
            assertEquals("transformed", session.exchange().getResponse().getBodyAsString().block(Duration.ofSeconds(1)));
        }
        var evidence = LegacyPluginContractKit.evidence(System.getProperty("contract.coreRevision"), Set.of(TRANSFORM),
                Set.of("GRAPH unsupported", "SDK leases not declared"));
        assertEquals("2.7.1-SNAPSHOT", evidence.kitVersion());
        assertEquals("2.7.2-SNAPSHOT", evidence.coreVersion());
        System.out.println("Packaged contract evidence: " + evidence);
    }

    @Test
    void wrapperEnclosesControlledAsynchronousSuccessor() {
        Sinks.Empty<Void> completion = Sinks.empty();
        AtomicInteger terminalSignals = new AtomicInteger();
        ShenyuPlugin wrapper = new Wrapper(terminalSignals);
        try (var session = LegacyPluginContractKit.open("external-wrapper", WRAPPER, List.of(wrapper), exchange -> completion.asMono())) {
            StepVerifier.create(session.publisher()).then(() -> completion.tryEmitEmpty()).expectComplete().verify(Duration.ofSeconds(2));
            assertEquals(1, session.downstreamSubscriptions());
            assertEquals(1, terminalSignals.get());
        }
    }

    @Test
    void shortCircuitProfileDoesNotDemandDownstreamExecution() {
        try (var session = LegacyPluginContractKit.open("external-short-circuit", SHORT_CIRCUIT,
                List.of(TerminalResponsePlugin.ok("blocked-locally")))) {
            session.verifyComplete(0);
            assertEquals("blocked-locally", session.exchange().getResponse().getBodyAsString().block(Duration.ofSeconds(1)));
        }
    }

    private static final class Transformer implements ShenyuPlugin {

        private final AtomicInteger effects;

        private Transformer(final AtomicInteger effects) {
            this.effects = effects;
        }

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            effects.incrementAndGet();
            return chain.execute(exchange.mutate().request(builder -> builder.header("X-Transformed", "yes")).build());
        }

        @Override
        public int getOrder() {
            return 0;
        }
    }

    private static final class Wrapper implements ShenyuPlugin {

        private final AtomicInteger terminalSignals;

        private Wrapper(final AtomicInteger terminalSignals) {
            this.terminalSignals = terminalSignals;
        }

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            return chain.execute(exchange).doFinally(signal -> terminalSignals.incrementAndGet());
        }

        @Override
        public int getOrder() {
            return 0;
        }
    }
}
