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

import io.kubernetes.client.informer.cache.Lister;
import io.kubernetes.client.openapi.apis.CoreV1Api;
import io.kubernetes.client.openapi.models.V1EndpointAddress;
import io.kubernetes.client.openapi.models.V1EndpointSubset;
import io.kubernetes.client.openapi.models.V1Endpoints;
import io.kubernetes.client.openapi.models.V1HTTPIngressPath;
import io.kubernetes.client.openapi.models.V1Ingress;
import io.kubernetes.client.openapi.models.V1IngressBackend;
import io.kubernetes.client.openapi.models.V1IngressRule;
import io.kubernetes.client.openapi.models.V1IngressServiceBackend;
import io.kubernetes.client.openapi.models.V1Service;
import io.kubernetes.client.openapi.models.V1ServiceBackendPort;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.shenyu.common.dto.ConditionData;
import org.apache.shenyu.common.dto.MetaData;
import org.apache.shenyu.common.dto.RuleData;
import org.apache.shenyu.common.dto.SelectorData;
import org.apache.shenyu.common.enums.MatchModeEnum;
import org.apache.shenyu.common.enums.OperatorEnum;
import org.apache.shenyu.common.enums.ParamTypeEnum;
import org.apache.shenyu.common.enums.SelectorTypeEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.k8s.common.IngressConfiguration;
import org.apache.shenyu.k8s.common.ShenyuMemoryConfig;
import org.apache.shenyu.k8s.parser.K8sResourceParser;
import org.apache.shenyu.plugin.motan.constant.MotanPluginConstants;
import org.apache.shenyu.plugin.motan.dto.MotanUpstream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Parser for Motan ingress annotations.
 */
public class MotanIngressParser implements K8sResourceParser<V1Ingress> {

    private static final Logger LOG = LoggerFactory.getLogger(MotanIngressParser.class);

    private final Lister<V1Service> serviceLister;

    private final Lister<V1Endpoints> endpointsLister;

    public MotanIngressParser(final Lister<V1Service> serviceLister, final Lister<V1Endpoints> endpointsLister) {
        this.serviceLister = serviceLister;
        this.endpointsLister = endpointsLister;
    }

    @Override
    public ShenyuMemoryConfig parse(final V1Ingress ingress, final CoreV1Api coreV1Api) {
        ShenyuMemoryConfig config = new ShenyuMemoryConfig();
        if (Objects.isNull(ingress.getSpec())) {
            return config;
        }
        String namespace = Objects.requireNonNull(ingress.getMetadata()).getNamespace();
        Map<String, String> annotations = MapUtils.emptyIfNull(ingress.getMetadata().getAnnotations());
        V1IngressBackend defaultBackend = ingress.getSpec().getDefaultBackend();
        MotanUpstream defaultUpstream = parseUpstream(defaultBackend, namespace, annotations);
        List<V1IngressRule> rules = ingress.getSpec().getRules();
        if (CollectionUtils.isEmpty(rules)) {
            if (Objects.nonNull(defaultBackend) && Objects.nonNull(defaultBackend.getService())) {
                IngressConfiguration route = createRoute("/**", "ImplementationSpecific", null, defaultBackend, defaultUpstream, annotations,
                        ingress.getMetadata().getLabels(), namespace);
                config.setGlobalDefaultBackend(Pair.of(Pair.of(namespace + "/" + ingress.getMetadata().getName(),
                        defaultBackend.getService().getName()), route));
            }
            return config;
        }
        List<IngressConfiguration> routes = new ArrayList<>(rules.size());
        for (V1IngressRule rule : rules) {
            routes.addAll(parseRule(rule, namespace, annotations, ingress.getMetadata().getLabels(), defaultBackend, defaultUpstream));
        }
        config.setRouteConfigList(routes);
        return config;
    }

    List<String> metadataPaths(final V1Ingress ingress) {
        if (Objects.isNull(ingress) || Objects.isNull(ingress.getMetadata())) {
            return Collections.emptyList();
        }
        List<String> paths = new ArrayList<>();
        for (Map<String, String> annotations : metadataAnnotations(ingress.getMetadata().getLabels(), ingress.getMetadata().getNamespace())) {
            String path = annotations.get(MotanIngressConstants.PLUGIN_MOTAN_PATH);
            if (StringUtils.isNotBlank(path)) {
                paths.add(path);
            }
        }
        if (paths.isEmpty()) {
            String path = MapUtils.emptyIfNull(ingress.getMetadata().getAnnotations()).get(MotanIngressConstants.PLUGIN_MOTAN_PATH);
            if (StringUtils.isNotBlank(path)) {
                paths.add(path);
            }
        }
        return paths;
    }

