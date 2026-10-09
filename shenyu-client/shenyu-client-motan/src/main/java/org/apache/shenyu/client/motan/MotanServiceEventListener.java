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

package org.apache.shenyu.client.motan;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Lists;
import com.weibo.api.motan.config.springsupport.BasicServiceConfigBean;
import com.weibo.api.motan.config.springsupport.annotation.MotanService;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.shenyu.client.apidocs.annotations.ApiDoc;
import org.apache.shenyu.client.apidocs.annotations.ApiModule;
import org.apache.shenyu.client.core.client.AbstractContextRefreshedEventListener;
import org.apache.shenyu.client.core.constant.ShenyuClientConstants;
import org.apache.shenyu.client.core.disruptor.ShenyuClientRegisterEventPublisher;
import org.apache.shenyu.client.core.exception.ShenyuClientIllegalArgumentException;
import org.apache.shenyu.client.core.utils.OpenApiUtils;
import org.apache.shenyu.client.motan.common.annotation.ShenyuMotanClient;
import org.apache.shenyu.client.motan.common.dto.MotanRpcExt;
import org.apache.shenyu.common.enums.ApiHttpMethodEnum;
import org.apache.shenyu.common.enums.ApiSourceEnum;
import org.apache.shenyu.common.enums.ApiStateEnum;
import org.apache.shenyu.common.enums.RpcTypeEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.register.client.api.ShenyuClientRegisterRepository;
import org.apache.shenyu.register.common.config.ShenyuClientConfig;
import org.apache.shenyu.register.common.dto.ApiDocRegisterDTO;
import org.apache.shenyu.register.common.dto.MetaDataRegisterDTO;
import org.apache.shenyu.register.common.dto.URIRegisterDTO;
import org.apache.shenyu.register.common.enums.EventType;
import org.javatuples.Sextet;
import org.springframework.aop.support.AopUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.StandardReflectionParameterNameDiscoverer;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.util.ReflectionUtils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Motan Service Event Listener.
 */
public class MotanServiceEventListener extends AbstractContextRefreshedEventListener<Object, ShenyuMotanClient> {

    protected static final String BASE_SERVICE_CONFIG = "baseServiceConfig";

    static final String MOTAN_RPC_TYPE = "motan";

    private static final String API_DOC_VERSION = "v0.01";

    private final StandardReflectionParameterNameDiscoverer localVariableTableParameterNameDiscoverer = new StandardReflectionParameterNameDiscoverer();

    private final ShenyuClientRegisterEventPublisher publisher = ShenyuClientRegisterEventPublisher.getInstance();

    private ApplicationContext applicationContext;

    private String group;

    public MotanServiceEventListener(final ShenyuClientConfig clientConfig,
                                     final ShenyuClientRegisterRepository shenyuClientRegisterRepository) {
        super(clientConfig, shenyuClientRegisterRepository);
    }

    @Override
    public void onApplicationEvent(@NonNull final ContextRefreshedEvent event) {
        applicationContext = event.getApplicationContext();
        Map<String, Object> beans = getBeans(applicationContext);
        if (MapUtils.isEmpty(beans)) {
            return;
        }
        if (!markRegistered()) {
            return;
        }
        String discoveryMode = applicationContext.getEnvironment()
                .getProperty("shenyu.discovery.type", ShenyuClientConstants.DISCOVERY_LOCAL_MODE);
        boolean isDiscoveryLocalMode = ShenyuClientConstants.DISCOVERY_LOCAL_MODE.equals(discoveryMode);
        if (isDiscoveryLocalMode) {
            List<String> namespaceIds = this.getNamespace();
            namespaceIds.forEach(namespaceId -> {
                URIRegisterDTO uriRegisterDTO = buildURIRegisterDTO(applicationContext, beans, namespaceId);
                if (Objects.nonNull(uriRegisterDTO)) {
                    publisher.publishEvent(uriRegisterDTO);
                }
            });
        }
        beans.forEach(this::handle);
        Map<String, Object> apiModules = applicationContext.getBeansWithAnnotation(ApiModule.class);
        apiModules.forEach((name, bean) -> handleApiDoc(bean));
    }

    @Override
    protected Sextet<String[], String, String, ApiHttpMethodEnum[], RpcTypeEnum, String> buildApiDocSextet(final Method method, final Annotation annotation, final Map<String, Object> beans) {
        return null;
    }


    private void handleApiDoc(final Object bean) {
        Class<?> apiModuleClass = AopUtils.isAopProxy(bean) ? AopUtils.getTargetClass(bean) : bean.getClass();
        ApiModule apiModule = apiModuleClass.getDeclaredAnnotation(ApiModule.class);
        if (Objects.nonNull(apiModule) && apiModule.generated()) {
            final Method[] methods = ReflectionUtils.getUniqueDeclaredMethods(apiModuleClass);
            for (Method method : methods) {
                if (method.isAnnotationPresent(ApiDoc.class)) {
                    List<ApiDocRegisterDTO> apis = buildApiDocDTO(bean, method);
                    apis.forEach(publisher::publishEvent);
                }
            }
        }
    }

