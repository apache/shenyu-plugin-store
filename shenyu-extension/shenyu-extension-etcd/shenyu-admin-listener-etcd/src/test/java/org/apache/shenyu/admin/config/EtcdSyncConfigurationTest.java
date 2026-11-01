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

import org.apache.shenyu.admin.listener.DataChangedInit;
import org.apache.shenyu.admin.listener.DataChangedListener;
import org.apache.shenyu.admin.service.SyncDataService;
import org.apache.shenyu.infra.etcd.client.EtcdClient;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;

public class EtcdSyncConfigurationTest {

    @Test
    public void testEtcdDataChangedListener() {
        EtcdSyncConfiguration etcdListener = new EtcdSyncConfiguration();
        EtcdClient client = mock(EtcdClient.class);
        assertNotNull(etcdListener.etcdDataChangedListener(client));
    }

    @Test
    public void testEtcdDataInit() {
        EtcdSyncConfiguration etcdListener = new EtcdSyncConfiguration();
        EtcdClient client = mock(EtcdClient.class);
        assertNotNull(etcdListener.etcdDataChangedInit(client));
    }

    @Test
    public void createsAdminBeansWithExternalEtcdConfiguration() {
        new ApplicationContextRunner().withConfiguration(AutoConfigurations.of(EtcdSyncConfiguration.class))
                .withBean(EtcdClient.class, () -> mock(EtcdClient.class))
                .withBean(SyncDataService.class, () -> mock(SyncDataService.class))
                .withPropertyValues("shenyu.sync.etcd.url=http://127.0.0.1:2379")
                .run(context -> assertThat(context).hasNotFailed().hasSingleBean(DataChangedListener.class).hasSingleBean(DataChangedInit.class));
    }

    @Test
    public void backsOffWithoutEtcdConfiguration() {
        new ApplicationContextRunner().withConfiguration(AutoConfigurations.of(EtcdSyncConfiguration.class))
                .run(context -> assertThat(context).hasNotFailed().doesNotHaveBean(DataChangedListener.class).doesNotHaveBean(DataChangedInit.class));
    }
}
