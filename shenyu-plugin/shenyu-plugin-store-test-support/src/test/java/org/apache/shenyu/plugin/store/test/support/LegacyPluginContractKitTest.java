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

import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.base.AbstractShenyuPlugin;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.handler.PluginDataHandler;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.reactivestreams.Publisher;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.server.reactive.ServerHttpResponseDecorator;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
import reactor.core.publisher.SignalType;
import reactor.core.publisher.Sinks;
import reactor.test.StepVerifier;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.BiFunction;

import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.BASE_MATCHING;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.FORK;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.SHORT_CIRCUIT;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.TRANSFORM;
import static org.apache.shenyu.plugin.store.test.support.LegacyPluginContractKit.Profile.WRAPPER;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

class LegacyPluginContractKitTest {

    @AfterEach
    void cleanFixtures() {
        GatewayFixtures.cleanBaseDataCache();
    }

    @Test
    void rootDefersRequestEffectsAndRepeatedSubscriptionsUseFreshRuntimeChains() {
        AtomicInteger effects = new AtomicInteger();
        ShenyuPlugin plugin = plugin((exchange, chain) -> {
            effects.incrementAndGet();
            return chain.execute(exchange);
        });
        try (var session = LegacyPluginContractKit.open("transform", TRANSFORM, List.of(plugin))) {
            LegacyPluginContractKit.assertDeferred("transform", session::publisher, effects::longValue);
            session.verifyComplete(1);
            session.verifyComplete(2);
            assertEquals(2, effects.get());
        }
    }

    @Test
    void badAssemblyFixtureIsDetectedAtRootBoundary() {
        AtomicInteger effects = new AtomicInteger();
        try (var session = LegacyPluginContractKit.open("bad-assembly", TRANSFORM, List.of())) {
            AssertionError error = assertThrows(AssertionError.class, () -> LegacyPluginContractKit.assertDeferred("bad-assembly", () -> {
                effects.incrementAndGet();
                return session.publisher();
            }, effects::longValue));
            assertTrue(error.getMessage().contains("bad-assembly/ROOT"));
        }
    }

    @Test
    void wrapperAndForkProfilesDeclareTheirOwnContinuationCounts() {
        ShenyuPlugin wrapper = new FixturePlugin((exchange, chain) -> {
            exchange.getAttributes().put("contract-fork-dispatch", true);
            return chain.fork().execute(exchange).then(chain.execute(exchange))
                    .doFinally(signal -> exchange.getAttributes().remove("contract-fork-dispatch"));
        }) {
            @Override
            public boolean skip(final ServerWebExchange exchange) {
                return Boolean.TRUE.equals(exchange.getAttribute("contract-fork-dispatch"));
            }
        };
        try (var session = LegacyPluginContractKit.open("wrapper", WRAPPER, List.of(wrapper))) {
            session.verifyComplete(2);
        }
        try (var session = LegacyPluginContractKit.open("fork", FORK, List.of(wrapper))) {
            session.verifyComplete(2);
        }
        try (var session = LegacyPluginContractKit.open("bad-transform", TRANSFORM, List.of(wrapper))) {
            AssertionError error = assertThrows(AssertionError.class, () -> session.verifyComplete(1));
            assertTrue(error.getMessage().contains("bad-transform/TRANSFORM"));
        }
    }

    @Test
    void shortCircuitOwnsTheResponseWithoutCallingSuccessors() {
        ShenyuPlugin response = TerminalResponsePlugin.ok("short-circuit");
        try (var session = LegacyPluginContractKit.open("response-owner", SHORT_CIRCUIT, List.of(response))) {
            session.verifyComplete(0);
            assertEquals("short-circuit", session.exchange().getResponse().getBodyAsString().block(Duration.ofSeconds(1)));
        }
    }

    @Test
    void outerSkipDoesNotEnterThePlugin() {
        ShenyuPlugin skipped = new FixturePlugin((exchange, chain) -> Mono.error(new IllegalStateException("Skipped plugin was entered"))) {
            @Override
            public boolean skip(final ServerWebExchange exchange) {
                return true;
            }
        };
        try (var session = LegacyPluginContractKit.open("skip", TRANSFORM, List.of(skipped))) {
            session.verifyComplete(1);
        }
    }

