<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements. See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
# ShenYu Apollo extension

This reactor owns the Admin listener, data-sync adapter, registry provider and sync
starter together. See [installation, compatibility and staged cutover](../../docs/plugin-store-apollo.md).

Prepare compatible core API artifacts with the core checkout's Maven wrapper:

```bash
/path/to/shenyu/mvnw -B -ntp -f /path/to/shenyu/pom.xml \
  -pl shenyu-admin-listener/shenyu-admin-listener-api,shenyu-sync-data-center/shenyu-sync-data-api,shenyu-registry/shenyu-registry-core \
  -am install -DskipTests -Dmaven.javadoc.skip=true -DskipRemoteResources=true
```

CI pins core commit `971354fef10260e46e09ed951e0bff4d9b5e4040`. Build/test all four children:

```bash
mvn -B -ntp -pl shenyu-extension/shenyu-extension-apollo/shenyu-admin-listener-apollo,shenyu-extension/shenyu-extension-apollo/shenyu-sync-data-apollo,shenyu-extension/shenyu-extension-apollo/shenyu-registry-apollo,shenyu-extension/shenyu-extension-apollo/shenyu-spring-boot-starter-sync-data-apollo -am clean verify
```

After packaging, run `python3 script/plugin-store/check-apollo-packaging.py` to
verify each final JAR owns its implementation and runtime registration resources
without embedding core or sibling API classes. CI runs this check.

No live Apollo account or server is needed by the unit/SDK listener-filtering fixtures.
The real SDK `DefaultConfig` test checks asynchronous interested-key prefix handling;
Admin OpenAPI boundaries use mocks. Full portal/config-service deployment is a separate
staging release gate and is not claimed by this test suite.

The shared `ApolloPathConstants` class remains owned by core, preserving downstream
API compatibility; shaded extension JARs exclude core APIs and sibling providers.
The initial receiving coordinates use store `2.7.1-SNAPSHOT` against core `2.7.2-SNAPSHOT`.
Publish only after agreeing on release ownership and compatible versions; main removal
requires dev-list consensus plus a released deprecation cycle and rollback window.
