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
# Casdoor Plugin Migration

`shenyu-plugin-casdoor` is published from the plugin store as an optional authentication extension. The moved runtime keeps the ShenYu plugin name, plugin order, configuration fields, and downstream identity headers used by the in-tree implementation.

## Coordinates

Add the external starter to a ShenYu bootstrap that targets the supported ShenYu API line:

```xml
<dependency>
    <groupId>org.apache.shenyu</groupId>
    <artifactId>shenyu-spring-boot-starter-plugin-casdoor</artifactId>
    <version>2.7.1-SNAPSHOT</version>
</dependency>
```

The store artifact compiles against ShenYu `2.7.2-SNAPSHOT` plugin APIs and keeps `casdoor-java-sdk` at `1.9.0`.
The Casdoor SDK's old transitive `org.json:json:20140107` artifact remains excluded because its JSON License is ASF Category X unsuitable for Apache distribution. The plugin declares `org.json:json:20240303` directly at runtime so the SDK/Oltu OAuth callback parser owns a modern Public Domain JSON parser on the starter classpath.

## Configuration

The plugin-data JSON uses the same fields as the former main-repository plugin:

```json
{
  "endpoint": "http://localhost:8000",
  "client_id": "client-id",
  "client_secrect": "client-secret",
  "certificate": "-----BEGIN CERTIFICATE-----\\n...\\n-----END CERTIFICATE-----",
  "organization-name": "built-in",
  "application-name": "app-built-in"
}
```

Certificates and secrets should be supplied through deployment configuration or the ShenYu admin plugin configuration. Do not commit production secrets or long-lived test credentials.

## Compatibility

Existing admin plugin data can be reused. A valid bearer token or callback `code` and `state` continue to authenticate through the Casdoor SDK. On success, the plugin forwards the same trusted headers to downstream handlers: `name`, `id`, and `organization`. The starter gateway test covers both bearer JWT authentication and a local OAuth callback token exchange, proving the direct runtime JSON parser dependency is available through the starter-created plugin bean.

The starter remains enabled by default for compatibility. Set `shenyu.plugins.casdoor.enabled=false` to keep the dependency present but prevent plugin registration.

## Rollback

During the cutover release window, rollback is a Maven dependency change: remove the store starter and use the previous ShenYu distribution that still shipped the in-tree Casdoor starter. Existing plugin configuration remains compatible because the external plugin keeps the same plugin name and configuration schema.
