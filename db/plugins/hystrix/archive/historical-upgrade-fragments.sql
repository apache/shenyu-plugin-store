-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements. See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License. You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Archive-only historical SQL fragments for hystrix.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-mysql.sql
-- UPDATE plugin SET role = 'FaultTolerance' WHERE name = 'hystrix'

-- Fragment 2
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-pg.sql
-- UPDATE plugin SET role = 'FaultTolerance' WHERE name = 'hystrix'
