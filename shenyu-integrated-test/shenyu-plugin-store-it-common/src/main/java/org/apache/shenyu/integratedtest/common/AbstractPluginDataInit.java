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

package org.apache.shenyu.integratedtest.common;

import org.apache.shenyu.common.dto.AuthParamData;
import org.apache.shenyu.common.dto.AuthPathData;
import org.apache.shenyu.common.dto.AppAuthData;
import org.apache.shenyu.common.dto.ConditionData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.integratedtest.common.helper.HttpHelper;
import org.apache.shenyu.web.controller.LocalPluginController.RuleLocalData;
import org.apache.shenyu.web.controller.LocalPluginController.SelectorRulesData;

import java.io.IOException;
import java.net.URI;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

/**
 * The type Abstract plugin data init.
 */
public class AbstractPluginDataInit extends AbstractTest {

    private static final String STORE_HTTP_UPSTREAM_PROPERTY = "shenyu.store.http.upstream";

    private static final String STORE_HTTP_UPSTREAM_ENV = "SHENYU_STORE_HTTP_UPSTREAM";

    /**
     * Init plugin string.
     *
     * @param pluginName the plugin name
     * @param config the config
     * @return the string
     * @throws IOException the io exception
     */
    public static String initPlugin(final String pluginName, final String config) throws IOException {
        PluginData pluginData = new PluginData();
        pluginData.setEnabled(true);
        pluginData.setName(pluginName);
        pluginData.setConfig(config);
        pluginData.setId(UUID.randomUUID().toString().replace(" ", ""));
        return HttpHelper.INSTANCE.postGateway("/shenyu/plugin/saveOrUpdate", pluginData, String.class);
    }

    /**
     * Init selector and rules string.
     *
     * @param pluginName the plugin name
     * @param selectorHandler the selector handler
     * @param selectorConditionData the selector condition data
     * @param ruleDataList the rule data list
     * @return the string
     * @throws IOException the io exception
     */
    public static String initSelectorAndRules(final String pluginName, final String selectorHandler,
                                       final List<ConditionData> selectorConditionData,
                                       final List<RuleLocalData> ruleDataList) throws IOException {
        return initSelectorAndRules(pluginName, selectorHandler, 10, selectorConditionData, ruleDataList);
    }

    /**
     * Init selector and rules string.
     *
     * @param pluginName the plugin name
     * @param selectorHandler the selector handler
     * @param selectorConditionData the selector condition data
     * @param sort the sort
     * @param ruleDataList the rule data list
     * @return the string
     * @throws IOException the io exception
     */
    public static String initSelectorAndRules(final String pluginName, final String selectorHandler,
                                              final Integer sort, final List<ConditionData> selectorConditionData,
                                              final List<RuleLocalData> ruleDataList) throws IOException {
        SelectorRulesData selectorRulesData = new SelectorRulesData();
        selectorRulesData.setPluginName(pluginName);
        selectorRulesData.setSelectorHandler(selectorHandler);
        selectorRulesData.setSort(sort);
        selectorRulesData.setConditionDataList(selectorConditionData);
        selectorRulesData.setRuleDataList(ruleDataList);
        return HttpHelper.INSTANCE.postGateway("/shenyu/plugin/selectorAndRules", selectorRulesData, String.class);
    }

    /**
     * Clean plugin data string.
     *
     * @param pluginName the plugin name
     * @return the string
     * @throws IOException the io exception
     */
    public static String cleanPluginData(final String pluginName) throws IOException {
        String result = HttpHelper.INSTANCE.getFromGateway("/shenyu/cleanPlugin?name=" + pluginName, String.class);
        ensureHarnessHttpRoute(pluginName);
        return result;
    }

    private static void ensureHarnessHttpRoute(final String cleanedPluginName) throws IOException {
        if ("divide".equals(cleanedPluginName)) {
            return;
        }
        String upstream = System.getProperty(STORE_HTTP_UPSTREAM_PROPERTY,
                System.getenv().getOrDefault(STORE_HTTP_UPSTREAM_ENV, ""));
        if (upstream.isEmpty()) {
            return;
        }
        URI upstreamUri = URI.create(upstream);
        String protocol = upstreamUri.getScheme() + "://";
        String upstreamUrl = upstreamUri.getHost() + ":" + upstreamUri.getPort();
        HttpHelper.INSTANCE.getFromGateway("/shenyu/cleanPlugin?name=divide", String.class);
        initPlugin("divide", "");
        initSelectorAndRules("divide", buildHarnessSelectorHandler(protocol, upstreamUrl),
                buildHarnessUriMatchConditionList(), buildHarnessRuleLocalDataList());
    }

    private static String buildHarnessSelectorHandler(final String protocol, final String upstreamUrl) {
        String upstreamHost = upstreamUrl.split(":")[0];
        return "[{\"upstreamHost\":\"" + escapeJson(upstreamHost)
                + "\",\"protocol\":\"" + escapeJson(protocol)
                + "\",\"upstreamUrl\":\"" + escapeJson(upstreamUrl)
                + "\",\"weight\":50,\"status\":true,\"timestamp\":0,\"warmup\":0,"
                + "\"healthCheckEnabled\":false}]";
    }

    private static String escapeJson(final String value) {
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private static List<ConditionData> buildHarnessUriMatchConditionList() {
        ConditionData conditionData = new ConditionData();
        conditionData.setParamType("uri");
        conditionData.setOperator("match");
        conditionData.setParamValue("/http/**");
        return Collections.singletonList(conditionData);
    }

    private static List<RuleLocalData> buildHarnessRuleLocalDataList() {
        RuleLocalData ruleLocalData = new RuleLocalData();
        ruleLocalData.setRuleHandler("{}");
        ruleLocalData.setConditionDataList(buildHarnessUriMatchConditionList());
        return Collections.singletonList(ruleLocalData);
    }

    /**
     * Init auth data.
     *
     * @param appKey the appKey
     * @param appSecret the appSecret
     * @param paramDataList the paramDataList
     * @param pathDataList the pathDataList
     * @return the response string
     * @throws IOException the io exception
     */
    public static String initAuthData(final String appKey, final String appSecret,
                                      final List<AuthParamData> paramDataList,
                                      final List<AuthPathData> pathDataList) throws IOException {
        AppAuthData appAuthData = new AppAuthData();
        appAuthData.setEnabled(true);
        appAuthData.setOpen(true);
        appAuthData.setAppKey(appKey);
        appAuthData.setAppSecret(appSecret);
        appAuthData.setParamDataList(paramDataList);
        appAuthData.setPathDataList(pathDataList);
        return HttpHelper.INSTANCE.postGateway("/shenyu/auth/saveOrUpdate", appAuthData, String.class);
    }

    /**
     * Clean auth data.
     *
     * @param appKey the appKey
     * @throws IOException the io exception
     */
    public static void cleanAuthData(final String appKey) throws IOException {
        HttpHelper.INSTANCE.getFromGateway("/shenyu/auth/delete?appKey=" + appKey, String.class);
    }
}