    List<ApiDocRegisterDTO> buildApiDocDTO(final Object bean, final Method method) {
        AtomicBoolean generated = new AtomicBoolean(false);
        Pair<String, List<String>> pairs = Stream.of(method.getDeclaredAnnotations())
                .filter(ApiDoc.class::isInstance)
                .findAny()
                .map(item -> {
                    ApiDoc apiDoc = (ApiDoc) item;
                    generated.set(apiDoc.generated());
                    String[] tags = apiDoc.tags();
                    List<String> tagsList = new ArrayList<>();
                    if (tags.length > 0 && StringUtils.isNotBlank(tags[0])) {
                        tagsList = Arrays.asList(tags);
                    }
                    return Pair.of(apiDoc.desc(), tagsList);
                }).orElse(Pair.of("", new ArrayList<>()));
        if (!generated.get()) {
            return Collections.emptyList();
        }
        Class<?> clazz = AopUtils.isAopProxy(bean) ? AopUtils.getTargetClass(bean) : bean.getClass();
        ShenyuMotanClient beanShenyuClient = AnnotatedElementUtils.findMergedAnnotation(clazz, getAnnotationType());
        if (Objects.isNull(beanShenyuClient)) {
            return Collections.emptyList();
        }
        ShenyuMotanClient methodShenyuClient = AnnotatedElementUtils.findMergedAnnotation(method, getAnnotationType());
        List<ApiDocRegisterDTO> list = Lists.newArrayList();
        for (String superPath : buildApiSuperPaths(clazz, beanShenyuClient)) {
            if (Objects.isNull(methodShenyuClient) && !superPath.contains("*")) {
                continue;
            }
            String apiPath = buildApiPath(method, superPath, methodShenyuClient);
            String documentJson = buildDocumentJson(pairs.getRight(), apiPath, method);
            String extJson = buildExtJson(method);
            ApiDocRegisterDTO build = ApiDocRegisterDTO.builder()
                    .consume(ShenyuClientConstants.MEDIA_TYPE_ALL_VALUE)
                    .produce(ShenyuClientConstants.MEDIA_TYPE_ALL_VALUE)
                    .httpMethod(ApiHttpMethodEnum.NOT_HTTP.getValue())
                    .contextPath(getContextPath())
                    .ext(extJson)
                    .document(documentJson)
                    .rpcType(MOTAN_RPC_TYPE)
                    .version(API_DOC_VERSION)
                    .apiDesc(pairs.getLeft())
                    .tags(pairs.getRight())
                    .apiPath(apiPath)
                    .apiSource(ApiSourceEnum.ANNOTATION_GENERATION.getValue())
                    .state(ApiStateEnum.UNPUBLISHED.getState())
                    .apiOwner("admin")
                    .eventType(EventType.REGISTER)
                    .build();
            list.add(build);
        }
        return list;
    }

    private String buildDocumentJson(final List<String> tags, final String path, final Method method) {
        Map<String, Object> documentMap = ImmutableMap.<String, Object>builder()
                .put("tags", tags)
                .put("operationId", path)
                .put("requestParameters", OpenApiUtils.generateRpcRequestDocParameters(method))
                .put("responseParameters", Collections.singletonList(OpenApiUtils.parseReturnType(method)))
                .put("responses", OpenApiUtils.generateRpcDocumentResponse(path, method))
                .build();
        return GsonUtils.getInstance().toJson(documentMap);
    }

    private String buildExtJson(final Method method) {
        final MetaDataRegisterDTO metaData = getMetaDataMap().get(method);
        if (Objects.isNull(metaData)) {
            return "{}";
        }
        ApiDocRegisterDTO.ApiExt ext = new ApiDocRegisterDTO.ApiExt();
        ext.setHost(getHost());
        ext.setPort(Integer.valueOf(getPort()));
        ext.setServiceName(metaData.getServiceName());
        ext.setMethodName(metaData.getMethodName());
        ext.setParameterTypes(metaData.getParameterTypes());
        ext.setRpcExt(metaData.getRpcExt());
        return GsonUtils.getInstance().toJson(ext);
    }

    @Override
    protected Map<String, Object> getBeans(final ApplicationContext context) {
        applicationContext = context;
        group = ((BasicServiceConfigBean) applicationContext.getBean(BASE_SERVICE_CONFIG)).getGroup();
        return context.getBeansWithAnnotation(ShenyuMotanClient.class);
    }

    @Override
    protected URIRegisterDTO buildURIRegisterDTO(final ApplicationContext context,
                                                 final Map<String, Object> beans,
                                                 final String namespaceId) {
        return URIRegisterDTO.builder()
                .contextPath(this.getContextPath())
                .appName(this.getAppName())
                .rpcType(MOTAN_RPC_TYPE)
                .eventType(EventType.REGISTER)
                .host(this.getHost())
                .port(Integer.parseInt(this.getPort()))
                .namespaceId(namespaceId)
                .build();
    }

    @Override
    protected String getClientName() {
        return MOTAN_RPC_TYPE;
    }

    @Override
    protected String buildApiSuperPath(final Class<?> clazz, final ShenyuMotanClient shenyuMotanClient) {
        if (Objects.nonNull(shenyuMotanClient) && !StringUtils.isBlank(shenyuMotanClient.path())) {
            return shenyuMotanClient.path();
        }
        return "";
    }

