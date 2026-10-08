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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.MetaDataCache;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;
import java.util.stream.Collectors;

/**
 * Test-only gateway cache endpoint for original E2E clients.
 */
final class E2eCacheEndpoint implements WebFilter {

    private static final String PATH_PREFIX = "/shenyu/e2e";

    private static final String LOCAL_KEY = "123456";

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private final List<ShenyuPlugin> plugins;

    E2eCacheEndpoint(final List<ShenyuPlugin> plugins) {
        this.plugins = plugins;
    }

    @Override
    public Mono<Void> filter(final ServerWebExchange exchange, final WebFilterChain chain) {
        String path = exchange.getRequest().getURI().getRawPath();
        if (!path.startsWith(PATH_PREFIX)) {
            return chain.filter(exchange);
        }
        if (!LOCAL_KEY.equals(exchange.getRequest().getHeaders().getFirst(Constants.LOCAL_KEY))) {
            exchange.getResponse().setStatusCode(HttpStatus.FORBIDDEN);
            return exchange.getResponse().setComplete();
        }
        switch (path.substring(PATH_PREFIX.length())) {
            case "/metadata":
                return writeJson(exchange, Collections.singletonList(metadata()));
            case "/selectorData":
                return writeJson(exchange, Collections.singletonList(selectorData()));
            case "/ruleData":
                return writeJson(exchange, Collections.singletonList(ruleData()));
            case "/plugins":
                return writeJson(exchange, Collections.singletonList(pluginData()));
            default:
                exchange.getResponse().setStatusCode(HttpStatus.NOT_FOUND);
                return exchange.getResponse().setComplete();
        }
    }

    private Map<String, MetaData> metadata() {
        return MetaDataCache.getInstance().getMetaDataMap();
    }

    private ConcurrentMap<String, List<SelectorData>> selectorData() {
        return BaseDataCache.getInstance().getSelectorMap();
    }

    private ConcurrentMap<String, List<RuleData>> ruleData() {
        return BaseDataCache.getInstance().getRuleMap();
    }

    private Map<String, Integer> pluginData() {
        Map<String, Integer> pluginMap = plugins.stream()
                .collect(Collectors.toMap(plugin -> plugin.getClass().getName(), ShenyuPlugin::getOrder, (left, right) -> left));
        ConcurrentMap<String, PluginData> cachedPlugins = BaseDataCache.getInstance().getPluginMap();
        cachedPlugins.forEach((pluginName, pluginData) -> pluginMap.putIfAbsent(pluginName, pluginData.getSort()));
        return pluginMap;
    }

    private Mono<Void> writeJson(final ServerWebExchange exchange, final Object body) {
        byte[] json;
        try {
            json = MAPPER.writeValueAsBytes(body);
        } catch (JsonProcessingException ex) {
            return Mono.error(ex);
        }
        exchange.getResponse().setStatusCode(HttpStatus.OK);
        exchange.getResponse().getHeaders().setContentType(MediaType.APPLICATION_JSON);
        DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(json);
        return exchange.getResponse().writeWith(Mono.just(buffer));
    }
}
