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
# Hystrix Legacy Plugin Migration

`shenyu-plugin-hystrix` is published from the plugin store as a deprecated legacy compatibility plugin. Netflix Hystrix is retained at `1.5.18` for existing ShenYu users that still need the old rule semantics. New fault-tolerance deployments should use the ShenYu Resilience4j plugin.

## Coordinates

Add the external starter to a ShenYu bootstrap that targets the supported ShenYu API line:

```xml
<dependency>
    <groupId>org.apache.shenyu</groupId>
    <artifactId>shenyu-spring-boot-starter-plugin-hystrix</artifactId>
    <version>2.7.1-SNAPSHOT</version>
</dependency>
```

The store artifact compiles against ShenYu `2.7.2-SNAPSHOT` plugin APIs and keeps the upstream Hystrix dependencies at `1.5.18`.

## Compatibility

Existing plugin, selector, and rule configuration is reused without changing field names. The runtime still reads `HystrixHandle` rule data, including isolation strategy, timeout, fallback URI, command key, group key, circuit breaker thresholds, semaphore limits, and thread-pool settings.

The starter remains enabled by default for compatibility. Set `shenyu.plugins.hystrix.enabled=false` to keep the dependency present but prevent plugin registration.

## Rollback

During the cutover release window, rollback is a Maven dependency change: remove the store starter and use the previous ShenYu distribution that still shipped the in-tree Hystrix starter. Plugin and rule data can remain in the admin database because the external plugin keeps the same plugin name and rule-handle schema.

For forward migration, replace Hystrix rules with equivalent Resilience4j rules, verify timeout/fallback/circuit behavior in a staging gateway, then disable and remove the Hystrix starter.
