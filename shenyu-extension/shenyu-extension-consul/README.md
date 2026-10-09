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
# ShenYu Consul Extension

This extension owns the Consul vertical stack outside the main ShenYu repository:

* `shenyu-admin-listener-consul`
* `shenyu-sync-data-consul`
* `shenyu-registry-consul`
* `shenyu-spring-boot-starter-sync-data-consul`

The extension artifacts are versioned with `shenyu-plugin-store` and compile against the ShenYu `2.7.2-SNAPSHOT` admin-listener, sync-data, registry, common, and web APIs.

## Runtime Configuration

Admin and gateway sync use the same property prefix:

```yaml
shenyu:
  sync:
    consul:
      url: http://127.0.0.1:8500
      waitTime: 1000
      watchDelay: 1000
```

Registry clients use ShenYu register-center properties with the Consul repository type and `host:port` server list. Consul token, watch delay, blocking-query wait time, service tags, and TTL check settings are passed through the registry property map:

```yaml
shenyu:
  register:
    registerType: consul
    serverLists: 127.0.0.1:8500
    props:
      token: ""
      waitTime: "30"
      watchDelay: "5"
      tags: gateway,shenyu
      checkTtl: "5"
```

## Key Layout

Configuration data is written below the ShenYu namespace prefix. For namespace `default`, the effective Consul KV roots are:

* `default/shenyu/plugin/<pluginName>`
* `default/shenyu/selector/<pluginName>/<selectorId>`
* `default/shenyu/rule/<pluginName>/<selectorId>-<ruleId>`
* `default/shenyu/auth/<appKey>`
* `default/shenyu/meta/<path>`
* `default/shenyu/proxySelector/<pluginName>/<selectorId>`
* `default/shenyu/discoveryUpstream/<pluginName>/<selectorId>`

Different namespaces use different top-level prefixes, so test and production tenants can share a Consul server when their ShenYu namespace values are distinct.

## ACL, TLS, And Datacenter Notes

The current migrated implementation preserves the main-repository behavior and uses `com.ecwid.consul:consul-api` for HTTP access. Runtime ACL token support exists in the registry repository property map. Admin-listener and gateway sync currently accept the Consul HTTP URL and do not expose a dedicated TLS or ACL-token binding in `ConsulConfig`; deployments needing mTLS, custom CA bundles, or admin/gateway KV ACL tokens should terminate through a local Consul agent or proxy until those fields are added to the public extension contract.

For multi-datacenter Consul deployments, point ShenYu components at the local agent in the same datacenter. ShenYu stores namespace-scoped KV data and does not create Consul datacenter topology.

## Compatibility And Test Server

The migrated code keeps the existing `consul-api` client version `1.4.5`. The real-server integration test uses the official Docker image `consul:1.15.4` because Docker Hub lists that tag and HashiCorp still publishes Consul `1.15.4` binaries at `https://releases.hashicorp.com/consul/1.15.4/`.

HashiCorp relicensed later Consul source under BUSL for newer releases; the current upstream `LICENSE` states BUSL applies to Consul `1.17.0` or later. The test image therefore stays on the pre-1.17 `1.15.4` line for PR verification. Revisit this note before changing the test image.

## Running Verification

Default unit and starter verification:

```bash
mvn -pl shenyu-extension/shenyu-extension-consul/shenyu-admin-listener-consul,shenyu-extension/shenyu-extension-consul/shenyu-sync-data-consul,shenyu-extension/shenyu-extension-consul/shenyu-registry-consul,shenyu-extension/shenyu-extension-consul/shenyu-spring-boot-starter-sync-data-consul -am test -Drat.skip=true -Djacoco.skip=true -Dmaven.javadoc.skip=true
```

Real Consul server gate:

```bash
mvn -pl shenyu-extension/shenyu-extension-consul/shenyu-spring-boot-starter-sync-data-consul -am test -Dtest=ConsulRealServerTest -DfailIfNoTests=false -Drat.skip=true -Djacoco.skip=true -Dmaven.javadoc.skip=true
```

If the local Docker daemon rejects docker-java's default API version, add a compatible API override such as `-Dapi.version=1.44`.

`ConsulRealServerTest` creates and closes its own Testcontainers Consul server. It covers admin-listener KV writes, gateway subscriber create/update/delete delivery, namespace isolation through a generated prefix, registry service register/update/remove, and shutdown cleanup.

## Rollback

During the cutover release window, rollback is configuration-only:

1. Remove the external Consul extension artifacts from admin/gateway/bootstrap deployments.
2. Restore the main-repository Consul starter and module dependencies for the matching ShenYu release.
3. Keep the same Consul KV namespace and registry service names; the key layout is intentionally unchanged.
4. Restart admin and gateway processes so the old in-repository auto-configuration owns the Consul clients again.

Historical upgrade SQL and release notes stay in the main repository. Do not delete existing Consul KV data during rollback unless the deployment intentionally resets all ShenYu sync state.
