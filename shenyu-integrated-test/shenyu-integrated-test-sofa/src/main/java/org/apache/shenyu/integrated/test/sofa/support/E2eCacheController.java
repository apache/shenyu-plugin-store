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

package org.apache.shenyu.integrated.test.sofa.support;

import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.base.cache.BaseDataCache;
import org.apache.shenyu.plugin.base.cache.MetaDataCache;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;
import java.util.stream.Collectors;

/**
 * Exposes gateway cache snapshots for the original E2E data-sync helper.
 */
@RestController
@RequestMapping("/shenyu/e2e")
public class E2eCacheController {

    private final List<ShenyuPlugin> plugins;

    public E2eCacheController(final List<ShenyuPlugin> plugins) {
        this.plugins = plugins;
    }

    /**
     * Gets metadata cache.
     *
     * @return singleton cache snapshot list
     */
    @GetMapping("/metadata")
    public List<Map<String, MetaData>> metadata() {
        return Collections.singletonList(MetaDataCache.getInstance().getMetaDataMap());
    }

    /**
     * Gets selector cache.
     *
     * @return singleton cache snapshot list
     */
    @GetMapping("/selectorData")
    public List<ConcurrentMap<String, List<SelectorData>>> selectorData() {
        return Collections.singletonList(BaseDataCache.getInstance().getSelectorMap());
    }

    /**
     * Gets rule cache.
     *
     * @return singleton cache snapshot list
     */
    @GetMapping("/ruleData")
    public List<ConcurrentMap<String, List<RuleData>>> ruleData() {
        return Collections.singletonList(BaseDataCache.getInstance().getRuleMap());
    }

    /**
     * Gets loaded plugin classes.
     *
     * @return singleton plugin class map list
     */
    @GetMapping("/plugins")
    public List<Map<String, Integer>> plugins() {
        Map<String, Integer> pluginMap = plugins.stream()
                .collect(Collectors.toMap(plugin -> plugin.getClass().getName(), ShenyuPlugin::getOrder, (left, right) -> left));
        ConcurrentMap<String, PluginData> cachedPlugins = BaseDataCache.getInstance().getPluginMap();
        cachedPlugins.forEach((pluginName, pluginData) -> pluginMap.putIfAbsent(pluginName, pluginData.getSort()));
        return Collections.singletonList(pluginMap);
    }
}