    @Test
    void decoratorPropagationUsesTheActualResponseOwnerAndDetectsBrokenFixtures() {
        for (boolean propagate : new boolean[]{true, false}) {
            ShenyuPlugin transform = plugin((exchange, chain) -> {
                ServerHttpResponseDecorator response = new ServerHttpResponseDecorator(exchange.getResponse()) {
                    @Override
                    public Mono<Void> writeWith(final Publisher<? extends DataBuffer> body) {
                        getHeaders().add("X-Contract", "decorated");
                        return super.writeWith(body);
                    }
                };
                return chain.execute(propagate ? exchange.mutate().response(response).build() : exchange);
            });
            try (var session = LegacyPluginContractKit.open("decorator", TRANSFORM, List.of(transform),
                    exchange -> TerminalResponsePlugin.ok("payload").execute(exchange, current -> Mono.empty()))) {
                session.verifyComplete(1);
                assertEquals("payload", session.exchange().getResponse().getBodyAsString().block(Duration.ofSeconds(1)));
                if (propagate) {
                    session.assertResponseHeader("X-Contract", "decorated");
                } else {
                    assertThrows(AssertionError.class, () -> session.assertResponseHeader("X-Contract", "decorated"));
                }
            }
        }
    }

    @Test
    void controlledAsyncCompletionKeepsBeforeAfterAtPublisherConstruction() {
        List<String> events = new ArrayList<>();
        Sinks.Empty<Void> completion = Sinks.empty();
        ShenyuPlugin wrapper = new FixturePlugin((exchange, chain) -> {
            events.add("execute");
            return chain.execute(exchange);
        }) {
            @Override
            public void before(final ServerWebExchange exchange) {
                events.add("before");
            }

            @Override
            public void after(final ServerWebExchange exchange) {
                events.add("after");
            }
        };
        try (var session = LegacyPluginContractKit.open("hooks", WRAPPER, List.of(wrapper), exchange -> completion.asMono())) {
            assertTrue(events.isEmpty());
            StepVerifier.create(session.publisher()).then(() -> {
                assertEquals(List.of("before", "execute", "after"), events);
                completion.tryEmitEmpty();
            }).expectComplete().verify(Duration.ofSeconds(2));
        }
    }

    @Test
    void completionErrorAndCancellationReachTheActualOwnerExactlyOnce() {
        for (SignalType terminal : new SignalType[]{SignalType.ON_COMPLETE, SignalType.ON_ERROR, SignalType.CANCEL}) {
            AtomicReference<LegacyPluginContractKit.ReleaseProbe> owner = new AtomicReference<>();
            ShenyuPlugin plugin = plugin((exchange, chain) -> {
                Mono<Void> source = terminal == SignalType.ON_COMPLETE ? Mono.empty() : Mono.never();
                if (terminal == SignalType.ON_ERROR) {
                    source = Mono.error(new IllegalStateException("fixture"));
                }
                return source.doFinally(signal -> owner.get().record(signal));
            });
            try (var session = LegacyPluginContractKit.open("owner", WRAPPER, List.of(plugin))) {
                owner.set(session.releaseProbe());
                if (terminal == SignalType.ON_ERROR) {
                    session.verifyError(IllegalStateException.class);
                } else if (terminal == SignalType.ON_COMPLETE) {
                    session.verifyComplete(0);
                } else {
                    session.verifyCancellation(() -> assertEquals(0, session.downstreamSubscriptions()));
                }
                owner.get().assertReleasedOnce(terminal, Duration.ofSeconds(2));
            }
        }
    }

    @Test
    void lostCancellationFixtureFailsTheOwnerCleanupCheck() {
        AtomicReference<LegacyPluginContractKit.ReleaseProbe> owner = new AtomicReference<>();
        ShenyuPlugin bad = plugin((exchange, chain) -> Mono.<Void>never().doFinally(signal -> owner.get().record(signal)).cache());
        try (var session = LegacyPluginContractKit.open("lost-cancel", WRAPPER, List.of(bad))) {
            owner.set(session.releaseProbe());
            session.verifyCancellation(() -> assertEquals(0, session.downstreamSubscriptions()));
            assertThrows(AssertionError.class, () -> owner.get().assertReleasedOnce(SignalType.CANCEL, Duration.ofMillis(50)));
        }
    }

