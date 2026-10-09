<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

# RabbitMQ logging plugin migration and rollback

This plugin-store module carries the gateway-side implementation that was previously built from the Apache ShenYu main tree. Use this note when moving a deployment between the main-tree module and this store module during development or testing.

## Migrate to the store module

1. Build or install the plugin-store module and starter for the same ShenYu API baseline used by the gateway.
2. Add the starter artifact `shenyu-spring-boot-starter-plugin-logging-rabbitmq` to the gateway application that should emit access logs through this backend.
3. Keep the logging plugin name and existing admin metadata values unchanged during the move. Runtime compatibility depends on the stable plugin name exposed by ShenYu core.
4. Configure RabbitMQ settings such as `host`, `port`, `exchangeName`, `queueName`, `routingKey`, and `virtualHost` through the normal ShenYu plugin configuration path.
5. Run the module test suite, including `RabbitmqLoggingGatewayE2ETest`, against a real backend service before enabling the plugin in a shared environment.
6. Run the preserved original HTTP integration scenario from `shenyu-integrated-test/shenyu-integrated-test-http-logging-rabbitmq` and the original E2E scenario from `shenyu-e2e/shenyu-e2e-case/shenyu-e2e-case-logging-rabbitmq` when validating parity with the former main-tree suite.

## Roll back to the main-tree module

1. Disable the logging plugin for new traffic or restore the previous plugin configuration snapshot.
2. Remove the store starter artifact `shenyu-spring-boot-starter-plugin-logging-rabbitmq` from the gateway application.
3. Restore the prior main-tree starter or gateway image that contains the in-tree plugin module.
4. Re-apply the previous backend configuration and verify that access logs are delivered to the expected backend.

## Validation checklist

- The gateway starts with exactly one implementation of `shenyu-plugin-logging-rabbitmq` on the runtime classpath.
- The configured backend accepts a test access log from the real gateway request pipeline.
- Selector and rule refreshes still update logging behavior without restarting the gateway.
- The original `LoggingRabbitMqPluginTest`, `DividePluginCases`, and `DividePluginTest` scenarios compile under the `integration-tests` and `e2e` profiles with `shenyu-plugin-store-it-common` and `shenyu-plugin-store-e2e-common` available.
