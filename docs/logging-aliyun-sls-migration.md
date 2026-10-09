<!--
  ~ Licensed to the Apache Software Foundation (ASF) under one or more
  ~ contributor license agreements.  See the NOTICE file distributed with
  ~ this work for additional information regarding copyright ownership.
  ~ The ASF licenses this file to You under the Apache License, Version 2.0
  ~ (the "License"); you may not use this file except in compliance with
  ~ the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

# Logging Aliyun SLS Plugin Migration

The `loggingAliyunSls` plugin is packaged by `shenyu-plugin-store` as:

- `org.apache.shenyu:shenyu-plugin-logging-aliyun-sls:2.7.1-SNAPSHOT`
- `org.apache.shenyu:shenyu-spring-boot-starter-plugin-logging-aliyun-sls:2.7.1-SNAPSHOT`

It consumes ShenYu core logging APIs from `2.7.2-SNAPSHOT`, including `shenyu-plugin-logging-common`.

## Install

Add the starter to the gateway bootstrap that should emit Aliyun SLS access logs:

```xml
<dependency>
    <groupId>org.apache.shenyu</groupId>
    <artifactId>shenyu-spring-boot-starter-plugin-logging-aliyun-sls</artifactId>
    <version>2.7.1-SNAPSHOT</version>
</dependency>
```

Keep the gateway's ShenYu core modules on a compatible `2.7.2-SNAPSHOT` line until the store artifact and core cutover are released together.

## Configuration

The plugin name and selector/rule semantics remain `loggingAliyunSls`. Existing admin data can be kept and pointed at the external starter during migration.

Global plugin configuration fields:

- `accessId` and `accessKey`: Aliyun credentials. Inject with your normal secret-management mechanism; do not commit literal credentials.
- `host`: SLS endpoint, for example `cn-guangzhou.log.aliyuncs.com`.
- `projectName`, `logStoreName`, `topic`: SLS destination.
- `ttlInDay`, `shardCount`, `sendThreadCount`, `ioThreadCount`: SDK/logstore and async delivery sizing.
- `sampleRate`, `maxRequestBody`, `maxResponseBody`, `bufferQueueSize`: shared ShenYu logging controls.

## Payload

Each gateway access log is sent as one SLS `LogItem` with:

- `level=info`
- `name=<request URI>`
- `message=<ShenyuRequestLog JSON>`

The `message` JSON includes request URI, method, request headers, response headers, response body up to `maxResponseBody`, status, selector id, rule id, namespace id, path, and timing fields.

## Batching, retry, and failures

The shared logging collector buffers access logs in memory and asynchronously drains them to the Aliyun producer. The Aliyun SDK producer owns cloud-side retry behavior. Send exceptions are logged and do not fail the gateway response path.

## Rollback

To roll back before the main-repository removal is finalized, remove the external starter dependency and restore the in-tree starter dependency in the gateway bootstrap. Admin plugin configuration can remain disabled or unchanged; historical upgrade SQL remains in the main repository.

## Validation status

Current store validation covers copied unit tests plus a credential-free gateway contract test that starts a real `ShenyuWebHandler` on a random Reactor Netty port, loads the real external starter Spring context, and mocks the Aliyun producer boundary. It verifies status/header/body fields, send failure handling, config update, repeated start, and cleanup. Real Aliyun smoke testing is intentionally not required for contributor PRs.
