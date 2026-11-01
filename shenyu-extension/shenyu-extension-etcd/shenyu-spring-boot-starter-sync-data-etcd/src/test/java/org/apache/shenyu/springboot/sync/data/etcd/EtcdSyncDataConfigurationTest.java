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

package org.apache.shenyu.springboot.sync.data.etcd;

import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.infra.etcd.autoconfig.EtcdProperties;
import org.apache.shenyu.infra.etcd.client.EtcdClient;
import org.apache.shenyu.sync.data.api.PluginDataSubscriber;
import org.apache.shenyu.sync.data.api.SyncDataService;
import org.apache.shenyu.sync.data.etcd.EtcdSyncDataService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

/**
 * External etcd starter auto-configuration contracts.
 */
class EtcdSyncDataConfigurationTest {

    private final ApplicationContextRunner runner = new ApplicationContextRunner()
            .withConfiguration(AutoConfigurations.of(EtcdSyncDataConfiguration.class))
            .withBean(ShenyuConfig.class)
            .withBean(PluginDataSubscriber.class, () -> mock(PluginDataSubscriber.class));

    @Test
    void createsSyncServiceAndBindsMultipleEndpoints() {
        EtcdClient client = mock(EtcdClient.class);
        runner.withBean(EtcdClient.class, () -> client)
                .withPropertyValues("shenyu.sync.etcd.url=http://127.0.0.1:2379,http://127.0.0.1:2381")
                .run(context -> {
                    assertThat(context).hasNotFailed().hasSingleBean(SyncDataService.class).hasSingleBean(EtcdClient.class);
                    assertThat(context.getBean(SyncDataService.class)).isInstanceOf(EtcdSyncDataService.class);
                    assertThat(context.getBean(EtcdProperties.class).getEtcd().getUrl()).contains("2379", "2381");
                });
        verify(client).close();
    }

    @Test
    void backsOffWithoutEtcdUrl() {
        runner.run(context -> assertThat(context).hasNotFailed().doesNotHaveBean(SyncDataService.class).doesNotHaveBean(EtcdClient.class));
    }

    @Test
    void preservesUserProvidedSyncService() {
        SyncDataService service = mock(SyncDataService.class);
        runner.withBean(EtcdClient.class, () -> mock(EtcdClient.class))
                .withBean(SyncDataService.class, () -> service)
                .withPropertyValues("shenyu.sync.etcd.url=http://127.0.0.1:2379")
                .run(context -> assertThat(context.getBean(SyncDataService.class)).isSameAs(service));
    }
}
