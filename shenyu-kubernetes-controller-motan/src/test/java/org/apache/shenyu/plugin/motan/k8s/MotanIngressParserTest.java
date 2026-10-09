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

import io.kubernetes.client.informer.cache.Indexer;
import io.kubernetes.client.informer.cache.Lister;
import io.kubernetes.client.openapi.models.V1EndpointAddress;
import io.kubernetes.client.openapi.models.V1EndpointSubsetBuilder;
import io.kubernetes.client.openapi.models.V1Endpoints;
import io.kubernetes.client.openapi.models.V1EndpointsBuilder;
import io.kubernetes.client.openapi.models.V1Ingress;
import io.kubernetes.client.openapi.models.V1Service;
import io.kubernetes.client.util.Yaml;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.k8s.common.IngressConfiguration;
import org.apache.shenyu.k8s.common.ShenyuMemoryConfig;
import org.apache.shenyu.plugin.motan.constant.MotanPluginConstants;
import org.apache.shenyu.plugin.motan.dto.MotanUpstream;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 * Test for {@link MotanIngressParser}.
 */
public final class MotanIngressParserTest {

    private static final String NAMESPACE = "shenyu-ingress";

    private static final String BACKEND_SERVICE_NAME = "shenyu-examples-motan-service";

    private static final String RPC_EXT = "{\"methodInfo\":[{\"methodName\":\"hello\",\"params\":[{\"left\":\"java.lang.String\","
            + "\"right\":\"name\"}]}],\"group\":\"motan-shenyu-rpc\",\"timeout\":2000,\"rpcProtocol\":\"motan2\"}";

    @Test
    @SuppressWarnings("unchecked")
    public void testParseRecoveredMotanIngressMetadataLabels() throws IOException {
        List<Object> resources = loadRecoveredIngressResources();
        List<V1Service> services = resources.stream().filter(V1Service.class::isInstance).map(V1Service.class::cast).collect(Collectors.toList());
        V1Ingress ingress = resources.stream().filter(V1Ingress.class::isInstance).map(V1Ingress.class::cast).findFirst().orElseThrow();
        Indexer<V1Service> serviceIndexer = mock(Indexer.class);
        for (V1Service service : services) {
            when(serviceIndexer.getByKey(NAMESPACE + "/" + service.getMetadata().getName())).thenReturn(service);
        }
        Indexer<V1Endpoints> endpointsIndexer = mock(Indexer.class);
        when(endpointsIndexer.getByKey(NAMESPACE + "/" + BACKEND_SERVICE_NAME)).thenReturn(createEndpoints());
        MotanIngressParser parser = new MotanIngressParser(new Lister<>(serviceIndexer), new Lister<>(endpointsIndexer));

        ShenyuMemoryConfig config = parser.parse(ingress, null);

        IngressConfiguration route = config.getRouteConfigList().get(0);
        SelectorData selectorData = route.getSelectorData();
        assertEquals(MotanPluginConstants.MOTAN, selectorData.getPluginName());
        assertEquals("/**", selectorData.getName());
        MotanUpstream upstream = GsonUtils.getInstance().fromJson(selectorData.getHandle(), MotanUpstream.class);
        assertEquals("10.0.0.8:8081", upstream.getDirectUrl());
        assertEquals("zookeeper", upstream.getRegisterProtocol());
        assertEquals("shenyu-zk:2181", upstream.getRegisterAddress());
        Map<String, MetaData> metaDataByPath = route.getMetaDataList().stream()
                .collect(Collectors.toMap(MetaData::getPath, Function.identity()));
        assertEquals(2, metaDataByPath.size());
        assertMotanMetaData(metaDataByPath.get("/demo/hello"));
        assertMotanMetaData(metaDataByPath.get("/demoTest/hello"));
        Map<String, RuleData> ruleDataByName = route.getRuleDataList().stream()
                .collect(Collectors.toMap(RuleData::getName, Function.identity()));
        assertEquals(2, ruleDataByName.size());
        assertTrue(ruleDataByName.get("/demo/hello").getConditionDataList().stream()
                .anyMatch(condition -> "/demo/hello".equals(condition.getParamValue())));
        assertTrue(ruleDataByName.get("/demoTest/hello").getConditionDataList().stream()
                .anyMatch(condition -> "/demoTest/hello".equals(condition.getParamValue())));
        assertEquals(List.of("/demo/hello", "/demoTest/hello"), parser.metadataPaths(ingress));
    }

    private void assertMotanMetaData(final MetaData metaData) {
        assertEquals(MotanPluginConstants.MOTAN, metaData.getRpcType());
        assertEquals("org.apache.shenyu.examples.motan.service.MotanDemoService", metaData.getServiceName());
        assertEquals("hello", metaData.getMethodName());
        assertEquals("java.lang.String", metaData.getParameterTypes());
        assertEquals(RPC_EXT, metaData.getRpcExt().trim());
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
