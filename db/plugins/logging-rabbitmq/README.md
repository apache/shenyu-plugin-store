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

# logging-rabbitmq SQL Assets

These assets install Apache ShenYu admin metadata for `loggingRabbitMQ` after the plugin has moved to the plugin store.

Source provenance is recorded in each dialect file. The install scripts are repeatable and insert plugin, handle, resource, permission, and default-namespace relation rows only when the existing key is absent. Existing user configuration is not overwritten.

Run the matching dialect `preflight.sql` before `install.sql`. A preflight error means the database already contains a conflicting canonical plugin ID/name, row ID, natural key, resource parent, or permission resource identity. That collision is unsupported for automatic install and must be reconciled manually before running `install.sql`.

Conflict behavior: the plugin row uses the canonical ShenYu plugin ID/name pair. Dependent metadata is installed only when that exact ID/name pair exists. Resource children also require their expected parent resource identity, and permissions require their expected resource identity, so permissions are not granted to unrelated existing resource IDs if a collision is present.

Default namespace: `649330b6-c2d7-4edc-be8e-8a54df9eb385`.

Dialect coverage: h2, mysql, ob, og, oracle, pg.
