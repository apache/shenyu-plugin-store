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

-- Archive-only historical SQL fragments for tars.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-mysql.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'tars'

-- Fragment 2
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-pg.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'tars'

-- Fragment 3
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172868', '13', 'corethreads', 'corethreads', 1, 3, 3, '{\"required\":\"0\",\"defaultValue\":\"0\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 4
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172869', '13', 'threads', 'threads', 1, 3, 4, '{\"required\":\"0\",\"defaultValue\":\"2147483647\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 5
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172870', '13', 'queues', 'queues', 1, 3, 5, '{\"required\":\"0\",\"defaultValue\":\"0\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 6
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172871', '13', 'threadpool', 'threadpool', 3, 3, 2, '{\"required\":\"0\",\"defaultValue\":\"default\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 7
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- UPDATE plugin SET config='{"multiSelectorHandle":"1","multiRuleHandle":"0","threadpool":"shared"}' WHERE `name` = 'tars'

-- Fragment 8
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- insert plugin_handle data for tars

-- Fragment 9
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524913', '13', 'corethreads', 'corethreads', 1, 3, 3, '{"required":"0","defaultValue":"0","placeholder":"corethreads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 10
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524914', '13', 'threads', 'threads', 1, 3, 4, '{"required":"0","defaultValue":"2147483647","placeholder":"threads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 11
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524915', '13', 'queues', 'queues', 1, 3, 5, '{"required":"0","defaultValue":"0","placeholder":"queues","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 12
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524916', '13', 'threadpool', 'threadpool', 3, 3, 2, '{"required":"0","defaultValue":"default","placeholder":"threadpool","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 13
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- UPDATE plugin SET config='{"multiSelectorHandle":"1","multiRuleHandle":"0","threadpool":"shared"}' WHERE "name" = 'tars'

-- Fragment 14
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- insert plugin_handle data for tars
