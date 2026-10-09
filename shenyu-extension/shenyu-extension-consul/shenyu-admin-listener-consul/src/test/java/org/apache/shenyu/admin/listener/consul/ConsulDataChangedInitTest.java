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

package org.apache.shenyu.admin.listener.consul;

import com.ecwid.consul.v1.ConsulClient;
import com.ecwid.consul.v1.Response;
import com.ecwid.consul.v1.kv.model.GetValue;
import org.apache.shenyu.common.constant.ConsulConstants;
import org.apache.shenyu.common.constant.DefaultPathConstants;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Set;

import static org.apache.shenyu.common.constant.Constants.PATH_SEPARATOR;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Test cases for {@link ConsulDataChangedInit}.
 */
@ExtendWith(MockitoExtension.class)
public class ConsulDataChangedInitTest {

    private static final String PLUGIN_DATA_PATH = normalizePath(ConsulConstants.PLUGIN_DATA);

    private static final String AUTH_DATA_PATH = normalizePath(ConsulConstants.AUTH_DATA);

    private static final String META_DATA_PATH = normalizePath(ConsulConstants.META_DATA);

    private static final String PROXY_SELECTOR_PATH = normalizePath(DefaultPathConstants.PROXY_SELECTOR);

    private static final String DISCOVERY_UPSTREAM_PATH = normalizePath(DefaultPathConstants.DISCOVERY_UPSTREAM);

    private static final List<String> INIT_GATE_PATHS = List.of(
            PLUGIN_DATA_PATH, AUTH_DATA_PATH, META_DATA_PATH, PROXY_SELECTOR_PATH, DISCOVERY_UPSTREAM_PATH);

    @Mock
    private ConsulClient consulClient;

    @Test
    public void testNotExist() throws Exception {
        final ConsulDataChangedInit consulDataChangedInit = new ConsulDataChangedInit(consulClient);
        assertNotNull(consulDataChangedInit);

        givenExistingPaths(PLUGIN_DATA_PATH, AUTH_DATA_PATH, META_DATA_PATH, PROXY_SELECTOR_PATH,
                DISCOVERY_UPSTREAM_PATH);
        assertFalse(consulDataChangedInit.notExist(), "all init gate paths exist.");
    }

    @Test
    public void testNotExistWhenProxySelectorMissing() throws Exception {
        final ConsulDataChangedInit consulDataChangedInit = new ConsulDataChangedInit(consulClient);
        givenExistingPaths(PLUGIN_DATA_PATH, AUTH_DATA_PATH, META_DATA_PATH);

        assertTrue(consulDataChangedInit.notExist(), "proxy selector data path not exist.");
    }

    @Test
    public void testNotExistWhenDiscoveryUpstreamMissing() throws Exception {
        final ConsulDataChangedInit consulDataChangedInit = new ConsulDataChangedInit(consulClient);
        givenExistingPaths(PLUGIN_DATA_PATH, AUTH_DATA_PATH, META_DATA_PATH, PROXY_SELECTOR_PATH);

        assertTrue(consulDataChangedInit.notExist(), "discovery upstream data path not exist.");
    }

    @Test
    public void testNotExistChecksExpectedPaths() throws Exception {
        final ConsulDataChangedInit consulDataChangedInit = new ConsulDataChangedInit(consulClient);
        givenExistingPaths(PLUGIN_DATA_PATH, AUTH_DATA_PATH, META_DATA_PATH, PROXY_SELECTOR_PATH,
                DISCOVERY_UPSTREAM_PATH);

        assertFalse(consulDataChangedInit.notExist(), "all init gate paths exist.");

        final ArgumentCaptor<String> pathCaptor = ArgumentCaptor.forClass(String.class);
        verify(consulClient, times(INIT_GATE_PATHS.size())).getKVValue(pathCaptor.capture());
        assertEquals(INIT_GATE_PATHS, pathCaptor.getAllValues());
    }

    private void givenExistingPaths(final String... paths) {
        final Set<String> existingPaths = Set.of(paths);
        when(consulClient.getKVValue(anyString())).thenAnswer(invocation -> response(
                existingPaths.contains(invocation.getArgument(0)) ? new GetValue() : null));
    }

    @SuppressWarnings("unchecked")
    private static Response<GetValue> response(final GetValue value) {
        final Response<GetValue> response = mock(Response.class);
        when(response.getValue()).thenReturn(value);
        return response;
    }

    private static String normalizePath(final String path) {
        return path.startsWith(PATH_SEPARATOR) ? path.substring(PATH_SEPARATOR.length()) : path;
    }
}
