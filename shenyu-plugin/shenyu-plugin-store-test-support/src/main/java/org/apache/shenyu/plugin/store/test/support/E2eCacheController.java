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
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.MetaDataCache;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;
import java.util.stream.Collectors;

/**
 * Test-only gateway cache snapshots for original E2E clients.
 */
@RestController
@RequestMapping("/shenyu/e2e")
public final class E2eCacheController {

    private static final String LOCAL_KEY = "123456";

    private final List<ShenyuPlugin> plugins;

    public E2eCacheController(final List<ShenyuPlugin> plugins) {
        this.plugins = plugins;
    }

    /**
     * Gets metadata cache.
     *
     * @param localKey local controller guard header
     * @return singleton cache snapshot list
     */
    @GetMapping("/metadata")
    public List<Map<String, MetaData>> metadata(@RequestHeader(value = Constants.LOCAL_KEY, required = false) final String localKey) {
        checkLocalKey(localKey);
        return Collections.singletonList(MetaDataCache.getInstance().getMetaDataMap());
    }

    /**
     * Gets selector cache.
     *
     * @param localKey local controller guard header
     * @return singleton cache snapshot list
     */
    @GetMapping("/selectorData")
    public List<ConcurrentMap<String, List<SelectorData>>> selectorData(
            @RequestHeader(value = Constants.LOCAL_KEY, required = false) final String localKey) {
        checkLocalKey(localKey);
        return Collections.singletonList(BaseDataCache.getInstance().getSelectorMap());
    }

    /**
     * Gets rule cache.
     *
     * @param localKey local controller guard header
     * @return singleton cache snapshot list
     */
    @GetMapping("/ruleData")
    public List<ConcurrentMap<String, List<RuleData>>> ruleData(@RequestHeader(value = Constants.LOCAL_KEY, required = false) final String localKey) {
        checkLocalKey(localKey);
        return Collections.singletonList(BaseDataCache.getInstance().getRuleMap());
    }

    /**
     * Gets loaded plugin classes and cached plugin names.
     *
     * @param localKey local controller guard header
     * @return singleton plugin map list
     */
    @GetMapping("/plugins")
    public List<Map<String, Integer>> plugins(@RequestHeader(value = Constants.LOCAL_KEY, required = false) final String localKey) {
        checkLocalKey(localKey);
        Map<String, Integer> pluginMap = plugins.stream()
                .collect(Collectors.toMap(plugin -> plugin.getClass().getName(), ShenyuPlugin::getOrder, (left, right) -> left));
        ConcurrentMap<String, PluginData> cachedPlugins = BaseDataCache.getInstance().getPluginMap();
        cachedPlugins.forEach((pluginName, pluginData) -> pluginMap.putIfAbsent(pluginName, pluginData.getSort()));
        return Collections.singletonList(pluginMap);
    }

    private static void checkLocalKey(final String localKey) {
        if (!LOCAL_KEY.equals(localKey)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }
    }
}
