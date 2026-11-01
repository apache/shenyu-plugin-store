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

import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.handler.PluginDataHandler;
import org.apache.shenyu.web.handler.ShenyuWebHandler;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.mock.http.server.reactive.MockServerHttpRequest;
import org.springframework.mock.web.server.MockServerWebExchange;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
import reactor.core.publisher.SignalType;
import reactor.core.publisher.Sinks;
import reactor.test.StepVerifier;

import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Function;
import java.util.function.LongSupplier;
import java.util.function.Supplier;

/**
 * Test-scope, role-aware checks around the real LEGACY root handler.
 * No cursor implementation or runtime plugin dependency is introduced.
 */
public final class LegacyPluginContractKit {

    private LegacyPluginContractKit() {
    }


    /**
     * Record versions and selected/unsupported capabilities without inferring support.
     * @param revision declared build provenance
     * @param profiles selected checks
     * @param unsupported unsupported/skipped checks and reasons
     * @return immutable evidence
     */
    public static Evidence evidence(final String revision, final Set<Profile> profiles, final Set<String> unsupported) {
        return new Evidence(version("shenyu-plugin-store-test-support"), version("shenyu-web"),
                Objects.requireNonNullElse(revision, "unknown"), profiles, unsupported);
    }

    /**
     * Open a serial, scoped fixture using the actual handler and a no-op terminal.
     * @param pluginName diagnostic plugin identity
     * @param profile explicit behavioral role
     * @param plugins already-ordered plugins
     * @return fixture session
     */
    public static Session open(final String pluginName, final Profile profile, final List<ShenyuPlugin> plugins) {
        return open(pluginName, profile, plugins, exchange -> Mono.empty());
    }

    /**
     * Open a fixture with an explicit response/terminal owner.
     * @param pluginName diagnostic identity
     * @param profile selected role
     * @param plugins explicit legacy order, never reordered
     * @param terminal response fixture, called per downstream subscription
     * @return fixture session
     */
    public static Session open(final String pluginName, final Profile profile, final List<ShenyuPlugin> plugins,
                               final Function<ServerWebExchange, Mono<Void>> terminal) {
        return new Session(pluginName, profile, plugins, terminal);
    }

    /**
     * Probe root assembly, without imposing purity on direct execute calls.
     * @param pluginName diagnostic identity
     * @param rootFactory real handler root publisher factory
     * @param effects observable request-side effect count
     */
    public static void assertDeferred(final String pluginName, final Supplier<Mono<Void>> rootFactory, final LongSupplier effects) {
        long before = effects.getAsLong();
        Objects.requireNonNull(rootFactory.get(), "root publisher");
        require(before == effects.getAsLong(), pluginName + "/ROOT: request effects occurred before root subscription");
    }

    /**
     * Check an explicitly supported data-handler removal contract using valid input.
     * @param pluginName diagnostic identity
     * @param handler actual handler
     * @param rule valid fixture, including any handle required for removal
     * @param cached request-free cache observation
     */
    public static void assertConfigurationRemoval(final String pluginName, final PluginDataHandler handler,
                                                 final RuleData rule, final Supplier<?> cached) {
        handler.handlerRule(rule);
        require(Objects.nonNull(cached.get()), pluginName + "/CONFIG: valid fixture was not published");
        handler.removeRule(rule);
        require(Objects.isNull(cached.get()), pluginName + "/CONFIG: stale state remained after supported removal");
    }

    private static void require(final boolean condition, final String message) {
        if (!condition) {
            throw new AssertionError(message);
        }
    }

    private static String version(final String artifact) {
        try (InputStream input = LegacyPluginContractKit.class.getResourceAsStream(
                "/META-INF/maven/org.apache.shenyu/" + artifact + "/pom.properties")) {
            if (Objects.isNull(input)) {
                return "unknown-development-classes";
            }
            Properties properties = new Properties();
            properties.load(input);
            return properties.getProperty("version", "unknown");
        } catch (IOException error) {
            return "unknown";
        }
    }

    /** Explicit profiles; plugin order does not imply a continuation contract. */
    public enum Profile {
        TRANSFORM, SHORT_CIRCUIT, WRAPPER, BASE_MATCHING, FORK
    }

    /**
     * Evidence labels, not a release compatibility matrix.
     * @param kitVersion observed packaged kit version
     * @param coreVersion observed core artifact version
     * @param declaredCoreRevision caller-declared source provenance, or unknown
     * @param profiles explicitly selected profiles
     * @param unsupported explicitly untested capabilities
     */
    public record Evidence(String kitVersion, String coreVersion, String declaredCoreRevision,
                           Set<Profile> profiles, Set<String> unsupported) {
        public Evidence {
            profiles = Set.copyOf(profiles);
            unsupported = Set.copyOf(unsupported);
        }
    }

    /** Static core caches and Spring context require serial fixture use. */
    public static final class Session implements AutoCloseable {

        private final String label;

        private final ApplicationContext previousContext;

        private final GenericApplicationContext context;

        private final AtomicInteger downstream = new AtomicInteger();

        private final MockServerWebExchange exchange;

        private final Mono<Void> root;

