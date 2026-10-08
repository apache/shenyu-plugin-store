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

# H2 Store SQL Fixture Gate

`build-h2-store-sql-fixture.py` prepares a pinned-core H2 schema fixture for one plugin and optionally executes the store-owned H2 install SQL.

The fixture flow is:

1. Read pinned core H2 schema from `${SHENYU_CORE_SOURCE:-../shenyu}/shenyu-admin/src/main/resources/sql-script/h2/schema.sql`.
2. Read the store-owned `db/plugins/<plugin>/row-manifest.json` when it is present.
3. Remove only the target plugin seed rows listed in that row manifest from these tables:
   - `plugin`
   - `plugin_handle`
   - `resource`
   - `permission`
   - `namespace_plugin_rel`
4. Copy the store-owned preflight and install SQL from `db/plugins/<plugin>/h2/preflight.sql` and `db/plugins/<plugin>/h2/install.sql`, or an explicit `--store-sql-dir`.
5. With `--execute`, apply the stripped core schema, assert the target plugin is absent, run `preflight.sql`, apply `install.sql` twice, and assert expected row counts.

Example:

```bash
script/plugin-store/build-h2-store-sql-fixture.py motan \
  --core-source ../shenyu \
  --store-sql-dir db/plugins/motan \
  --output-dir target/plugin-store-sql-fixture \
  --execute
```

Outputs are written under `target/plugin-store-sql-fixture/<plugin>/`:

- `core-without-target-seeds.sql`
- `store-h2-preflight.sql`
- `store-h2-install.sql`
- `fixture-result.json`

A passing execution proves the original suite is not succeeding from pinned core bundled seed rows alone: the target plugin is absent before the store preflight/install flow, then appears with the expected plugin, handle, resource, permission, and namespace binding counts after the store-owned install script is applied twice.
