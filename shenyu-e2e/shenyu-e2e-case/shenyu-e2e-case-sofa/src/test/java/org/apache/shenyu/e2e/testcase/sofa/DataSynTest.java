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

package org.apache.shenyu.e2e.testcase.sofa;

import org.apache.shenyu.e2e.client.WaitDataSync;
import org.apache.shenyu.e2e.client.admin.AdminClient;
import org.apache.shenyu.e2e.client.gateway.GatewayClient;
import org.apache.shenyu.e2e.engine.annotation.ShenYuTest;
import org.apache.shenyu.e2e.enums.ServiceTypeEnum;
import org.apache.shenyu.e2e.model.response.MetaDataDTO;
import org.awaitility.Awaitility;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;

import java.time.Duration;
import java.util.List;
import java.util.Objects;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Testing the correctness of Http data synchronization method.
 */
@ShenYuTest(environments = {
        @ShenYuTest.Environment(
                serviceName = "shenyu-e2e-admin",
                service = @ShenYuTest.ServiceConfigure(moduleName = "shenyu-e2e",
                        baseUrl = "http://localhost:31095",
                        type = ServiceTypeEnum.SHENYU_ADMIN,
                        parameters = {
                                @ShenYuTest.Parameter(key = "username", value = "admin"),
                                @ShenYuTest.Parameter(key = "password", value = "123456")
                        }
                )
        ),
        @ShenYuTest.Environment(
                serviceName = "shenyu-e2e-gateway",
                service = @ShenYuTest.ServiceConfigure(moduleName = "shenyu-e2e",
                        baseUrl = "http://localhost:31195",
                        type = ServiceTypeEnum.SHENYU_GATEWAY
                )
        )
})
public class DataSynTest {

    @Test
    void testDataSyn(final AdminClient adminClient, final GatewayClient gatewayClient) throws Exception {
        adminClient.login();
        WaitDataSync.waitAdmin2GatewayDataSyncEquals(adminClient::listAllSelectors, gatewayClient::getSelectorCache, adminClient);
        WaitDataSync.waitAdmin2GatewayDataSyncEquals(adminClient::listAllMetaData, gatewayClient::getMetaDataCache, adminClient);
        WaitDataSync.waitAdmin2GatewayDataSyncEquals(adminClient::listAllRules, gatewayClient::getRuleCache, adminClient);

        List<MetaDataDTO> metaDataList = adminClient.listAllMetaData();
        assertTrue(metaDataList.stream().anyMatch(metaData -> "/sofa/findById".equals(metaData.getPath())
                && "sofa".equals(metaData.getRpcType())
                && "findById".equals(metaData.getMethodName())), "SOFA client metadata should be registered with the gateway API contract");
    }

    @Test
    void testMetaDataRefresh(final AdminClient adminClient, final GatewayClient gatewayClient) throws Exception {
        adminClient.login();
        MetaDataDTO metaData = adminClient.listAllMetaData().stream()
                .filter(item -> "/sofa/findById".equals(item.getPath()))
                .findFirst()
                .orElseThrow(() -> new AssertionError("SOFA findById metadata is not registered"));
        String originalRpcExt = metaData.getRpcExt();
        String updatedRpcExt = "{\"loadbalance\":\"random\",\"retries\":1,\"timeout\":3000}";
        try {
            metaData.setRpcExt(updatedRpcExt);
            adminClient.createOrUpdateMetaData(metaData);
            Awaitility.await().atMost(Duration.ofSeconds(30)).pollInterval(Duration.ofMillis(250))
                    .until(() -> gatewayClient.getMetaDataCache().stream()
                            .anyMatch(cached -> "/sofa/findById".equals(cached.getPath()) && updatedRpcExt.equals(cached.getRpcExt())));
            gatewayClient.getHttpRequesterSupplier().get().get("/sofa/findById?id=7297")
                    .then().statusCode(HttpStatus.OK.value()).body("data.id", equalTo("7297"));
        } finally {
            metaData.setRpcExt(originalRpcExt);
            adminClient.createOrUpdateMetaData(metaData);
            awaitMetadataRpcExt(gatewayClient, originalRpcExt);
        }
    }

    private void awaitMetadataRpcExt(final GatewayClient gatewayClient, final String rpcExt) {
        Awaitility.await().atMost(Duration.ofSeconds(30)).pollInterval(Duration.ofMillis(250))
                .until(() -> gatewayClient.getMetaDataCache().stream()
                        .anyMatch(cached -> "/sofa/findById".equals(cached.getPath()) && Objects.equals(rpcExt, cached.getRpcExt())));
    }
}
