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
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.Objects;

/**
 * Terminal chain fixture that writes a fixed HTTP response.
 */
public final class TerminalResponsePlugin implements ShenyuPlugin {

    private final HttpStatus status;

    private final String body;

    private final MediaType contentType;

    private final int order;

    private TerminalResponsePlugin(final HttpStatus status, final String body,
                                   final MediaType contentType, final int order) {
        this.status = Objects.requireNonNull(status, "status");
        this.body = Objects.requireNonNull(body, "body");
        this.contentType = Objects.requireNonNull(contentType, "contentType");
        this.order = order;
    }

    /**
     * Create an OK terminal response.
     *
     * @param body fixed response body
     * @return terminal response plugin
     */
    public static TerminalResponsePlugin ok(final String body) {
        return new TerminalResponsePlugin(HttpStatus.OK, body, MediaType.TEXT_PLAIN, Integer.MAX_VALUE);
    }

    /**
     * Create a terminal response.
     *
     * @param status response status
     * @param body fixed response body
     * @param contentType response content type
     * @return terminal response plugin
     */
    public static TerminalResponsePlugin response(final HttpStatus status, final String body, final MediaType contentType) {
        return new TerminalResponsePlugin(status, body, contentType, Integer.MAX_VALUE);
    }

    @Override
    public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
        final byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        final DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(bytes);
        exchange.getResponse().setStatusCode(status);
        exchange.getResponse().getHeaders().setContentType(contentType);
        exchange.getResponse().getHeaders().setContentLength(bytes.length);
        return exchange.getResponse().writeWith(Mono.just(buffer));
    }

    @Override
    public int getOrder() {
        return order;
    }

    @Override
    public String named() {
        return "store-test-terminal-response";
    }
}
