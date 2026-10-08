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

package org.apache.shenyu.plugin.store.test.support;

import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * Test-only auto-configuration for original E2E cache endpoints.
 */
@Configuration
@ConditionalOnProperty(prefix = "shenyu.store.e2e-cache", name = "enabled", havingValue = "true")
public class E2eCacheAutoConfiguration {

    /**
     * Creates the guarded E2E cache controller.
     *
     * @param plugins loaded gateway plugins
     * @return E2E cache controller
     */
    @Bean
    public E2eCacheController e2eCacheController(final List<ShenyuPlugin> plugins) {
        return new E2eCacheController(plugins);
    }
}
