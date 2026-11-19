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
# Release and Compatibility

This document describes the release gates for artifacts built by `apache/shenyu-plugin-store`. A merged pull request is not a published release, and a `-SNAPSHOT` artifact is not a production release.

## Version and API Contract

The root POM has two independent versions:

- `project.version` identifies artifacts published by this repository.
- `shenyu.version` identifies the ShenYu core API used to compile and test the extensions.

Do not assume these versions are interchangeable. The current development defaults are `2.7.1-SNAPSHOT` for this repository and the released `2.7.0` ShenYu API. They describe the current checkout, not a promise that every extension is compatible with every ShenYu release.

The JDK 17 build workflow pins its ShenYu source checkout by commit SHA. That pinned revision, the effective `shenyu.version`, and the workflow result are the reproducible compatibility evidence for a build. Before changing a supported API line, update the pin and version together, run the full workflow, and record the resulting core revision and test report. Extension-specific runtime and protocol versions are recorded in the top-level POM and each migration guide.

## Build and Validation

A clean checkout must have JDK 17 and can run the root verification with the checked-in Maven Wrapper:

```bash
./mvnw -B -ntp clean verify -Dapi.version=1.44
```

This runs compilation, unit tests, Checkstyle, Apache RAT, and packaging. The complete GitHub Actions job also prepares the pinned ShenYu API artifacts and runs the external-service integration/E2E and SQL fixture checks. A local root `clean verify` does not replace those Docker-backed checks.

For a release candidate, the release owner must additionally:

1. Run the full `Build (JDK 17)` workflow on the exact candidate commit and resolve every failed or skipped required check.
2. Run the plugin-specific integration/E2E suites against the candidate artifacts and supported ShenYu API line.
3. Execute each shipped database install/preflight pair on its supported database engines; record any engine that could not be tested.
4. Verify source and Javadoc archives, dependency licenses, NOTICE contents, checksums, and ASF signatures in the staging repository.

Do not treat a local `install` or a successful PR merge as evidence that an artifact was staged or released.

## Two-Repository Cutover

For a new migration, coordinate the receiving plugin-store change and the `apache/shenyu` removal change:

1. Merge and validate the plugin-store implementation, tests, SQL, examples, and compatibility documentation.
2. Select a store release version that has never been published for any of the affected Maven coordinates. The ShenYu core repository and plugin store must not publish the same GAV.
3. Before preparing a release, correct and verify the root POM SCM URL and release tag for this repository. The current POM still points at `apache/shenyu` and has a historical `v2.5.0` tag; those values are not valid release metadata for this repository.
4. Stage and publish the store artifacts using the ASF release process. Verify the public Maven coordinates and signatures from a clean consumer build.
5. Merge the paired `apache/shenyu` removal only after the external starter is available and a minimal bootstrap has passed the plugin's real runtime checks.
6. Update the inventory below, migration notes, website/release notes, and the paired issues with the exact released coordinates and verification links.

### Current SOFA and TARS Cutover

The SOFA/TARS receiving change (plugin-store PR [#6](https://github.com/apache/shenyu-plugin-store/pull/6)) and core removal (ShenYu PR [#7494](https://github.com/apache/shenyu/pull/7494)) are merged. The plugin-store repository currently has no GitHub release, and the merged PR's final JDK 17 workflow run failed in the preserved SOFA integration/E2E step. Therefore the store artifacts are not confirmed as publicly released or ready for a production cutover. Do not use the documented `2.7.1-SNAPSHOT` coordinates as a substitute for a released artifact.

## Rollback

During the supported cutover window, keep the previous ShenYu distribution available. To roll a deployment back:

1. Disable the migrated plugin in Admin and stop sending traffic to it.
2. Remove the external plugin-store starter from the bootstrap build and restore the previous ShenYu distribution that bundled the plugin.
3. Restart the gateway and verify non-migrated routes, metadata synchronization, and plugin health.
4. Keep existing plugin configuration and historical upgrade SQL intact. Do not run destructive database changes as part of rollback.

If a deployment cannot return to a distribution that bundles the plugin, the plugin-store artifact must remain available and pinned; do not remove its only usable runtime artifact during the rollback window.
