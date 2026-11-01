<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.
-->

# Reactive LEGACY plugin contract kit

Use `org.apache.shenyu:shenyu-plugin-store-test-support:2.7.1-SNAPSHOT` in
**test scope**. This extends the existing store gateway fixtures; it does not
create another runtime executor or a core release/BOM compatibility program.
The initial verified core is `2.7.2-SNAPSHOT` built from
`b46bf15c3a243e926994cb32c3f0a23eadc41adf`. These are local development
artifacts and evidence, not a claim of publication to Maven Central or compatibility
with every core version. Release/build matrix ownership remains with #7294/#7306.

```xml
<dependency>
    <groupId>org.apache.shenyu</groupId>
    <artifactId>shenyu-plugin-store-test-support</artifactId>
    <version>2.7.1-SNAPSHOT</version>
    <scope>test</scope>
</dependency>
```

Spring test and Reactor test are dependencies of this test-support artifact.
No production plugin or starter gains a runtime dependency on them. Keep this
artifact off production classpaths: its existing E2E cache fixtures are test-only.

## Pick a role and an observable contract

`LegacyPluginContractKit.open(name, profile, orderedPlugins)` creates a scoped
request backed by the **actual** `ShenyuWebHandler`. It does not copy the legacy
cursor, sort plugins, add `cache()`, or change continuation behavior. A caller
can supply a terminal response owner instead of the default no-op terminal.

| Profile/check | What it proves | Limits |
| --- | --- | --- |
| TRANSFORM | Declared downstream subscription count and real request/response transformation | Does not prove an external protocol/SDK is correct |
| SHORT_CIRCUIT | Zero downstream subscriptions can be correct; the plugin owns its response | No blanket continuation-exactly-once requirement |
| WRAPPER | Explicitly expected zero/one/multiple successor subscriptions and nested scope behavior | Duration would be inclusive; plugin order does not identify a role |
| BASE_MATCHING | Actual base-plugin lookup/matching, including missing config and rule miss | Conditions/config remain the core implementation's responsibility |
| FORK | Real optional isolated cursor behavior | A fork restarts the snapshot at the chain head and shares the exchange/body/response; it is not parallel-safe isolation |
| Owner release probe | The **declared actual owner** receives one completion/error/cancellation signal | Plugin publisher cancellation alone does not prove a network RPC was cancelled |
| Configuration removal | A valid fixture is published and an explicitly supported removal removes its observed state | No universal null/clear/disable or SDK lease policy is invented |

Use `verifyComplete(expectedDownstreamSubscriptions)` to state the role's
expectation. Counts are cumulative within one session, which lets repeated root
subscriptions show that the real handler creates fresh chains. Use a fresh
session for independent HTTP response ownership; a committed response is not
silently replayed. `verifyError` observes the escaped chain failure, before an
outer HTTP error renderer. `verifyCancellation` cancels the actual root.

`assertDeferred` checks **request effects at root assembly/subscription**. It
does not forbid all side effects in a direct `plugin.execute()` call: the real
handler defers invocation. Existing `before/after` hooks still bracket returned
publisher construction, including overrides; they are not asynchronous
completion callbacks. The controlled asynchronous fixture verifies this timing.

A `ReleaseProbe` is optional and must be attached to the resource owner's
terminal signal. It waits for a controlled signal with an explicit bound and
checks exactly one release; no detached cleanup subscription is introduced.
Use protocol/SDK-specific fixtures to establish that this owner is the real call
or stream. Declare unsupported lease/provider contracts rather than inventing
them for a test.

```java
try (var session = LegacyPluginContractKit.open(
        "my-plugin", LegacyPluginContractKit.Profile.TRANSFORM, List.of(plugin))) {
    LegacyPluginContractKit.assertDeferred("my-plugin", session::publisher, effects::longValue);
    session.verifyComplete(1);
}
```

The fixture supplies a default ShenYu HTTP context and ShenyuConfig bean, with
scheduling disabled for controlled unit contracts. `registerFixtureBean` lets
a consumer explicitly supply additional test beans before subscription.
Sessions restore the previous Spring helper context when closed. Core caches and
that helper are process-global: run these fixtures serially, nest scopes in LIFO
order, and remove your own cached fixtures. `GatewayFixtures.cleanBaseDataCache`
is a whole-cache helper for a dedicated test JVM, not per-request isolation.

## Examples, evidence and rejected fixtures

`contract-examples/legacy-plugin-consumer` is outside the source reactor and has
no parent POM. It demonstrates a transformation plugin, a downstream wrapper with
a controlled asynchronous successor, and a short-circuit response owner. Its
opt-in smoke uses the existing `ShenyuGatewayTestServer` over real loopback HTTP,
including a real plugin and response writer; no Docker or credentials are needed.

The kit's own tests exercise completion/error/cancellation, skip, missing config,
rule match/miss, repeated roots, response decorators, nested wrappers, optional
fork dispatch and supported removal. Deliberately bad fixtures are detected for
eager root effects, unexpected duplicate downstream effects for TRANSFORM,
lost owner cancellation/cleanup, a dropped response decorator and stale state
after declared removal. A WRAPPER declaring the same two dispatches passes.
Tests use controlled publishers/signals and bounded waits, not sleeps or random
traffic percentages.

`LegacyPluginContractKit.evidence(...)` records observed packaged kit/core
versions, explicitly declared source provenance, selected profiles, and
unsupported/skipped capabilities. Development classes report unknown version
instead of fabricating artifact provenance. Descriptors are optional; neither
schema adoption nor GRAPH execution is required. Real provider behavior,
uploaded-plugin/starter/distribution E2E and release compatibility remain in the
owning plugin/integration workflows. Existing original-suite runners under
`script/plugin-store/` and core's uploaded-plugin smoke remain available.

## Reproduce independent consumption on Windows

Pass a clean pinned core checkout containing its Maven wrapper:

```powershell
./script/plugin-store/verify-legacy-contract-consumer.ps1 -CoreCheckout C:/path/to/pinned-core
```

The script uses that wrapper for every Maven invocation. It builds the required
pinned core modules and the kit, copies their JARs/POMs into a fixed local staging
repository, then builds the parentless consumer with a **fresh isolated local
repository**. A read-only cache repository supplies releases only; it cannot
satisfy the staged ShenYu snapshots. After the four consumer tests, every resolved
ShenYu JAR's SHA-256 must equal the staged source bytes.

Results are written under `target/legacy-contract-proof/`: producer logs,
external consumer log, staging repository and `proof.json` containing core
revision, candidate kit state, isolated repository and artifact hashes. The script
does not delete repository data. A default consumer run skips the optional real
HTTP smoke; the verification script explicitly enables it.

Manual standalone builds on other platforms can use the same parentless POM and
a prepared staging repository:

```text
/path/to/core/mvnw -f contract-examples/legacy-plugin-consumer/pom.xml clean test -Dcontract.stagingRepository=file:///path/to/staging/ -Dcontract.dependencyCache=file:///path/to/release-cache/ -Dmaven.repo.local=/path/to/fresh-consumer-cache -Dcontract.smoke=true
```

The kit's producer tests/checks can be run independently through the wrapper:

```text
/path/to/core/mvnw -f pom.xml -pl shenyu-plugin/shenyu-plugin-store-test-support -am verify -Dtest=LegacyPluginContractKitTest,ShenyuGatewayTestServerTest -Dsurefire.failIfNoSpecifiedTests=false -Djacoco.skip=true -DskipRemoteResources=true -Dmaven.javadoc.skip=true
```
