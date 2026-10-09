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

package org.apache.shenyu.sync.data.consul;

import com.ecwid.consul.v1.ConsulClient;
import com.ecwid.consul.v1.QueryParams;
import com.ecwid.consul.v1.Response;
import com.ecwid.consul.v1.kv.model.GetValue;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shenyu.common.concurrent.ShenyuThreadFactory;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.constant.ConsulConstants;
import org.apache.shenyu.common.constant.DefaultPathConstants;
import org.apache.shenyu.sync.data.api.AuthDataSubscriber;
import org.apache.shenyu.sync.data.api.DiscoveryUpstreamDataSubscriber;
import org.apache.shenyu.sync.data.api.MetaDataSubscriber;
import org.apache.shenyu.sync.data.api.PluginDataSubscriber;
import org.apache.shenyu.sync.data.api.ProxySelectorDataSubscriber;
import org.apache.shenyu.sync.data.consul.config.ConsulConfig;
import org.apache.shenyu.sync.data.core.AbstractPathDataSyncService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import static org.apache.shenyu.common.constant.DefaultPathConstants.handlePathData;

/**
 * Consul sync data service.
 */
public class ConsulSyncDataService extends AbstractPathDataSyncService {
    /**
     * logger.
     */
    private static final Logger LOG = LoggerFactory.getLogger(ConsulSyncDataService.class);

    private final Map<String, Long> consulIndexes = new ConcurrentHashMap<>();

    private final Map<String, List<ConsulData>> cacheConsulDataKeyMap = new ConcurrentHashMap<>();

    private final ScheduledThreadPoolExecutor executor;

    private final ConsulConfig consulConfig;

    private final ConsulClient consulClient;

    private final ShenyuConfig shenyuConfig;

    /**
     * Instantiates a new Consul sync data service.
     *
     * @param shenyuConfig the plugin data shenyuConfig
     * @param consulClient the plugin data consulClient
     * @param consulConfig the plugin data consulConfig
     * @param pluginDataSubscriber the plugin data subscriber
     * @param metaDataSubscribers  the meta data subscribers
     * @param authDataSubscribers  the auth data subscribers
     */
    public ConsulSyncDataService(final ShenyuConfig shenyuConfig,
                                 final ConsulClient consulClient,
                                 final ConsulConfig consulConfig,
                                 final PluginDataSubscriber pluginDataSubscriber,
                                 final List<MetaDataSubscriber> metaDataSubscribers,
                                 final List<AuthDataSubscriber> authDataSubscribers,
                                 final List<ProxySelectorDataSubscriber> proxySelectorDataSubscribers,
                                 final List<DiscoveryUpstreamDataSubscriber> discoveryUpstreamDataSubscribers) {
        super(pluginDataSubscriber, metaDataSubscribers, authDataSubscribers, proxySelectorDataSubscribers, discoveryUpstreamDataSubscribers);
        this.shenyuConfig = shenyuConfig;
        this.consulClient = consulClient;
        this.consulConfig = consulConfig;
        // corePool is the total number of watcher nodes
        this.executor = new ScheduledThreadPoolExecutor(7,
                ShenyuThreadFactory.create("consul-config-watch", true));
        watcherData();
    }

