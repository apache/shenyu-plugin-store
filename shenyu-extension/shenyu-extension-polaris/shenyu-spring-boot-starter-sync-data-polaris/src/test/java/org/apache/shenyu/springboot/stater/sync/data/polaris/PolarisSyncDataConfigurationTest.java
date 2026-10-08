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

package org.apache.shenyu.springboot.stater.sync.data.polaris;

import com.tencent.polaris.configuration.api.core.ConfigFile;
import com.tencent.polaris.configuration.api.core.ConfigFileService;

import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.springboot.starter.sync.data.polaris.PolarisSyncDataConfiguration;
import org.apache.shenyu.sync.data.api.SyncDataService;
import org.apache.shenyu.sync.data.polaris.config.PolarisConfig;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Answers.CALLS_REAL_METHODS;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 * The test case for {@link PolarisSyncDataConfiguration}.
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(
        classes = {PolarisSyncDataConfiguration.class, PolarisSyncDataConfigurationTest.TestConfig.class},
        properties = {
            "shenyu.sync.polaris.url=" + PolarisSyncDataConfigurationTest.URL,
            "shenyu.sync.polaris.namespace=default",
            "shenyu.sync.polaris.fileGroup=fileGroup",
            "spring.main.allow-bean-definition-overriding=true"
        })
@EnableAutoConfiguration
@MockBean(name = "shenyuConfig", value = ShenyuConfig.class, answer = CALLS_REAL_METHODS)
public final class PolarisSyncDataConfigurationTest {

    public static final String URL = "127.0.0.1:8093";

    @Autowired
    private SyncDataService syncDataService;

    @Autowired
    private PolarisConfig polarisConfig;

    @Test
    public void polarisConfigServiceTest() {
        assertNotNull(syncDataService);
        assertNotNull(polarisConfig);
        assertInstanceOf(org.apache.shenyu.sync.data.polaris.PolarisSyncDataService.class, syncDataService);
        assertTrue(polarisConfig.getUrl().contains(PolarisSyncDataConfigurationTest.URL));
    }

    @TestConfiguration
    static class TestConfig {

        @Bean
        @Primary
        ConfigFileService polarisConfigServices() {
            final ConfigFile configFile = mock(ConfigFile.class);
            when(configFile.hasContent()).thenReturn(false);
            final ConfigFileService configFileService = mock(ConfigFileService.class);
            when(configFileService.getConfigFile(anyString(), anyString(), anyString())).thenReturn(configFile);
            return configFileService;
        }
    }
}
