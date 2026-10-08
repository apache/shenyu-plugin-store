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
import org.apache.shenyu.admin.listener.AbstractDataChangedInit;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.constant.ConsulConstants;
import org.apache.shenyu.common.constant.DefaultPathConstants;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/**
 * The type Consul data changed init.
 *
 * @since 2.5.0
 */
public class ConsulDataChangedInit extends AbstractDataChangedInit {

    private static final List<String> LEGACY_DATA_KEYS = Arrays.asList(
            ConsulConstants.PLUGIN_DATA, ConsulConstants.AUTH_DATA, ConsulConstants.META_DATA);

    private static final List<String> WATCHED_DATA_KEYS = Arrays.asList(
            DefaultPathConstants.PROXY_SELECTOR, DefaultPathConstants.DISCOVERY_UPSTREAM);

    private final ConsulClient consulClient;

    /**
     * Instantiates a new Consul data changed init.
     *
     * @param consulClient the Consul client
     */
    public ConsulDataChangedInit(final ConsulClient consulClient) {
        this.consulClient = consulClient;
    }

    @Override
    protected boolean notExist() {
        final boolean legacyDataNotExist = LEGACY_DATA_KEYS.stream().map(this::dataKeyNotExist).reduce(true, Boolean::logicalAnd);
        final boolean watchedDataMissing = WATCHED_DATA_KEYS.stream().map(this::dataKeyNotExist).reduce(false, Boolean::logicalOr);
        return legacyDataNotExist || watchedDataMissing;
    }

    private boolean dataKeyNotExist(final String dataKey) {
        return Objects.isNull(consulClient.getKVValue(normalizePath(dataKey)).getValue());
    }

    private static String normalizePath(final String path) {
        return path.startsWith(Constants.PATH_SEPARATOR) ? path.substring(Constants.PATH_SEPARATOR.length()) : path;
    }
}
