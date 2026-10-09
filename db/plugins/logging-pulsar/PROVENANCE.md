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

# logging-pulsar SQL Provenance

- Source version: `2.7.2-SNAPSHOT`
- Source SHA: `ec198d442894fd9617947ed73c6c8fe3b206f665`
- Plugin: `loggingPulsar` (`35`)
- Active installers: `h2`, `mysql`, `pg`, `og`, `ob`, and `oracle` `install.sql` files under this directory.
- Install behavior: repeatable insert-if-absent; no deletes; no unconditional updates to existing plugin or namespace configuration.
- Guard behavior: dependent rows are inserted only when plugin id and name both match the canonical plugin.
- Fallback tables: some dialect sources lacked resource/permission rows; those rows were rendered from same-plugin MySQL seed rows and recorded per dialect in `row-manifest.json`.
- Historical archive fragments: `56` statement(s) in `archive/historical-upgrade-fragments.sql`. Archive fragments are provenance only and are not included by any install script.