    private List<IngressConfiguration> parseRule(final V1IngressRule rule, final String namespace, final Map<String, String> annotations,
                                                 final Map<String, String> labels, final V1IngressBackend defaultBackend,
                                                 final MotanUpstream defaultUpstream) {
        List<IngressConfiguration> routes = new ArrayList<>();
        ConditionData hostCondition = Objects.nonNull(rule.getHost()) ? createHostCondition(rule.getHost()) : null;
        if (Objects.isNull(rule.getHttp()) || Objects.isNull(rule.getHttp().getPaths())) {
            return routes;
        }
        for (V1HTTPIngressPath path : rule.getHttp().getPaths()) {
            if (Objects.isNull(path.getPath())) {
                continue;
            }
            V1IngressBackend backend = Objects.nonNull(path.getBackend()) ? path.getBackend() : defaultBackend;
            MotanUpstream upstream = Objects.nonNull(path.getBackend()) ? parseUpstream(path.getBackend(), namespace, annotations) : defaultUpstream;
            routes.add(createRoute(path.getPath(), path.getPathType(), hostCondition, backend, upstream, annotations, labels, namespace));
        }
        return routes;
    }

    private IngressConfiguration createRoute(final String path, final String pathType, final ConditionData hostCondition,
                                             final V1IngressBackend backend, final MotanUpstream upstream, final Map<String, String> annotations,
                                             final Map<String, String> labels, final String namespace) {
        List<ConditionData> selectorConditions = new ArrayList<>(2);
        if (Objects.nonNull(hostCondition)) {
            selectorConditions.add(hostCondition);
        }
        selectorConditions.add(createPathCondition(path, getOperator(pathType)));
        SelectorData selectorData = createSelectorData(path, selectorConditions, upstream);
        List<RuleData> ruleDataList = new ArrayList<>();
        List<MetaData> metaDataList = new ArrayList<>();
        for (Map<String, String> metadataAnnotations : metadataAnnotations(labels, namespace)) {
            ruleDataList.add(createRuleData(metadataAnnotations));
            metaDataList.add(createMetaData(metadataAnnotations));
        }
        if (ruleDataList.isEmpty() && metaDataList.isEmpty()) {
            String metadataPath = annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_PATH, path);
            ruleDataList.add(createRuleData(metadataPath));
            metaDataList.add(createMetaData(metadataPath, backend, annotations));
        }
        return new IngressConfiguration(selectorData, ruleDataList, metaDataList);
    }

    private List<Map<String, String>> metadataAnnotations(final Map<String, String> labels, final String namespace) {
        if (MapUtils.isEmpty(labels)) {
            return Collections.emptyList();
        }
        List<String> labelKeys = new ArrayList<>(labels.keySet());
        Collections.sort(labelKeys);
        List<Map<String, String>> annotations = new ArrayList<>();
        for (String labelKey : labelKeys) {
            if (!labelKey.startsWith(MotanIngressConstants.METADATA_LABEL_PREFIX)) {
                continue;
            }
            V1Service service = serviceLister.namespace(namespace).get(labels.get(labelKey));
            if (Objects.isNull(service) || Objects.isNull(service.getMetadata())) {
                continue;
            }
            Map<String, String> serviceAnnotations = service.getMetadata().getAnnotations();
            if (MapUtils.isNotEmpty(serviceAnnotations)) {
                annotations.add(serviceAnnotations);
            }
        }
        return annotations;
    }

    private SelectorData createSelectorData(final String path, final List<ConditionData> conditionList, final MotanUpstream upstream) {
        return SelectorData.builder()
                .pluginId(String.valueOf(MotanPluginConstants.MOTAN_PLUGIN_ORDER))
                .pluginName(MotanPluginConstants.MOTAN)
                .name(path)
                .matchMode(MatchModeEnum.AND.getCode())
                .type(SelectorTypeEnum.CUSTOM_FLOW.getCode())
                .enabled(true)
                .logged(false)
                .continued(true)
                .handle(GsonUtils.getInstance().toJson(upstream))
                .conditionList(conditionList)
                .build();
    }

    private RuleData createRuleData(final Map<String, String> metadataAnnotations) {
        String path = metadataAnnotations.get(MotanIngressConstants.PLUGIN_MOTAN_PATH);
        return createRuleData(path);
    }

    private RuleData createRuleData(final String path) {
        return RuleData.builder()
                .name(path)
                .pluginName(MotanPluginConstants.MOTAN)
                .matchMode(MatchModeEnum.AND.getCode())
                .conditionDataList(Collections.singletonList(createPathCondition(path, OperatorEnum.EQ)))
                .handle("{}")
                .loged(true)
                .enabled(true)
                .build();
    }

    private MotanUpstream parseUpstream(final V1IngressBackend backend, final String namespace, final Map<String, String> annotations) {
        MotanUpstream upstream = new MotanUpstream();
        upstream.setProtocol(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_PROTOCOL, "motan2"));
        upstream.setRegisterProtocol(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_REGISTER_PROTOCOL, "zookeeper"));
        upstream.setRegisterAddress(annotations.get(MotanIngressConstants.ZOOKEEPER_REGISTER_ADDRESS));
        upstream.setSerialization(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_SERIALIZATION));
        String directUrl = annotations.get(MotanIngressConstants.PLUGIN_MOTAN_DIRECT_URL);
        if (StringUtils.isBlank(directUrl)) {
            directUrl = directUrlFromBackend(backend, namespace);
        }
        upstream.setDirectUrl(directUrl);
        return upstream;
    }

    private String directUrlFromBackend(final V1IngressBackend backend, final String namespace) {
        if (Objects.isNull(backend) || Objects.isNull(backend.getService()) || Objects.isNull(backend.getService().getName())) {
            return null;
        }
        String port = parsePort(backend.getService());
        if (Objects.isNull(port)) {
            return null;
        }
        V1Endpoints endpoints = endpointsLister.namespace(namespace).get(backend.getService().getName());
        if (Objects.isNull(endpoints) || CollectionUtils.isEmpty(endpoints.getSubsets())) {
            LOG.info("Endpoints {} not found for motan upstream", backend.getService().getName());
            return null;
        }
        for (V1EndpointSubset subset : endpoints.getSubsets()) {
            if (CollectionUtils.isEmpty(subset.getAddresses())) {
                continue;
            }
            V1EndpointAddress address = subset.getAddresses().get(0);
            if (Objects.nonNull(address.getIp())) {
                return address.getIp() + ":" + port;
            }
        }
        return null;
    }

    private String parsePort(final V1IngressServiceBackend service) {
        V1ServiceBackendPort servicePort = service.getPort();
        if (Objects.isNull(servicePort)) {
            return null;
        }
        if (Objects.nonNull(servicePort.getNumber()) && servicePort.getNumber() > 0) {
            return String.valueOf(servicePort.getNumber());
        }
        return StringUtils.trimToNull(servicePort.getName());
    }

    private MetaData createMetaData(final Map<String, String> annotations) {
        String path = annotations.get(MotanIngressConstants.PLUGIN_MOTAN_PATH);
        return MetaData.builder()
                .appName(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_APP_NAME))
                .path(path)
                .contextPath(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_CONTEXT_PATH, contextPath(path)))
                .rpcType(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_RPC_TYPE, MotanPluginConstants.MOTAN))
                .rpcExt(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_RPC_EXPAND, MotanIngressConstants.DEFAULT_RPC_EXT))
                .serviceName(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_SERVICE_NAME))
                .methodName(annotations.get(MotanIngressConstants.PLUGIN_MOTAN_METHOD_NAME))
                .parameterTypes(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_PARAMS_TYPE, ""))
                .enabled(true)
                .build();
    }

    private MetaData createMetaData(final String metadataPath, final V1IngressBackend backend, final Map<String, String> annotations) {
        String serviceName = annotations.get(MotanIngressConstants.PLUGIN_MOTAN_SERVICE_NAME);
        if (StringUtils.isBlank(serviceName) && Objects.nonNull(backend) && Objects.nonNull(backend.getService())) {
            serviceName = backend.getService().getName();
        }
        return MetaData.builder()
                .appName(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_APP_NAME, "motan"))
                .path(metadataPath)
                .contextPath(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_CONTEXT_PATH, contextPath(metadataPath)))
                .rpcType(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_RPC_TYPE, MotanPluginConstants.MOTAN))
                .rpcExt(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_RPC_EXPAND, MotanIngressConstants.DEFAULT_RPC_EXT))
                .serviceName(serviceName)
                .methodName(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_METHOD_NAME, "methodName"))
                .parameterTypes(annotations.getOrDefault(MotanIngressConstants.PLUGIN_MOTAN_PARAMS_TYPE, ""))
                .enabled(true)
                .build();
    }

    private String contextPath(final String path) {
        if (StringUtils.isBlank(path) || !path.startsWith("/")) {
            return path;
        }
        int index = path.indexOf('/', 1);
        return index < 0 ? path : path.substring(0, index);
    }

    private ConditionData createHostCondition(final String host) {
        ConditionData hostCondition = new ConditionData();
        hostCondition.setParamType(ParamTypeEnum.DOMAIN.getName());
        hostCondition.setOperator(OperatorEnum.EQ.getAlias());
        hostCondition.setParamValue(host);
        return hostCondition;
    }

    private OperatorEnum getOperator(final String pathType) {
        if ("ImplementationSpecific".equals(pathType)) {
            return OperatorEnum.MATCH;
        } else if ("Prefix".equals(pathType)) {
            return OperatorEnum.STARTS_WITH;
        } else if ("Exact".equals(pathType)) {
            return OperatorEnum.EQ;
        } else {
            LOG.info("Invalid path type, set it with match operator");
            return OperatorEnum.MATCH;
        }
    }

    private ConditionData createPathCondition(final String path, final OperatorEnum operator) {
        ConditionData pathCondition = new ConditionData();
        pathCondition.setOperator(operator.getAlias());
        pathCondition.setParamType(ParamTypeEnum.URI.getName());
        pathCondition.setParamValue(path);
        return pathCondition;
    }
}
