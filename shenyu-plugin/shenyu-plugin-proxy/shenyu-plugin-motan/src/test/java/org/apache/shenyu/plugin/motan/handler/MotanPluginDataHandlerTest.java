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

package org.apache.shenyu.plugin.motan.handler;

import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.utils.Singleton;
import org.apache.shenyu.plugin.motan.cache.ApplicationConfigCache;
import org.apache.shenyu.plugin.motan.config.MotanRegisterConfig;
import org.apache.shenyu.plugin.motan.dto.MotanUpstream;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.lang.reflect.Field;
import java.util.Objects;

/**
 * The Test Case For MotanPluginDataHandler.
 */
public final class MotanPluginDataHandlerTest {

    private MotanPluginDataHandler motanPluginDataHandler;

    private PluginData pluginData;

    @BeforeEach
    public void setUp() {
        this.motanPluginDataHandler = new MotanPluginDataHandler();
        this.pluginData = new PluginData();
    }

    @Test
    public void testHandlerPlugin() {
        pluginData = new PluginData("motan-plugin", "motan",
                "{\"registerAddress\" : \"127.0.0.1:2181\"}", "0", true, null);
        motanPluginDataHandler.handlerPlugin(pluginData);
        Assertions.assertEquals(Singleton.INST.get(MotanRegisterConfig.class).getRegisterAddress(), "127.0.0.1:2181");
    }

    @Test
    public void testPluginNamed() {
        Assertions.assertEquals(motanPluginDataHandler.pluginNamed(), "motan");
    }

    @Test
    public void testHandlerSelectorParsesReleasedApiUpstreamSettings() {
        SelectorData selectorData = new SelectorData();
        writeField(selectorData, "id", "motan-selector-test");
        selectorData.setHandle("{\"protocol\":\"motan\",\"registerProtocol\":\"zookeeper\",\"registerAddress\":\"127.0.0.1:2181\"}");

        motanPluginDataHandler.handlerSelector(selectorData);

        MotanUpstream upstream = ApplicationConfigCache.getInstance().getUpstream(selectorData.getId());
        Assertions.assertEquals("motan", upstream.getProtocol());
        Assertions.assertEquals("zookeeper", upstream.getRegisterProtocol());
        Assertions.assertEquals("127.0.0.1:2181", upstream.getRegisterAddress());
    }

    private static void writeField(final Object target, final String name, final Object value) {
        Class<?> type = target.getClass();
        while (Objects.nonNull(type)) {
            try {
                Field field = type.getDeclaredField(name);
                field.setAccessible(true);
                field.set(target, value);
                return;
            } catch (final NoSuchFieldException ex) {
                type = type.getSuperclass();
            } catch (final IllegalAccessException ex) {
                throw new IllegalStateException("Failed to set " + name, ex);
            }
        }
        throw new IllegalStateException("Field not found: " + name);
    }
}