        private Session(final String name, final Profile profile, final List<ShenyuPlugin> plugins,
                        final Function<ServerWebExchange, Mono<Void>> terminal) {
            label = Objects.requireNonNull(name) + "/" + Objects.requireNonNull(profile);
            final List<ShenyuPlugin> snapshot = new ArrayList<>(List.copyOf(plugins));
            Objects.requireNonNull(terminal);
            previousContext = SpringBeanUtils.getInstance().getApplicationContext();
            context = new GenericApplicationContext();
            ShenyuConfig config = new ShenyuConfig();
            config.getScheduler().setEnabled(false);
            context.registerBean(ShenyuConfig.class, () -> config);
            context.refresh();
            SpringBeanUtils.getInstance().setApplicationContext(context);
            snapshot.add(new ShenyuPlugin() {
                @Override
                public Mono<Void> execute(final ServerWebExchange current, final ShenyuPluginChain chain) {
                    return Mono.defer(() -> {
                        downstream.incrementAndGet();
                        return terminal.apply(current);
                    });
                }

                @Override
                public int getOrder() {
                    return Integer.MAX_VALUE;
                }
            });
            exchange = MockServerWebExchange.from(MockServerHttpRequest.get("/contract/request").build());
            GatewayFixtures.initExchange(exchange);
            root = new ShenyuWebHandler(snapshot, null, config).handle(exchange);
        }

        /**
         * Access the owned request for response/decorator assertions.
         * @return fixture exchange
         */
        public MockServerWebExchange exchange() {
            return exchange;
        }

        /**
         * Register an explicitly owned test bean before subscribing the root.
         * @param type fixture bean type
         * @param factory fixture supplier; no SDK or credential is supplied by the kit
         * @param <T> bean type
         */
        public <T> void registerFixtureBean(final Class<T> type, final Supplier<T> factory) {
            context.registerBean(type, factory);
        }

        /**
         * Access the original root, including repeated root subscriptions.
         * @return real deferred handler publisher
         */
        public Mono<Void> publisher() {
            return root;
        }

        /**
         * Observe actual terminal subscriptions, distinct from method construction.
         * @return downstream subscription count
         */
        public int downstreamSubscriptions() {
            return downstream.get();
        }

        /**
         * Verify completion with an explicit role expectation; wrappers may declare multiple subscriptions.
         * @param expectedDownstream expected terminal subscriptions
         */
        public void verifyComplete(final int expectedDownstream) {
            try {
                StepVerifier.create(root).expectComplete().verify(Duration.ofSeconds(5));
            } catch (AssertionError error) {
                throw new AssertionError(label + ": completion contract failed", error);
            }
            require(downstream.get() == expectedDownstream, label + ": expected downstream subscriptions "
                    + expectedDownstream + " but observed " + downstream.get());
        }

        /**
         * Verify chain failure; outer HTTP error rendering is separate.
         * @param failure expected failure type
         */
        public void verifyError(final Class<? extends Throwable> failure) {
            try {
                StepVerifier.create(root).expectError(failure).verify(Duration.ofSeconds(5));
            } catch (AssertionError error) {
                throw new AssertionError(label + ": error propagation contract failed", error);
            }
        }

        /**
         * Cancel the real root after controlled subscribed-state checks.
         * @param afterSubscribed controlled signal/assertions, without sleeps
         */
        public void verifyCancellation(final Runnable afterSubscribed) {
            try {
                StepVerifier.create(root).then(afterSubscribed).thenCancel().verify(Duration.ofSeconds(5));
            } catch (AssertionError error) {
                throw new AssertionError(label + ": cancellation contract failed", error);
            }
        }

        /**
         * Check a decorator reached the actual response owner.
         * @param header response header
         * @param expected expected value
         */
        public void assertResponseHeader(final String header, final String expected) {
            require(Objects.equals(expected, exchange.getResponse().getHeaders().getFirst(header)),
                    label + ": response decorator/header propagation failed for " + header);
        }

        /**
         * Create an independent owner-termination probe.
         * @return release probe
         */
        public ReleaseProbe releaseProbe() {
            return new ReleaseProbe(label);
        }

        @Override
        public void close() {
            if (SpringBeanUtils.getInstance().getApplicationContext() == context) {
                SpringBeanUtils.getInstance().setApplicationContext(previousContext);
            }
            context.close();
        }
    }

    /** Optional resource-owner probe, not a universal SDK lease contract. */
    public static final class ReleaseProbe {

        private final String label;

        private final AtomicInteger releases = new AtomicInteger();

        private final Sinks.One<SignalType> signal = Sinks.one();

        private ReleaseProbe(final String label) {
            this.label = label;
        }

        /**
         * Record actual owner termination, for example from its doFinally hook.
         * @param terminal owner terminal signal
         */
        public void record(final SignalType terminal) {
            releases.incrementAndGet();
            signal.tryEmitValue(terminal);
        }

        /**
         * Await the controlled owner signal and require one release.
         * @param expected terminal classification
         * @param timeout explicit bounded test wait
         */
        public void assertReleasedOnce(final SignalType expected, final Duration timeout) {
            try {
                StepVerifier.create(signal.asMono()).expectNext(expected).expectComplete().verify(timeout);
            } catch (AssertionError error) {
                throw new AssertionError(label + ": owner cleanup/cancellation signal missing or incorrect", error);
            }
            require(releases.get() == 1, label + ": resource released " + releases.get() + " times");
        }
    }
}
