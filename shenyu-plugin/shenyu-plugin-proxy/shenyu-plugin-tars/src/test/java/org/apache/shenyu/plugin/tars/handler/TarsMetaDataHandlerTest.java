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

package org.apache.shenyu.plugin.tars.handler;

import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.enums.RpcTypeEnum;
import org.apache.shenyu.plugin.tars.cache.ApplicationConfigCache;
import org.apache.shenyu.plugin.tars.proxy.TarsInvokePrx;
import org.apache.shenyu.plugin.tars.proxy.TarsInvokePrxList;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.MockedStatic;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Test case for {@link org.apache.shenyu.plugin.tars.handler.TarsMetaDataHandler}.
 */
@ExtendWith(MockitoExtension.class)
public class TarsMetaDataHandlerTest {

    private TarsMetaDataHandler tarsMetaDataHandler;

    private MetaData metaData;

    @BeforeEach
    public void setUp() {
        metaData = new MetaData("id", "127.0.0.1:8080", "contextPath",
                "path", RpcTypeEnum.TARS.getName(), "serviceName", "method1",
                "parameterTypes", "{\"methodInfo\":[{\"methodName\":\"method1\",\"params\":[{\"left\":\"int\",\"right\":\"param1\"},"
                + "{\"left\":\"java.lang.Integer\",\"right\":\"param2\"}],\"returnType\":\"java.lang.String\"}]}", false, Constants.SYS_DEFAULT_NAMESPACE_ID);
        tarsMetaDataHandler = new TarsMetaDataHandler();
    }

    @Test
    public void testApplicationNameDoesNotNeedToEqualUpstreamHost() {
        metaData.setAppName("HelloApp");
        metaData.setPath("/dedup");
        ApplicationConfigCache cache = mock(ApplicationConfigCache.class);
        TarsInvokePrxList proxies = new TarsInvokePrxList();
        proxies.getTarsInvokePrxList().add(new TarsInvokePrx(new Object(), "192.0.2.1:1080"));
        try (MockedStatic<ApplicationConfigCache> singleton = mockStatic(ApplicationConfigCache.class)) {
            singleton.when(ApplicationConfigCache::getInstance).thenReturn(cache);
            when(cache.get(metaData.getPath())).thenReturn(proxies);
            tarsMetaDataHandler.handle(metaData);
            tarsMetaDataHandler.handle(metaData);
            verify(cache).initPrx(metaData);
            tarsMetaDataHandler.remove(metaData);
            assertTrue(proxies.getTarsInvokePrxList().isEmpty());
        }
    }

    @Test
    public void testChangedDescriptorInitializesOnceForTheSamePath() {
        final String path = "/descriptor-update";
        final MetaData initial = new MetaData();
        initial.setPath(path);
        initial.setAppName("OriginalApp");
        final MetaData updated = new MetaData();
        updated.setPath(path);
        updated.setAppName("ReplacementApp");
        final MetaData replay = new MetaData();
        replay.setPath(path);
        replay.setAppName("ReplacementApp");

        final ApplicationConfigCache cache = mock(ApplicationConfigCache.class);
        final TarsInvokePrxList proxies = new TarsInvokePrxList();
        proxies.getTarsInvokePrxList().add(new TarsInvokePrx(new Object(), "192.0.2.1:1080"));
        try (MockedStatic<ApplicationConfigCache> singleton = mockStatic(ApplicationConfigCache.class)) {
            singleton.when(ApplicationConfigCache::getInstance).thenReturn(cache);
            when(cache.get(path)).thenReturn(proxies);
            try {
                tarsMetaDataHandler.handle(initial);
                tarsMetaDataHandler.handle(updated);
                tarsMetaDataHandler.handle(replay);
                verify(cache).initPrx(initial);
                verify(cache).initPrx(updated);
            } finally {
                tarsMetaDataHandler.remove(replay);
            }
        }
    }

    @Test
    public void testEmptyProxyListRetriesInitialization() {
        metaData.setPath("/retry");
        ApplicationConfigCache cache = mock(ApplicationConfigCache.class);
        try (MockedStatic<ApplicationConfigCache> singleton = mockStatic(ApplicationConfigCache.class)) {
            singleton.when(ApplicationConfigCache::getInstance).thenReturn(cache);
            when(cache.get(metaData.getPath())).thenReturn(new TarsInvokePrxList());
            tarsMetaDataHandler.handle(metaData);
            tarsMetaDataHandler.handle(metaData);
            verify(cache, times(2)).initPrx(metaData);
            tarsMetaDataHandler.remove(metaData);
        }
    }

    @Test
    public void testOnSubscribe() {
        tarsMetaDataHandler.handle(metaData);
        /**
         * test for cache;
         */
        tarsMetaDataHandler.handle(metaData);
    }

    @Test
    public void testUnSubscribe() {
        tarsMetaDataHandler.remove(metaData);
    }
}
