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

package org.apache.shenyu.springboot.sync.data.apollo;

import com.ctrip.framework.apollo.Config;
import com.ctrip.framework.apollo.ConfigService;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.sync.data.api.PluginDataSubscriber;
import org.apache.shenyu.sync.data.api.SyncDataService;
import org.apache.shenyu.sync.data.apollo.ApolloDataService;
import org.apache.shenyu.sync.data.apollo.config.ApolloConfig;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.autoconfigure.context.ConfigurationPropertiesAutoConfiguration;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

/**
 * External gateway starter activation and binding without a remote Apollo server.
 */
class ApolloExternalStarterTest {

    private final ApplicationContextRunner runner = new ApplicationContextRunner()
            .withConfiguration(AutoConfigurations.of(ConfigurationPropertiesAutoConfiguration.class, ApolloSyncDataConfiguration.class))
            .withBean(ShenyuConfig.class)
            .withBean(PluginDataSubscriber.class, () -> mock(PluginDataSubscriber.class));

    @Test
    void createsGatewayServiceUsingThePublishedPropertyPrefix() {
        List<String> keys = List.of("app.id", "apollo.meta", "apollo.cluster", "apollo.bootstrap.namespace", "apollo.access-key");
        Map<String, String> previous = new HashMap<>();
        keys.forEach(key -> previous.put(key, System.getProperty(key)));
        Config config = mock(Config.class);
        when(config.getPropertyNames()).thenReturn(Collections.emptySet());
        try (MockedStatic<ConfigService> service = mockStatic(ConfigService.class)) {
            service.when(ConfigService::getAppConfig).thenReturn(config);
            runner.withPropertyValues("shenyu.sync.apollo.meta=http://127.0.0.1:8080",
                    "shenyu.sync.apollo.appId=shenyu", "shenyu.sync.apollo.env=DEV",
                    "shenyu.sync.apollo.clusterName=default", "shenyu.sync.apollo.namespace=application",
                    "shenyu.sync.apollo.accessKey=test-access-key")
                    .run(context -> {
                        assertThat(context).hasNotFailed().hasSingleBean(SyncDataService.class);
                        assertThat(context.getBean(SyncDataService.class)).isInstanceOf(ApolloDataService.class);
                        assertThat(context.getBean(ApolloConfig.class).getAccessKey()).isEqualTo("test-access-key");
                        assertThat(context.getBean(Config.class)).isSameAs(config);
                    });
        } finally {
            previous.forEach((key, value) -> {
                if (Objects.isNull(value)) {
                    System.clearProperty(key);
                } else {
                    System.setProperty(key, value);
                }
            });
        }
    }

    @Test
    void backsOffWhenApolloMetaIsAbsent() {
        runner.run(context -> assertThat(context).hasNotFailed().doesNotHaveBean(SyncDataService.class).doesNotHaveBean(ApolloConfig.class));
    }
}
