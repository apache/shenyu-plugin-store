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

import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.ConditionData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.enums.MatchModeEnum;
import org.apache.shenyu.common.enums.OperatorEnum;
import org.apache.shenyu.common.enums.ParamTypeEnum;
import org.apache.shenyu.common.enums.RpcTypeEnum;
import org.apache.shenyu.common.enums.SelectorTypeEnum;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.context.ShenyuContext;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.web.server.ServerWebExchange;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Objects;
import java.util.UUID;

/**
 * Fixture builders for gateway-level plugin tests.
 */
public final class GatewayFixtures {

    private GatewayFixtures() {
    }

    /**
     * Cache an enabled plugin fixture using the plugin's name and order.
     *
     * @param plugin plugin under test
     * @return cached plugin data
     */
    public static PluginData cachePlugin(final ShenyuPlugin plugin) {
        return cachePlugin(plugin.named(), plugin.getOrder());
    }

    /**
     * Cache an enabled plugin fixture.
     *
     * @param pluginName plugin name
     * @param sort plugin sort
     * @return cached plugin data
     */
    public static PluginData cachePlugin(final String pluginName, final int sort) {
        PluginData pluginData = PluginData.builder()
                .id(id("plugin"))
                .name(pluginName)
                .enabled(true)
                .sort(sort)
                .build();
        BaseDataCache.getInstance().cachePluginData(pluginData);
        return pluginData;
    }

    /**
     * Cache a selector that matches every URI for the plugin.
     *
     * @param pluginName plugin name
     * @return cached selector data
     */
    public static SelectorData cacheSelector(final String pluginName) {
        SelectorData selectorData = SelectorData.builder()
                .id(id("selector"))
                .pluginName(pluginName)
                .name(pluginName + "-selector")
                .enabled(true)
                .logged(true)
                .continued(true)
                .sort(1)
                .matchMode(MatchModeEnum.AND.getCode())
                .matchRestful(false)
                .type(SelectorTypeEnum.CUSTOM_FLOW.getCode())
                .conditionList(Collections.singletonList(uriCondition("/**")))
                .build();
        BaseDataCache.getInstance().cacheSelectData(selectorData);
        return selectorData;
    }

    /**
     * Cache a rule that matches every URI for the selector.
     *
     * @param pluginName plugin name
     * @param selectorId selector id
     * @param handle plugin rule handle
     * @return cached rule data
     */
    public static RuleData cacheRule(final String pluginName, final String selectorId, final String handle) {
        RuleData ruleData = RuleData.builder()
                .id(id("rule"))
                .pluginName(pluginName)
                .selectorId(selectorId)
                .name(pluginName + "-rule")
                .enabled(true)
                .loged(true)
                .sort(1)
                .matchMode(MatchModeEnum.AND.getCode())
                .matchRestful(false)
                .handle(handle)
                .conditionDataList(Collections.singletonList(uriCondition("/**")))
                .build();
        BaseDataCache.getInstance().cacheRuleData(ruleData);
        return ruleData;
    }

    /**
     * Cache plugin, selector, and rule fixtures for a plugin.
     *
     * @param plugin plugin under test
     * @param handle plugin rule handle
     * @return cached data handles
     */
    public static CachedPluginData cachePluginRoute(final ShenyuPlugin plugin, final String handle) {
        PluginData pluginData = cachePlugin(plugin);
        SelectorData selectorData = cacheSelector(plugin.named());
        RuleData ruleData = cacheRule(plugin.named(), selectorData.getId(), handle);
        return new CachedPluginData(pluginData, selectorData, ruleData);
    }

    /**
     * Build a default ShenYu context from a real HTTP exchange.
     *
     * @param exchange server exchange
     * @return context populated with HTTP request data
     */
    public static ShenyuContext shenyuContext(final ServerWebExchange exchange) {
        ServerHttpRequest request = exchange.getRequest();
        String path = request.getURI().getRawPath();
        ShenyuContext context = new ShenyuContext();
        context.setRpcType(RpcTypeEnum.HTTP.getName());
        context.setHttpMethod(request.getMethod().name());
        context.setPath(path);
        context.setContextPath(path);
        context.setRealUrl(request.getURI().toString());
        context.setStartDateTime(LocalDateTime.now());
        return context;
    }

    /**
     * Put default ShenYu exchange attributes required by core plugins.
     *
     * @param exchange server exchange
     */
    public static void initExchange(final ServerWebExchange exchange) {
        exchange.getAttributes().put(Constants.CONTEXT, shenyuContext(exchange));
        exchange.getAttributes().put(Constants.PARAM_TRANSFORM, "{}");
    }

    /**
     * Remove all cached base data.
     */
    public static void cleanBaseDataCache() {
        BaseDataCache.getInstance().cleanPluginData();
        BaseDataCache.getInstance().cleanSelectorData();
        BaseDataCache.getInstance().cleanRuleData();
    }

    private static ConditionData uriCondition(final String pattern) {
        ConditionData conditionData = new ConditionData();
        conditionData.setParamType(ParamTypeEnum.URI.getName());
        conditionData.setOperator(OperatorEnum.MATCH.getAlias());
        conditionData.setParamName("/");
        conditionData.setParamValue(pattern);
        return conditionData;
    }

    private static String id(final String prefix) {
        return prefix + '-' + UUID.randomUUID();
    }

    /**
     * Cached plugin, selector, and rule data.
     */
    public static final class CachedPluginData {

        private final PluginData pluginData;

        private final SelectorData selectorData;

        private final RuleData ruleData;

        private CachedPluginData(final PluginData pluginData, final SelectorData selectorData, final RuleData ruleData) {
            this.pluginData = Objects.requireNonNull(pluginData, "pluginData");
            this.selectorData = Objects.requireNonNull(selectorData, "selectorData");
            this.ruleData = Objects.requireNonNull(ruleData, "ruleData");
        }

        /**
         * Get plugin data.
         *
         * @return plugin data
         */
        public PluginData getPluginData() {
            return pluginData;
        }

        /**
         * Get selector data.
         *
         * @return selector data
         */
        public SelectorData getSelectorData() {
            return selectorData;
        }

        /**
         * Get rule data.
         *
         * @return rule data
         */
        public RuleData getRuleData() {
            return ruleData;
        }
    }
}
