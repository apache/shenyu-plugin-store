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

package org.apache.shenyu.registry.eureka;

import org.apache.shenyu.registry.api.config.RegisterConfig;
import org.apache.shenyu.registry.api.entity.InstanceEntity;
import org.apache.shenyu.registry.api.event.ChangedEventListener;
import org.junit.jupiter.api.Test;

import java.time.Duration;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;

import static org.awaitility.Awaitility.await;
import static org.junit.jupiter.api.Assertions.assertNotNull;

/**
 * Opt-in real Eureka registration, refresh, deregistration and shutdown checks.
 */
class EurekaLiveIT {

    @Test
    void externalProviderRegistersDiscoversRefreshesAndDeregisters() {
        String url = System.getProperty("eureka.test.url");
        assertNotNull(url, "The eureka-live profile requires -Deureka.test.url=http://server:8761/eureka/");
        final String application = "SHENYU-STORE-" + UUID.randomUUID();
        final EurekaInstanceRegisterRepository first = repository(url);
        final EurekaInstanceRegisterRepository second = repository(url);
        final EurekaInstanceRegisterRepository discovery = repository(url);
        final ConcurrentLinkedQueue<String> removals = new ConcurrentLinkedQueue<>();
        try {
            first.persistInstance(new InstanceEntity(application, "127.0.0.1", 19195));
            await().atMost(Duration.ofSeconds(90)).until(() -> discovery.selectInstances(application).stream()
                    .anyMatch(instance -> instance.getPort() == 19195));
            discovery.watchInstances(application, (key, value, event) -> {
                if (event == ChangedEventListener.Event.DELETED) {
                    removals.add(value);
                }
            });
            second.persistInstance(new InstanceEntity(application, "127.0.0.1", 19196));
            await().atMost(Duration.ofSeconds(90)).until(() -> discovery.selectInstances(application).stream()
                    .anyMatch(instance -> instance.getPort() == 19196));
            second.close();
            await().atMost(Duration.ofSeconds(90)).until(() -> removals.stream().anyMatch(value -> value.contains("19196")));
            discovery.unWatchInstances(application);
        } finally {
            first.close();
            second.close();
            discovery.close();
        }
    }

    private EurekaInstanceRegisterRepository repository(final String url) {
        RegisterConfig config = new RegisterConfig();
        config.setServerLists(url);
        config.setRegisterType("eureka");
        EurekaInstanceRegisterRepository repository = new EurekaInstanceRegisterRepository();
        repository.init(config);
        return repository;
    }
}

