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

# Plugin Store Migration Manifests

These portable manifests describe the plugin-owned asset transfer for the 13 existing integrations from Apache ShenYu into the plugin store PR worktrees. Paths are repository-relative and use worktree identifiers plus PR URLs instead of local workstation paths.

The manifests preserve the original asset inventory separately from generated support files such as SQL install/preflight scripts, archive fragments, runner scripts, and copied helper closures. They record provenance and hashes for source and destination files where the files are available locally.

Runtime parity is not implied by file presence. Scenario entries preserve original test identity and point to their destinations; runtime proof remains bounded to the evidence in the report logs.