    @Test
    void actualBaseMatchingCoversMissingConfigurationMatchAndRuleMiss() {
        AtomicInteger matches = new AtomicInteger();
        AbstractShenyuPlugin base = new AbstractShenyuPlugin() {
            @Override
            protected Mono<Void> doExecute(final ServerWebExchange exchange, final ShenyuPluginChain chain,
                                           final SelectorData selector, final RuleData rule) {
                matches.incrementAndGet();
                return chain.execute(exchange);
            }

            @Override
            public int getOrder() {
                return 0;
            }

            @Override
            public String named() {
                return "contract-base-matching";
            }
        };
        try (var session = LegacyPluginContractKit.open("base", BASE_MATCHING, List.of(base))) {
            session.verifyComplete(1);
            assertEquals(0, matches.get());
            GatewayFixtures.CachedPluginData route = GatewayFixtures.cachePluginRoute(base, "{}");
            session.verifyComplete(2);
            assertEquals(1, matches.get());
            BaseDataCache.getInstance().removeRuleData(route.getRuleData());
            session.verifyComplete(3);
            assertEquals(1, matches.get());
        }
    }

    @Test
    void supportedConfigurationRemovalDetectsStaleState() {
        AtomicReference<String> cached = new AtomicReference<>();
        RuleData rule = new RuleData();
        rule.setHandle("{}");
        for (boolean remove : new boolean[]{true, false}) {
            PluginDataHandler handler = new PluginDataHandler() {
                @Override
                public void handlerRule(final RuleData update) {
                    cached.set(update.getHandle());
                }

                @Override
                public void removeRule(final RuleData removed) {
                    if (remove) {
                        cached.set(null);
                    }
                }

                @Override
                public String pluginNamed() {
                    return "fixture-config";
                }
            };
            if (remove) {
                LegacyPluginContractKit.assertConfigurationRemoval("fixture-config", handler, rule, cached::get);
            } else {
                assertThrows(AssertionError.class, () -> LegacyPluginContractKit.assertConfigurationRemoval("fixture-config", handler, rule, cached::get));
            }
        }
    }

    @Test
    void evidenceKeepsUnsupportedProfilesExplicit() {
        var evidence = LegacyPluginContractKit.evidence("declared-fixture-revision", Set.of(TRANSFORM), Set.of("SDK leases: unsupported"));
        assertEquals(Set.of(TRANSFORM), evidence.profiles());
        assertTrue(evidence.unsupported().contains("SDK leases: unsupported"));
        assertThrows(UnsupportedOperationException.class, () -> evidence.profiles().clear());
    }

    @Test
    void nestedWrappersKeepTheirDeclaredSuccessorScopes() {
        List<String> events = new ArrayList<>();
        ShenyuPlugin outer = plugin((exchange, chain) -> Mono.defer(() -> {
            events.add("outer-enter");
            return chain.execute(exchange).doOnSuccess(value -> events.add("outer-exit"));
        }));
        ShenyuPlugin inner = plugin((exchange, chain) -> Mono.defer(() -> {
            events.add("inner-enter");
            return chain.execute(exchange).doOnSuccess(value -> events.add("inner-exit"));
        }));
        try (var session = LegacyPluginContractKit.open("nested", WRAPPER, List.of(outer, inner))) {
            session.verifyComplete(1);
            assertEquals(List.of("outer-enter", "inner-enter", "inner-exit", "outer-exit"), events);
        }
    }

    private ShenyuPlugin plugin(final BiFunction<ServerWebExchange, ShenyuPluginChain, Mono<Void>> behavior) {
        return new FixturePlugin(behavior);
    }

    private static class FixturePlugin implements ShenyuPlugin {

        private final BiFunction<ServerWebExchange, ShenyuPluginChain, Mono<Void>> behavior;

        protected FixturePlugin(final BiFunction<ServerWebExchange, ShenyuPluginChain, Mono<Void>> behavior) {
            this.behavior = behavior;
        }

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            return behavior.apply(exchange, chain);
        }

        @Override
        public int getOrder() {
            return 0;
        }

        @Override
        public String named() {
            return "contract-fixture";
        }
    }
}
