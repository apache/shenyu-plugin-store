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

# polaris SQL Assets

No plugin-specific SQL install asset is required for `polaris`.

Polaris is a sync/registry extension and has no plugin row, plugin_handle, resource, permission, or namespace_plugin_rel seed rows in the pinned source. The core schema and shared sync/registry configuration remain in Apache ShenYu core.

This directory exists to make the SQL ownership decision explicit for the plugin-store migration.
