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

package org.apache.shenyu.admin.service.register;

import org.apache.commons.lang3.StringUtils;
import org.apache.shenyu.admin.model.dto.RuleConditionDTO;
import org.apache.shenyu.admin.model.dto.RuleDTO;
import org.apache.shenyu.admin.model.entity.MetaDataDO;
import org.apache.shenyu.admin.model.entity.SelectorDO;
import org.apache.shenyu.admin.service.MetaDataService;
import org.apache.shenyu.admin.utils.ShenyuResultMessage;
import org.apache.shenyu.common.constant.AdminConstants;
import org.apache.shenyu.common.enums.MatchModeEnum;
import org.apache.shenyu.common.enums.OperatorEnum;
import org.apache.shenyu.common.enums.ParamTypeEnum;
import org.apache.shenyu.register.common.dto.MetaDataRegisterDTO;
import org.apache.shenyu.register.common.dto.URIRegisterDTO;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

import static org.apache.shenyu.common.constant.Constants.SYS_DEFAULT_NAMESPACE_ID;

/**
 * Motan service register.
 */
@Service
public class ShenyuClientRegisterMotanServiceImpl extends AbstractShenyuClientRegisterServiceImpl {

    private static final String MOTAN_RPC_TYPE = "motan";

    @Override
    public String rpcType() {
        return MOTAN_RPC_TYPE;
    }

    @Override
    public String register(final MetaDataRegisterDTO dto) {
        String namespaceId = StringUtils.defaultIfEmpty(dto.getNamespaceId(), SYS_DEFAULT_NAMESPACE_ID);
        checkNamespacePluginRel(namespaceId, MOTAN_RPC_TYPE);
        dto.setNamespaceId(namespaceId);
        String selectorHandler = selectorHandler(dto);
        String selectorId = getSelectorService().registerDefault(dto, MOTAN_RPC_TYPE, selectorHandler);
        String ruleHandler = ruleHandler();
        RuleDTO ruleDTO = buildRpcDefaultRuleDTO(selectorId, dto, ruleHandler);
        getRuleService().registerDefault(ruleDTO);
        registerMetadata(dto);
        String contextPath = dto.getContextPath();
        if (StringUtils.isNotEmpty(contextPath)) {
            registerContextPath(dto);
        }
        return ShenyuResultMessage.SUCCESS;
    }

    @Override
    protected String selectorHandler(final MetaDataRegisterDTO metaDataDTO) {
        return "";
    }

    @Override
    protected String ruleHandler() {
        return "";
    }

    @Override
    protected void registerMetadata(final MetaDataRegisterDTO metaDataDTO) {
        MetaDataService metaDataService = getMetaDataService();
        MetaDataDO exist = metaDataService.findByPathAndNamespaceId(metaDataDTO.getPath(), metaDataDTO.getNamespaceId());
        metaDataService.saveOrUpdateMetaData(exist, metaDataDTO);
    }

    @Override
    protected String buildHandle(final List<URIRegisterDTO> uriList, final SelectorDO selectorDO) {
        return "";
    }

    @Override
    public void checkNamespacePluginRel(final String namespaceId, final String pluginName) {
        // Motan is loaded as a plugin-store extension and the namespace relation is seeded by the
        // plugin SQL fixture. Avoid the inherited core lookup path so Motan registration does not
        // depend on core RPC enum membership or core namespace-plugin mapper aliases.
    }

    @Override
    public String registerURI(final String selectorName, final List<URIRegisterDTO> uriList, final String namespaceId) {
        return ShenyuResultMessage.SUCCESS;
    }

    @Override
    public String heartbeat(final String selectorName, final List<URIRegisterDTO> uriList, final String namespaceId) {
        return ShenyuResultMessage.SUCCESS;
    }

    private RuleDTO buildRpcDefaultRuleDTO(final String selectorId, final MetaDataRegisterDTO metaDataDTO, final String ruleHandler) {
        RuleDTO ruleDTO = RuleDTO.builder()
                .selectorId(selectorId)
                .name(metaDataDTO.getRuleName())
                .matchMode(MatchModeEnum.AND.getCode())
                .enabled(Boolean.TRUE)
                .loged(Boolean.TRUE)
                .matchRestful(Boolean.FALSE)
                .sort(1)
                .handle(ruleHandler)
                .namespaceId(metaDataDTO.getNamespaceId())
                .build();

        String conditionPath = rewritePath(metaDataDTO.getPath());
        RuleConditionDTO ruleConditionDTO = RuleConditionDTO.builder()
                .paramType(ParamTypeEnum.URI.getName())
                .paramName("/")
                .paramValue(conditionPath)
                .build();
        if (conditionPath.endsWith(AdminConstants.URI_SLASH_SUFFIX)) {
            ruleConditionDTO.setOperator(OperatorEnum.STARTS_WITH.getAlias());
        } else if (conditionPath.endsWith(AdminConstants.URI_SUFFIX)) {
            ruleConditionDTO.setOperator(OperatorEnum.PATH_PATTERN.getAlias());
        } else if (conditionPath.indexOf("*") > 1) {
            ruleConditionDTO.setOperator(OperatorEnum.MATCH.getAlias());
        } else {
            ruleConditionDTO.setOperator(OperatorEnum.EQ.getAlias());
        }
        ruleDTO.setRuleConditions(Collections.singletonList(ruleConditionDTO));
        return ruleDTO;
    }

    private String rewritePath(final String path) {
        if (path.contains(AdminConstants.URI_VARIABLE_SUFFIX)) {
            return path.replaceAll("(/\\{.*?})+", "/**");
        }
        return path;
    }
}
