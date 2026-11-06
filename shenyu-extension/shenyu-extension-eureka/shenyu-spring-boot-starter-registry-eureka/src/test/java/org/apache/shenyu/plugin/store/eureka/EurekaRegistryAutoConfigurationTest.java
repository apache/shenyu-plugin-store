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

package org.apache.shenyu.plugin.store.eureka;

import org.apache.shenyu.registry.api.config.RegisterConfig;
import org.apache.shenyu.registry.api.entity.InstanceEntity;
import org.apache.shenyu.registry.eureka.EurekaInstanceRegisterRepository;
import org.apache.shenyu.springboot.starter.registry.RegistryListener;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedConstruction;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.autoconfigure.context.ConfigurationPropertiesAutoConfiguration;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.boot.web.context.WebServerInitializedEvent;
import org.springframework.boot.web.server.WebServer;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockConstruction;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * The external starter resolves the provider and preserves registration lifecycle.
 */
class EurekaRegistryAutoConfigurationTest {

    private final ApplicationContextRunner runner = new ApplicationContextRunner()
            .withConfiguration(AutoConfigurations.of(ConfigurationPropertiesAutoConfiguration.class, EurekaRegistryAutoConfiguration.class));

    @Test
    void disabledByDefault() {
        runner.run(context -> {
            org.assertj.core.api.Assertions.assertThat(context).doesNotHaveBean(RegisterConfig.class);
            org.assertj.core.api.Assertions.assertThat(context).doesNotHaveBean(RegistryListener.class);
        });
    }

    @Test
    void externalProviderRegistersTheBoundPortOnce() {
        try (MockedConstruction<EurekaInstanceRegisterRepository> construction = mockConstruction(EurekaInstanceRegisterRepository.class)) {
            runner.withPropertyValues("shenyu.register.enabled=true", "shenyu.register.registerType=eureka",
                    "shenyu.register.serverLists=http://eureka:8761/eureka/", "shenyu.register.props.host=127.0.0.1")
                    .run(context -> {
                        org.assertj.core.api.Assertions.assertThat(context).hasSingleBean(RegisterConfig.class).hasSingleBean(RegistryListener.class);
                        assertEquals(1, construction.constructed().size());
                        EurekaInstanceRegisterRepository provider = construction.constructed().get(0);
                        RegisterConfig config = context.getBean(RegisterConfig.class);
                        assertEquals("eureka", config.getRegisterType());
                        verify(provider).init(config);
                        RegistryListener listener = context.getBean(RegistryListener.class);
                        WebServerInitializedEvent event = mock(WebServerInitializedEvent.class);
                        WebServer server = mock(WebServer.class);
                        when(event.getWebServer()).thenReturn(server);
                        when(server.getPort()).thenReturn(9197);
                        listener.onApplicationEvent(event);
                        listener.onApplicationEvent(event);
                        ArgumentCaptor<InstanceEntity> instance = ArgumentCaptor.forClass(InstanceEntity.class);
                        verify(provider).persistInstance(instance.capture());
                        assertEquals(9197, instance.getValue().getPort());
                    });
            verify(construction.constructed().get(0)).close();
        }
    }
}

