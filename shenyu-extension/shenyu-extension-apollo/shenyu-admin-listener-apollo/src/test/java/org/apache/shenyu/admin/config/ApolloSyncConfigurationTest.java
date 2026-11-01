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

package org.apache.shenyu.admin.config;

import org.apache.shenyu.admin.config.properties.ApolloProperties;
import org.apache.shenyu.admin.listener.DataChangedInit;
import org.apache.shenyu.admin.listener.DataChangedListener;
import org.apache.shenyu.admin.service.SyncDataService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

/**
 * Auto-configuration contracts of the external Apollo Admin listener.
 */
class ApolloSyncConfigurationTest {

    private final ApplicationContextRunner runner = new ApplicationContextRunner()
            .withConfiguration(AutoConfigurations.of(ApolloSyncConfiguration.class))
            .withBean(SyncDataService.class, () -> mock(SyncDataService.class));

    @Test
    void createsAdminBeansAndBindsExistingProperties() {
        runner.withPropertyValues("shenyu.sync.apollo.meta=http://127.0.0.1:8080",
                "shenyu.sync.apollo.portalUrl=http://127.0.0.1:8070", "shenyu.sync.apollo.appId=shenyu",
                "shenyu.sync.apollo.env=DEV", "shenyu.sync.apollo.clusterName=default",
                "shenyu.sync.apollo.namespace=application", "shenyu.sync.apollo.token=test-token")
                .run(context -> {
                    assertThat(context).hasNotFailed().hasSingleBean(DataChangedListener.class).hasSingleBean(DataChangedInit.class);
                    assertThat(context.getBean(ApolloProperties.class).getAppId()).isEqualTo("shenyu");
                    assertThat(context.getBean(ApolloProperties.class).getNamespace()).isEqualTo("application");
                });
    }

    @Test
    void backsOffWhenApolloMetaIsAbsent() {
        runner.run(context -> assertThat(context).hasNotFailed().doesNotHaveBean(DataChangedListener.class).doesNotHaveBean(DataChangedInit.class));
    }
}
