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

package org.apache.shenyu.plugin.motan.k8s;

import io.kubernetes.client.extended.controller.reconciler.Request;
import io.kubernetes.client.informer.cache.Lister;
import io.kubernetes.client.openapi.apis.CoreV1Api;
import io.kubernetes.client.openapi.models.V1Endpoints;
import io.kubernetes.client.openapi.models.V1Ingress;
import io.kubernetes.client.openapi.models.V1Service;
import org.apache.commons.collections4.MapUtils;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.enums.PluginRoleEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.k8s.common.ShenyuMemoryConfig;
import org.apache.shenyu.k8s.parser.IngressPluginDefinition;
import org.apache.shenyu.plugin.motan.config.MotanRegisterConfig;
import org.apache.shenyu.plugin.motan.constant.MotanPluginConstants;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Motan ingress extension for the generic Kubernetes controller.
 */
public class MotanIngressPluginDefinition implements IngressPluginDefinition {

    @Override
    public boolean matchesIngress(final V1Ingress ingress) {
        if (Objects.isNull(ingress) || Objects.isNull(ingress.getMetadata())) {
            return false;
        }
        Map<String, String> annotations = MapUtils.emptyIfNull(ingress.getMetadata().getAnnotations());
        return Boolean.parseBoolean(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_ENABLED));
    }

    @Override
    public String pluginName() {
        return MotanPluginConstants.MOTAN;
    }

    @Override
    public String contextPath(final V1Ingress ingress) {
        if (Objects.isNull(ingress) || Objects.isNull(ingress.getMetadata())) {
            return "";
        }
        return MapUtils.emptyIfNull(ingress.getMetadata().getAnnotations()).getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_CONTEXT_PATH, "");
    }

    @Override
    public PluginData pluginData(final V1Ingress ingress, final Request request, final Lister<V1Endpoints> endpointsLister) {
        Map<String, String> annotations = MapUtils.emptyIfNull(ingress.getMetadata().getAnnotations());
        MotanRegisterConfig config = new MotanRegisterConfig();
        config.setRegisterProtocol(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_REGISTER_PROTOCOL, "zookeeper"));
        config.setRegisterAddress(annotations.get(MotanIngressConstants.ZOOKEEPER_REGISTER_ADDRESS));
        config.setThreadpool(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_THREADPOOL, "shared"));
        config.setCorethreads(parseInt(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_CORETHREADS), 0));
        config.setThreads(parseInt(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_THREADS), Integer.MAX_VALUE));
        config.setQueues(parseInt(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_QUEUES), 0));
        return PluginData.builder()
                .id(String.valueOf(MotanPluginConstants.MOTAN_PLUGIN_ORDER))
                .name(MotanPluginConstants.MOTAN)
                .config(GsonUtils.getInstance().toJson(config))
                .role(PluginRoleEnum.SYS.getName())
                .enabled(true)
                .sort(MotanPluginConstants.MOTAN_PLUGIN_ORDER)
                .build();
    }

    @Override
    public ShenyuMemoryConfig parse(final V1Ingress ingress, final CoreV1Api coreV1Api,
                                    final Lister<V1Service> serviceLister, final Lister<V1Endpoints> endpointsLister) {
        return new MotanIngressParser(serviceLister, endpointsLister).parse(ingress, coreV1Api);
    }

    @Override
    public List<String> metadataPaths(final V1Ingress ingress, final Lister<V1Service> serviceLister,
                                      final Lister<V1Endpoints> endpointsLister) {
        return new MotanIngressParser(serviceLister, endpointsLister).metadataPaths(ingress);
    }

    private int parseInt(final String value, final int defaultValue) {
        try {
            return Objects.isNull(value) ? defaultValue : Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }
}
