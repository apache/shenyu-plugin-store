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
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.web.handler.ShenyuWebHandler;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.http.server.reactive.ReactorHttpHandlerAdapter;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.server.adapter.WebHttpHandlerBuilder;
import reactor.core.publisher.Mono;
import reactor.netty.DisposableServer;
import reactor.netty.http.client.HttpClient;
import reactor.netty.http.server.HttpServer;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * Real random-port Reactor Netty gateway backed by {@link ShenyuWebHandler}.
 */
public final class ShenyuGatewayTestServer implements AutoCloseable {

    private static final Duration REQUEST_TIMEOUT = Duration.ofSeconds(10);

    private final DisposableServer server;

    private final WebClient webClient;

    private ShenyuGatewayTestServer(final DisposableServer server) {
        this.server = server;
        this.webClient = WebClient.builder()
                .baseUrl(baseUrl())
                .clientConnector(new ReactorClientHttpConnector(HttpClient.create()))
                .build();
    }

    /**
     * Start a gateway using the supplied plugins and a fixed terminal response.
     *
     * @param plugins plugins to execute before the terminal fixture
     * @return running gateway server
     */
    public static ShenyuGatewayTestServer start(final List<ShenyuPlugin> plugins) {
        return start(plugins, TerminalResponsePlugin.ok("shenyu-store-test-support"));
    }

    /**
     * Start a gateway using the supplied plugins and terminal fixture.
     *
     * @param plugins plugins to execute before the terminal fixture
     * @param terminalResponsePlugin terminal response fixture
     * @return running gateway server
     */
    public static ShenyuGatewayTestServer start(final List<ShenyuPlugin> plugins,
                                                final TerminalResponsePlugin terminalResponsePlugin) {
        Objects.requireNonNull(plugins, "plugins");
        Objects.requireNonNull(terminalResponsePlugin, "terminalResponsePlugin");
        List<ShenyuPlugin> chain = new ArrayList<>(plugins);
        chain.add(terminalResponsePlugin);
        ShenyuWebHandler webHandler = new ShenyuWebHandler(chain, null, new ShenyuConfig());
        HttpHandler httpHandler = WebHttpHandlerBuilder.webHandler(webHandler)
                .filter((exchange, next) -> {
                    GatewayFixtures.initExchange(exchange);
                    return next.filter(exchange);
                })
                .build();
        DisposableServer disposableServer = HttpServer.create()
                .host("127.0.0.1")
                .port(0)
                .handle(new ReactorHttpHandlerAdapter(httpHandler))
                .bindNow();
        return new ShenyuGatewayTestServer(disposableServer);
    }

    /**
     * Start a gateway with no user plugins.
     *
     * @return running gateway server
     */
    public static ShenyuGatewayTestServer start() {
        return start(Collections.emptyList());
    }

    /**
     * Create an {@link ApplicationContextRunner} for consumers that want
     * starter-created plugin beans.
     *
     * @return application context runner
     */
    public static ApplicationContextRunner contextRunner() {
        return new ApplicationContextRunner();
    }

    /**
     * Gateway base URL.
     *
     * @return base URL
     */
    public String baseUrl() {
        return "http://" + server.host() + ':' + server.port();
    }

    /**
     * Gateway port.
     *
     * @return port
     */
    public int port() {
        return server.port();
    }

    /**
     * Execute a GET request against the gateway.
     *
     * @param path request path
     * @return gateway response
     */
    public GatewayResponse get(final String path) {
        return exchange(HttpMethod.GET, path, null);
    }

    /**
     * Execute a POST request against the gateway.
     *
     * @param path request path
     * @param body request body
     * @return gateway response
     */
    public GatewayResponse post(final String path, final String body) {
        return exchange(HttpMethod.POST, path, body);
    }

    /**
     * Execute a request against the gateway.
     *
     * @param method HTTP method
     * @param path request path
     * @param body nullable request body
     * @return gateway response
     */
    public GatewayResponse exchange(final HttpMethod method, final String path, final String body) {
        WebClient.RequestBodySpec request = webClient.method(method).uri(path);
        WebClient.RequestHeadersSpec<?> headersSpec = Objects.isNull(body) ? request : request.bodyValue(body);
        return headersSpec.exchangeToMono(response -> response.toEntity(String.class))
                .map(entity -> new GatewayResponse(entity.getStatusCode().value(), HttpHeaders.readOnlyHttpHeaders(entity.getHeaders()),
                        Objects.requireNonNullElse(entity.getBody(), "")))
                .switchIfEmpty(Mono.error(new IllegalStateException("Gateway response was empty")))
                .block(REQUEST_TIMEOUT);
    }

    /**
     * Stop the server and clear gateway fixture cache.
     */
    @Override
    public void close() {
        server.disposeNow();
        GatewayFixtures.cleanBaseDataCache();
    }
}
