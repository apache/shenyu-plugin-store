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
import io.kubernetes.client.informer.SharedIndexInformer;
import io.kubernetes.client.informer.cache.Indexer;
import io.kubernetes.client.openapi.ApiClient;
import io.kubernetes.client.openapi.models.V1EndpointAddress;
import io.kubernetes.client.openapi.models.V1EndpointSubsetBuilder;
import io.kubernetes.client.openapi.models.V1Endpoints;
import io.kubernetes.client.openapi.models.V1EndpointsBuilder;
import io.kubernetes.client.openapi.models.V1Ingress;
import io.kubernetes.client.openapi.models.V1Secret;
import io.kubernetes.client.openapi.models.V1Service;
import io.kubernetes.client.util.Yaml;
import org.apache.shenyu.common.config.ssl.ShenyuSniAsyncMapping;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.k8s.cache.IngressCache;
import org.apache.shenyu.k8s.cache.IngressSelectorCache;
import org.apache.shenyu.k8s.parser.IngressParser;
import org.apache.shenyu.k8s.reconciler.IngressReconciler;
import org.apache.shenyu.k8s.repository.ShenyuCacheRepository;
import org.apache.shenyu.plugin.motan.constant.MotanPluginConstants;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Test for Motan ingress through {@link IngressReconciler}.
 */
public final class MotanReconcilerTest {

    private static final String NAMESPACE = "shenyu-ingress";

    private static final String INGRESS_NAME = "demo-ingress";

    private static final String BACKEND_SERVICE_NAME = "shenyu-examples-motan-service";

    private Indexer<V1Ingress> ingressIndexer;

    private ShenyuCacheRepository shenyuCacheRepository;

    private IngressReconciler reconciler;

    private Map<String, MetaData> metaDataByPath;

    @BeforeEach
    @SuppressWarnings("unchecked")
    public void setUp() throws IOException {
        List<Object> resources = loadRecoveredIngressResources();
        final List<V1Service> services = resources.stream().filter(V1Service.class::isInstance)
                .map(V1Service.class::cast).collect(Collectors.toList());
        SharedIndexInformer<V1Ingress> ingressInformer = mock(SharedIndexInformer.class);
        ingressIndexer = mock(Indexer.class);
        when(ingressInformer.getIndexer()).thenReturn(ingressIndexer);
        SharedIndexInformer<V1Service> serviceInformer = mock(SharedIndexInformer.class);
        Indexer<V1Service> serviceIndexer = mock(Indexer.class);
        when(serviceInformer.getIndexer()).thenReturn(serviceIndexer);
        for (V1Service service : services) {
            when(serviceIndexer.getByKey(NAMESPACE + "/" + service.getMetadata().getName())).thenReturn(service);
        }
        SharedIndexInformer<V1Endpoints> endpointsInformer = mock(SharedIndexInformer.class);
        Indexer<V1Endpoints> endpointsIndexer = mock(Indexer.class);
        when(endpointsInformer.getIndexer()).thenReturn(endpointsIndexer);
        when(endpointsIndexer.getByKey(NAMESPACE + "/" + BACKEND_SERVICE_NAME)).thenReturn(createEndpoints());
        SharedIndexInformer<V1Secret> secretInformer = mock(SharedIndexInformer.class);
        when(secretInformer.getIndexer()).thenReturn(mock(Indexer.class));
        shenyuCacheRepository = mock(ShenyuCacheRepository.class);
        metaDataByPath = new HashMap<>();
        Map<String, List<RuleData>> rulesBySelectorId = new HashMap<>();
        doAnswer(invocation -> invocation.getArgument(0)).when(shenyuCacheRepository).saveOrUpdateSelectorData(any());
        doAnswer(invocation -> {
            RuleData ruleData = invocation.getArgument(0);
            rulesBySelectorId.computeIfAbsent(ruleData.getSelectorId(), key -> new ArrayList<>()).add(ruleData);
            return null;
        }).when(shenyuCacheRepository).saveOrUpdateRuleData(any());
        doAnswer(invocation -> {
            MetaData metaData = invocation.getArgument(0);
            metaDataByPath.put(metaData.getPath(), metaData);
            return null;
        }).when(shenyuCacheRepository).saveOrUpdateMetaData(any());
        doAnswer(invocation -> rulesBySelectorId.getOrDefault(invocation.getArgument(0), Collections.emptyList()))
                .when(shenyuCacheRepository).findRuleDataList(anyString());
        doAnswer(invocation -> metaDataByPath.get(invocation.getArgument(0))).when(shenyuCacheRepository).findMetaData(anyString());
        doAnswer(invocation -> {
            MetaData metaData = invocation.getArgument(0);
            if (Objects.nonNull(metaData)) {
                metaDataByPath.remove(metaData.getPath());
            }
            return null;
        }).when(shenyuCacheRepository).deleteMetaData(any());
        IngressParser parser = new IngressParser(serviceInformer, endpointsInformer, Collections.singletonList(new MotanIngressPluginDefinition()));
        reconciler = new IngressReconciler(ingressInformer, secretInformer, shenyuCacheRepository,
                new ShenyuSniAsyncMapping(), parser, mock(ApiClient.class));
        IngressCache.getInstance().remove(NAMESPACE, INGRESS_NAME);
        IngressSelectorCache.getInstance().remove(NAMESPACE, INGRESS_NAME, MotanPluginConstants.MOTAN);
    }

