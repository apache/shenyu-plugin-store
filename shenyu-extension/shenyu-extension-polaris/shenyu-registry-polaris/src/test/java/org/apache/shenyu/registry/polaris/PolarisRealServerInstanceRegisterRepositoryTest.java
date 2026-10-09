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

package org.apache.shenyu.registry.polaris;

import com.tencent.polaris.api.config.Configuration;
import com.tencent.polaris.api.core.ProviderAPI;
import com.tencent.polaris.api.rpc.InstanceDeregisterRequest;
import com.tencent.polaris.client.api.SDKContext;
import com.tencent.polaris.factory.ConfigAPIFactory;
import com.tencent.polaris.factory.api.DiscoveryAPIFactory;
import com.tencent.polaris.factory.config.ConfigurationImpl;
import org.apache.shenyu.common.constant.Constants;
import org.apache.shenyu.common.constant.PolarisPathConstants;
import org.apache.shenyu.registry.api.config.RegisterConfig;
import org.apache.shenyu.registry.api.entity.InstanceEntity;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;

import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.UUID;
import java.util.function.Supplier;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Real Polaris standalone integration coverage for instance registry operations.
 */
@Testcontainers
public final class PolarisRealServerInstanceRegisterRepositoryTest {

    private static final int POLARIS_HTTP_PORT = 8090;

    private static final int POLARIS_NAMING_GRPC_PORT = 8091;

    private static final DockerImageName POLARIS_IMAGE = DockerImageName
            .parse("polarismesh/polaris-standalone@sha256:22c75382080a260e5d9fc9839b6657ae73f3154e308b8da881e1fab58653911c");

    @Container
    private static final GenericContainer<?> POLARIS = new GenericContainer<>(POLARIS_IMAGE)
            .withExposedPorts(POLARIS_HTTP_PORT, POLARIS_NAMING_GRPC_PORT)
            .waitingFor(Wait.forHttp("/")
                    .forPort(POLARIS_HTTP_PORT)
                    .forResponsePredicate(body -> body.contains("Polaris Server")))
            .withStartupTimeout(Duration.ofMinutes(2));

    private PolarisInstanceRegisterRepository repository;

    @BeforeAll
    public static void verifyRealPolarisServer() {
        assertThat(POLARIS.isRunning()).isTrue();
    }

    @AfterEach
    public void cleanUp() {
        if (Objects.nonNull(repository)) {
            repository.close();
        }
    }

    @Test
    public void registerQueryDeregisterAndCloseAgainstRealPolarisServer() {
        String serviceName = "shenyu-polaris-registry-" + UUID.randomUUID();
        InstanceEntity instance = InstanceEntity.builder()
                .appName(serviceName)
                .host("127.0.0.1")
                .port(9195)
                .build();
        repository = new PolarisInstanceRegisterRepository();
        repository.init(registerConfig());

        repository.persistInstance(instance);

        eventually(() -> repository.selectInstances(serviceName), instances -> {
            assertThat(instances).hasSize(1);
            InstanceEntity actual = instances.get(0);
            assertThat(actual.getAppName()).isEqualTo(serviceName);
            assertThat(actual.getHost()).isEqualTo(instance.getHost());
            assertThat(actual.getPort()).isEqualTo(instance.getPort());
        });

        deregister(instance);
        repository.close();
        repository = new PolarisInstanceRegisterRepository();
        repository.init(registerConfig());
        eventually(() -> repository.selectInstances(serviceName), instances -> assertThat(instances).isEmpty());

        repository.close();
        repository = null;
    }

    private static RegisterConfig registerConfig() {
        Properties properties = new Properties();
        properties.setProperty(Constants.NAMESPACE, PolarisPathConstants.NAMESPACE);
        properties.setProperty("polaris.persist.dir", "target/polaris/backup/svc");
        return new RegisterConfig("polaris", polarisAddress(POLARIS_NAMING_GRPC_PORT), properties);
    }

    private static void deregister(final InstanceEntity instance) {
        Configuration configuration = polarisConfiguration();
        SDKContext sdkContext = SDKContext.initContextByConfig(configuration);
        try (ProviderAPI providerAPI = DiscoveryAPIFactory.createProviderAPIByContext(sdkContext)) {
            InstanceDeregisterRequest request = new InstanceDeregisterRequest();
            request.setNamespace(PolarisPathConstants.NAMESPACE);
            request.setService(instance.getAppName());
            request.setHost(instance.getHost());
            request.setPort(instance.getPort());
            request.setInstanceID(instance.getHost() + Constants.COLONS + instance.getPort());
            providerAPI.deRegister(request);
        }
    }

    private static Configuration polarisConfiguration() {
        ConfigurationImpl configuration = (ConfigurationImpl) ConfigAPIFactory.defaultConfig();
        configuration.getGlobal().getServerConnector().setAddresses(List.of(polarisAddress(POLARIS_NAMING_GRPC_PORT)));
        configuration.getGlobal().getSystem().getDiscoverCluster().setSameAsBuiltin(true);
        configuration.getGlobal().getSystem().getHealthCheckCluster().setSameAsBuiltin(true);
        return configuration;
    }

    private static String polarisAddress(final int exposedPort) {
        return POLARIS.getHost() + ':' + POLARIS.getMappedPort(exposedPort);
    }

    private static void eventually(final Supplier<List<InstanceEntity>> actual, final InstanceAssertion assertion) {
        AssertionError lastError = null;
        long deadline = System.nanoTime() + Duration.ofSeconds(60).toNanos();
        while (System.nanoTime() < deadline) {
            try {
                assertion.accept(actual.get());
                return;
            } catch (AssertionError | RuntimeException ex) {
                lastError = ex instanceof AssertionError ? (AssertionError) ex : new AssertionError(ex);
                sleep();
            }
        }
        throw Objects.isNull(lastError) ? new AssertionError("Condition was not satisfied") : lastError;
    }

    private static void sleep() {
        try {
            Thread.sleep(500L);
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new AssertionError(ex);
        }
    }

    @FunctionalInterface
    private interface InstanceAssertion {

        void accept(List<InstanceEntity> instances);
    }
}
