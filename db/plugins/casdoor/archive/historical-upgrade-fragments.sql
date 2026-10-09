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

-- Archive-only historical SQL fragments for casdoor.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin` VALUES ('39', 'casdoor', '{\"endpoint\":\"http://localhost:8000\"}', 'Authentication', 40, 0, '2022-09-11 12:00:00', '2022-09-11 12:00:00')

-- Fragment 2
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570590990341775360', '39', 'endpoint', 'casdoor endpoint', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 3
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570591047635968000', '39', 'client_id', 'client_id', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 4
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570591109623586816', '39', 'client_secrect', 'client_secrect', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 5
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570591165374275584', '39', 'certificate', 'certificate', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 6
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570591215131303936', '39', 'organization-name', 'organization-name', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 7
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1570591265492312064', '39', 'application-name', 'application-name', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46.925', '2022-09-16 09:50:46.925')

-- Fragment 8
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin(id)) */ INTO plugin (id, name, config, role, sort, enabled) VALUES ('39', 'casdoor', '{"endpoint":"http://localhost:8000"}' ,'Authentication', 40, '0')

-- Fragment 9
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570590990341775360', '39', 'endpoint', 'casdoor endpoint', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 10
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570591047635968000', '39', 'client_id', 'client_id', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 11
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570591109623586816', '39', 'client_secrect', 'client_secrect', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 12
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570591165374275584', '39', 'certificate', 'certificate', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 13
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570591215131303936', '39', 'organization-name', 'organization-name', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 14
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1570591265492312064', '39', 'application-name', 'application-name', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 15
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('39', 'casdoor', '{"endpoint":"http://localhost:8000"}', 'Authentication', 40, 0, '2022-09-11 12:00:00', '2022-09-11 12:00:00')

-- Fragment 16
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570590990341775360', '39', 'endpoint', 'casdoor endpoint', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')

-- Fragment 17
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591047635968000', '39', 'client_id', 'client_id', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')

-- Fragment 18
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591109623586816', '39', 'client_secrect', 'client_secrect', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')

-- Fragment 19
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591165374275584', '39', 'certificate', 'certificate', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')

-- Fragment 20
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591215131303936', '39', 'organization-name', 'organization-name', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')

-- Fragment 21
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312064', '39', 'application-name', 'application-name', 2, 3, 0, '{"required":"1","rule":""}', '2022-09-16 09:50:46', '2022-09-16 09:50:46')