    private void watcherData() {
        String configNamespace = Constants.PATH_SEPARATOR + this.shenyuConfig.getNamespace();
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.PLUGIN_PARENT)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.SELECTOR_PARENT)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.RULE_PARENT)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.PROXY_SELECTOR)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.DISCOVERY_UPSTREAM)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.APP_AUTH_PARENT)));
        watcherData0(handlePathData(String.join(Constants.PATH_SEPARATOR, configNamespace, DefaultPathConstants.META_DATA)));
    }

    private void watcherData0(final String registerPath) {
        String configNamespace = Constants.PATH_SEPARATOR + shenyuConfig.getNamespace();
        consulIndexes.put(registerPath, 0L);
        BiConsumer<String, String> updateHandler = (changeData, decodedValue) -> this.event(configNamespace, changeData, decodedValue, registerPath, EventType.PUT);
        Consumer<String> deleteHandler = removeKey -> this.event(configNamespace, removeKey, null, registerPath, EventType.DELETE);
        this.executor.schedule(() -> watchConfigKeyValues(registerPath, updateHandler, deleteHandler), -1, TimeUnit.MILLISECONDS);
    }

    private void watchConfigKeyValues(final String watchPathRoot,
                                      final BiConsumer<String, String> updateHandler,
                                      final Consumer<String> deleteHandler) {
        try {
            Long currentIndex = this.consulIndexes.get(watchPathRoot);
            if (Objects.isNull(currentIndex)) {
                currentIndex = ConsulConstants.INIT_CONFIG_VERSION_INDEX;
            }
            Response<List<GetValue>> response = this.consulClient.getKVValues(normalizePath(watchPathRoot), null,
                    new QueryParams(TimeUnit.MILLISECONDS.toSeconds(consulConfig.getWaitTime()), currentIndex));
            Long newIndex = response.getConsulIndex();
            if (Objects.isNull(response.getValue()) || response.getValue().isEmpty()) {
                handleEmptyResponse(watchPathRoot, currentIndex, newIndex, deleteHandler);
                this.executor.schedule(() -> watchConfigKeyValues(watchPathRoot, updateHandler, deleteHandler),
                        consulConfig.getWatchDelay(), TimeUnit.MILLISECONDS);
                return;
            }
            if (Objects.isNull(newIndex)) {
                if (LOG.isTraceEnabled()) {
                    LOG.trace("Same index for watchPathRoot {}", watchPathRoot);
                }
                this.executor.schedule(() -> watchConfigKeyValues(watchPathRoot, updateHandler, deleteHandler),
                        consulConfig.getWatchDelay(), TimeUnit.MILLISECONDS);
                return;
            }
            if (Objects.equals(newIndex, currentIndex)) {
                this.executor.schedule(() -> watchConfigKeyValues(watchPathRoot, updateHandler, deleteHandler),
                        -1, TimeUnit.MILLISECONDS);
                return;
            }
            if (!currentIndex.equals(ConsulConstants.INIT_CONFIG_VERSION_INDEX)) {
                if (LOG.isTraceEnabled()) {
                    LOG.trace("watchPathRoot {} has new index {}", watchPathRoot, newIndex);
                }
                final Long lastIndex = currentIndex;
                final List<ConsulData> lastDatas = cacheConsulDataKeyMap.get(watchPathRoot);
                response.getValue().forEach(data -> {
                    if (data.getModifyIndex() == lastIndex) {
                        //data has not changed
                        return;
                    }
                    if (Objects.nonNull(lastDatas)) {
                        final ConsulData consulData = lastDatas.stream()
                                .filter(lastData -> normalizeEventPath(data.getKey()).equals(lastData.getConsulKey())).findFirst().orElse(null);
                        if (Objects.nonNull(consulData) && !StringUtils.isBlank(consulData.getConsulDataMd5())
                                && consulData.getConsulDataMd5().equals(DigestUtils.md5Hex(data.getValue()))) {
                            return;
                        }
                    }
                    updateHandler.accept(normalizeEventPath(data.getKey()), data.getDecodedValue());
                });
                final List<String> currentKeys = response.getValue().stream().map(data -> normalizeEventPath(data.getKey())).collect(Collectors.toList());
                if (!ObjectUtils.isEmpty(lastDatas)) {
                    // handler delete event
                    lastDatas.stream()
                            .map(ConsulData::getConsulKey)
                            .filter(lastKey -> !currentKeys.contains(lastKey))
                            .forEach(deleteHandler);
                }
            } else {
                response.getValue().forEach(data -> updateHandler.accept(normalizeEventPath(data.getKey()), data.getDecodedValue()));
            }
            // save last Keys
            cacheConsulDataKeyMap.put(watchPathRoot, response.getValue().stream().map(data -> {
                final ConsulData consulData = new ConsulData();
                consulData.setConsulKey(normalizeEventPath(data.getKey()));
                consulData.setConsulDataMd5(DigestUtils.md5Hex(data.getValue()));
                return consulData;
            }).collect(Collectors.toList()));
            this.consulIndexes.put(watchPathRoot, newIndex);
            this.executor.schedule(() -> watchConfigKeyValues(watchPathRoot, updateHandler, deleteHandler),
                    -1, TimeUnit.MILLISECONDS);
        } catch (Exception e) {
            LOG.warn("Error querying consul Key/Values for watchPathRoot '{}'. Message: ", watchPathRoot, e);
            this.executor.schedule(() -> watchConfigKeyValues(watchPathRoot, updateHandler, deleteHandler),
                    consulConfig.getWatchDelay(), TimeUnit.MILLISECONDS);
        }
    }

    private void handleEmptyResponse(final String watchPathRoot,
                                     final Long currentIndex,
                                     final Long newIndex,
                                     final Consumer<String> deleteHandler) {
        if (LOG.isTraceEnabled()) {
            LOG.trace("No value for watchPathRoot {}", watchPathRoot);
        }
        if (Objects.isNull(newIndex)) {
            dispatchCachedDeletes(watchPathRoot, currentIndex, deleteHandler);
            return;
        }
        if (Objects.equals(newIndex, currentIndex)) {
            return;
        }
        dispatchCachedDeletes(watchPathRoot, currentIndex, deleteHandler);
        this.consulIndexes.put(watchPathRoot, newIndex);
    }

    private void dispatchCachedDeletes(final String watchPathRoot,
                                       final Long currentIndex,
                                       final Consumer<String> deleteHandler) {
        if (!currentIndex.equals(ConsulConstants.INIT_CONFIG_VERSION_INDEX)) {
            final List<ConsulData> lastDatas = cacheConsulDataKeyMap.remove(watchPathRoot);
            if (!ObjectUtils.isEmpty(lastDatas)) {
                lastDatas.stream().map(ConsulData::getConsulKey).forEach(deleteHandler);
            }
        }
    }

    private static String normalizePath(final String path) {
        return path.startsWith(Constants.PATH_SEPARATOR) ? path.substring(Constants.PATH_SEPARATOR.length()) : path;
    }

    private static String normalizeEventPath(final String path) {
        return path.startsWith(Constants.PATH_SEPARATOR) ? path : Constants.PATH_SEPARATOR + path;
    }

    @Override
    public void close() {
        if (!ObjectUtils.isEmpty(executor)) {
            executor.shutdown();
        }
    }

    private static class ConsulData {

        private String consulKey;

        private String consulDataMd5;

        /**
         * consulKey.
         *
         * @return ConsulKey
         */
        public String getConsulKey() {
            return consulKey;
        }

        /**
         * set consulKey.
         *
         * @param consulKey consulKey
         */
        public void setConsulKey(final String consulKey) {
            this.consulKey = consulKey;
        }

        /**
         * consulDataMd5.
         *
         * @return ConsulDataMd5
         */
        public String getConsulDataMd5() {
            return consulDataMd5;
        }

        /**
         * set consulDataMd5.
         *
         * @param consulDataMd5 consulDataMd5
         */
        public void setConsulDataMd5(final String consulDataMd5) {
            this.consulDataMd5 = consulDataMd5;
        }
    }
}