    @Override
    protected Class<ShenyuMotanClient> getAnnotationType() {
        return ShenyuMotanClient.class;
    }

    @Override
    protected MetaDataRegisterDTO buildMetaDataDTO(final Object bean,
                                                   @NonNull final ShenyuMotanClient shenyuMotanClient,
                                                   final String path,
                                                   final Class<?> clazz,
                                                   final Method method,
                                                   final String namespaceId) {
        Integer timeout = Optional.ofNullable(((BasicServiceConfigBean) applicationContext.getBean(BASE_SERVICE_CONFIG)).getRequestTimeout()).orElse(1000);
        MotanService service = AnnotatedElementUtils.findMergedAnnotation(clazz, MotanService.class);
        String desc = shenyuMotanClient.desc();
        String configRuleName = shenyuMotanClient.ruleName();
        String ruleName = ("".equals(configRuleName)) ? path : configRuleName;
        String methodName = method.getName();
        Class<?>[] parameterTypesClazz = method.getParameterTypes();
        String parameterTypes = Arrays.stream(parameterTypesClazz).map(Class::getName)
                .collect(Collectors.joining(","));
        String serviceName = getServiceName(clazz, service);
        String protocol = StringUtils.isNotEmpty(service.protocol()) ? service.protocol() : (getProtocolFromExport());
        return MetaDataRegisterDTO.builder()
                .appName(this.getAppName())
                .serviceName(serviceName)
                .methodName(methodName)
                .contextPath(this.getContextPath())
                .path(path)
                .port(Integer.parseInt(super.getPort()))
                .host(super.getHost())
                .ruleName(ruleName)
                .pathDesc(desc)
                .parameterTypes(parameterTypes)
                .rpcType(MOTAN_RPC_TYPE)
                .rpcExt(buildRpcExt(method, timeout, protocol))
                .enabled(shenyuMotanClient.enabled())
                .namespaceId(namespaceId)
                .build();
    }

    @Override
    protected String buildApiPath(final Method method,
                                  final String superPath,
                                  @Nullable final ShenyuMotanClient methodShenyuClient) {
        return superPath.contains("*")
                ? pathJoin(this.getContextPath(), superPath.replace("*", ""), method.getName())
                : pathJoin(this.getContextPath(), superPath, Objects.requireNonNull(methodShenyuClient).path());
    }

    @Override
    protected void handleClass(final Class<?> clazz, final Object bean, final ShenyuMotanClient beanShenyuClient, final String superPath) {
        Method[] methods = ReflectionUtils.getDeclaredMethods(clazz);
        List<String> namespaceIds = super.getNamespace();
        for (String namespaceId : namespaceIds) {
            for (Method method : methods) {
                final MetaDataRegisterDTO metaData = buildMetaDataDTO(bean, beanShenyuClient,
                        buildApiPath(method, superPath, null), clazz, method, namespaceId);
                publisher.publishEvent(metaData);
                getMetaDataMap().put(method, metaData);
            }
        }
    }

    private MotanRpcExt.RpcExt buildRpcExt(final Method method) {
        String[] paramNames = localVariableTableParameterNameDiscoverer.getParameterNames(method);
        List<Pair<String, String>> params = new ArrayList<>();
        if (Objects.nonNull(paramNames) && paramNames.length > 0) {
            Class<?>[] paramTypes = method.getParameterTypes();
            for (int i = 0; i < paramNames.length; i++) {
                params.add(Pair.of(paramTypes[i].getName(), paramNames[i]));
            }
        }
        return new MotanRpcExt.RpcExt(method.getName(), params);
    }

    private String buildRpcExt(final Method method, final Integer timeout, final String rpcProtocol) {
        List<MotanRpcExt.RpcExt> list = new ArrayList<>();
        list.add(buildRpcExt(method));
        MotanRpcExt buildList = new MotanRpcExt(list, group, timeout, rpcProtocol);
        return GsonUtils.getInstance().toJson(buildList);
    }

    /**
     * Get the protocol from BasicServiceConfigBean export.
     * @return rpc protocol
     */
    private String getProtocolFromExport() {
        String export = Optional.ofNullable(((BasicServiceConfigBean) applicationContext.getBean(BASE_SERVICE_CONFIG)).getExport()).orElse("");
        if (StringUtils.isNotEmpty(export) && export.contains(":")) {
            return export.split(":")[0];
        }
        return "motan2";
    }

    private String getServiceName(final Class<?> clazz, @Nullable final MotanService service) {
        String serviceName;
        if (void.class.equals(service.interfaceClass())) {
            if (clazz.getInterfaces().length > 0) {
                serviceName = clazz.getInterfaces()[0].getName();
            } else {
                throw new ShenyuClientIllegalArgumentException("Failed to export remote service class " + clazz.getName()
                        + ", cause: The @Service undefined interfaceClass or interfaceName, and the service class unimplemented any interfaces.");
            }
        } else {
            serviceName = service.interfaceClass().getName();
        }
        return serviceName;
    }
}
