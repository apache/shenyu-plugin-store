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

import org.apache.shenyu.springboot.starter.registry.ShenyuRegistryConfiguration;
import org.apache.shenyu.registry.api.ShenyuInstanceRegisterRepository;
import org.apache.shenyu.registry.api.config.RegisterConfig;
import org.apache.shenyu.registry.core.ShenyuInstanceRegisterRepositoryFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;

/**
 * Enable the retained registry lifecycle with the external Eureka SPI provider.
 */
@AutoConfiguration
@Import(ShenyuRegistryConfiguration.class)
public class EurekaRegistryAutoConfiguration {

    /**
     * Close the registration provider when its application context stops.
     *
     * @param config bound registry configuration
     * @return owned provider cleanup
     */
    @Bean
    @ConditionalOnProperty(name = "shenyu.register.enabled", havingValue = "true")
    public DisposableBean eurekaRegistryLifecycle(final RegisterConfig config) {
        if (!"eureka".equals(config.getRegisterType())) {
            return () -> { };
        }
        ShenyuInstanceRegisterRepository repository = ShenyuInstanceRegisterRepositoryFactory.newAndInitInstance(config);
        return repository::close;
    }
}