    @Test
    public void testReconcileAndDeleteRecoveredMotanIngressMetadata() throws IOException {
        V1Ingress ingress = loadRecoveredIngressResources().stream()
                .filter(V1Ingress.class::isInstance)
                .map(V1Ingress.class::cast)
                .findFirst()
                .orElseThrow();
        when(ingressIndexer.getByKey(NAMESPACE + "/" + INGRESS_NAME)).thenReturn(ingress);

        reconciler.reconcile(new Request(NAMESPACE, INGRESS_NAME));

        ArgumentCaptor<PluginData> pluginCaptor = ArgumentCaptor.forClass(PluginData.class);
        verify(shenyuCacheRepository, atLeastOnce()).saveOrUpdatePluginData(pluginCaptor.capture());
        assertTrue(pluginCaptor.getAllValues().stream().anyMatch(pluginData -> MotanPluginConstants.MOTAN.equals(pluginData.getName())));
        assertNotNull(IngressSelectorCache.getInstance().get(NAMESPACE, INGRESS_NAME, MotanPluginConstants.MOTAN));
        assertTrue(metaDataByPath.containsKey("/demo/hello"));
        assertTrue(metaDataByPath.containsKey("/demoTest/hello"));

        when(ingressIndexer.getByKey(NAMESPACE + "/" + INGRESS_NAME)).thenReturn(null);
        reconciler.reconcile(new Request(NAMESPACE, INGRESS_NAME));

        verify(shenyuCacheRepository, atLeastOnce()).findMetaData(eq("/demo/hello"));
        verify(shenyuCacheRepository, atLeastOnce()).findMetaData(eq("/demoTest/hello"));
        verify(shenyuCacheRepository, atLeastOnce()).deleteSelectorData(eq(MotanPluginConstants.MOTAN), anyString());
        assertFalse(metaDataByPath.containsKey("/demo/hello"));
        assertFalse(metaDataByPath.containsKey("/demoTest/hello"));
        assertNull(IngressSelectorCache.getInstance().get(NAMESPACE, INGRESS_NAME, MotanPluginConstants.MOTAN));
    }

    private List<Object> loadRecoveredIngressResources() throws IOException {
        File file = new File("../shenyu-examples/shenyu-examples-motan/shenyu-examples-motan-service/k8s/ingress.yml");
        return Yaml.loadAll(file);
    }

    private V1Endpoints createEndpoints() {
        return new V1EndpointsBuilder()
                .withNewMetadata().withNamespace(NAMESPACE).withName(BACKEND_SERVICE_NAME).endMetadata()
                .withSubsets(new V1EndpointSubsetBuilder().withAddresses(new V1EndpointAddress().ip("10.0.0.8")).build())
                .build();
    }
}
