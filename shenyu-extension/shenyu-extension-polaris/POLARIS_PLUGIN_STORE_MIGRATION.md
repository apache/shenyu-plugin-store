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

# Polaris Plugin Store Migration and Rollback

This plugin-store extension owns the Polaris integration artifacts that can be published outside the ShenYu root reactor:

- `shenyu-admin-listener-polaris`
- `shenyu-sync-data-polaris`
- `shenyu-registry-polaris`
- `shenyu-spring-boot-starter-sync-data-polaris`

The current validation targets ShenYu API artifacts `2.7.2-SNAPSHOT` and Polaris SDK `1.13.0` from this store parent. Real-server tests use Docker API `1.44` (selected with `-Dapi.version=1.44`) and the pinned Polaris standalone image `polarismesh/polaris-standalone@sha256:22c75382080a260e5d9fc9839b6657ae73f3154e308b8da881e1fab58653911c`.

## Migration

1. Publish the store artifacts after the root CI and aggregator changes have been reviewed.
2. Add the Polaris starter to the gateway runtime that should consume Polaris sync data.
3. Configure the admin Polaris listener and gateway Polaris sync-data client with the same Polaris config namespace and file group.
4. Configure registry clients that need Polaris instance discovery to use the Polaris registry repository and the Polaris naming gRPC address.
5. Roll the admin listener first, then roll gateways so new gateway processes can subscribe to already-published Polaris config files.

## Rollback

1. Stop writes through the Polaris admin listener and switch admin sync configuration back to the previous channel.
2. Roll gateways back to the previous sync-data starter and configuration.
3. Roll registry clients back to the previous registry implementation.
4. Leave Polaris config files in place until all gateways and registry clients have stopped reading them; then remove the files as an operational cleanup.

## Tested boundary

The real config test covers the admin Polaris listener publishing plugin, selector, and rule config into a real Polaris server, the gateway-side Polaris sync service receiving those updates through the real SDK, and a real `ShenyuWebHandler` test server changing HTTP behavior. It also covers update, delete, recreate, close, and fresh-subscriber recovery.

The real registry test covers `PolarisInstanceRegisterRepository` registering an instance into a real Polaris naming server, querying it through the repository, deregistering the exact instance through the Polaris SDK boundary, observing removal through a fresh repository query, and closing repository clients.

These tests do not start the full `shenyu-admin` Spring Boot application, do not exercise dashboard or database persistence paths, and do not cover client annotation registration flows.
