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

package org.apache.shenyu.springboot.sync.data.consul;

import com.ecwid.consul.v1.ConsulClient;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.sync.data.api.SyncDataService;
import org.apache.shenyu.sync.data.consul.ConsulSyncDataService;
import org.apache.shenyu.sync.data.consul.config.ConsulConfig;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.autoconfigure.context.ConfigurationPropertiesAutoConfiguration;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Test cases for {@link ConsulSyncDataConfiguration}.
 */
public final class ConsulSyncDataConfigurationTest {

    private final ApplicationContextRunner contextRunner = new ApplicationContextRunner()
            .withConfiguration(AutoConfigurations.of(ConfigurationPropertiesAutoConfiguration.class, ConsulSyncDataConfiguration.class))
            .withBean(ShenyuConfig.class);

    @Test
    void shouldCreateConsulSyncBeansWhenExternalStarterIsOnClasspath() {
        contextRunner.withPropertyValues("shenyu.sync.consul.url=http://127.0.0.1:8500",
                "shenyu.sync.consul.waitTime=1",
                "shenyu.sync.consul.watchDelay=1000")
                .run(context -> {
                    assertThat(context).hasSingleBean(ConsulConfig.class);
                    assertThat(context).hasSingleBean(ConsulClient.class);
                    assertThat(context).hasSingleBean(SyncDataService.class);
                    assertThat(context.getBean(SyncDataService.class)).isInstanceOf(ConsulSyncDataService.class);
                    assertThat(context.getBean(ConsulConfig.class).getUrl()).isEqualTo("http://127.0.0.1:8500");
                });
    }

    @Test
    void shouldBackOffWhenConsulUrlIsAbsent() {
        contextRunner.run(context -> {
            assertThat(context).doesNotHaveBean(ConsulConfig.class);
            assertThat(context).doesNotHaveBean(SyncDataService.class);
        });
    }
}
