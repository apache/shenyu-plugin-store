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

-- Archive-only historical SQL fragments for sofa.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-mysql.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'sofa'

-- Fragment 2
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-pg.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'sofa'

-- Fragment 3
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172872', '11', 'corethreads', 'corethreads', 1, 3, 4, '{\"required\":\"0\",\"defaultValue\":\"0\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 4
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172873', '11', 'threads', 'threads', 1, 3, 5, '{\"required\":\"0\",\"defaultValue\":\"2147483647\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 5
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172874', '11', 'queues', 'queues', 1, 3, 6, '{\"required\":\"0\",\"defaultValue\":\"0\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 6
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172875', '11', 'threadpool', 'threadpool', 3, 3, 3, '{\"required\":\"0\",\"defaultValue\":\"default\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 7
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- insert plugin_handle data for sofa

-- Fragment 8
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- UPDATE plugin SET config='{"protocol":"zookeeper","register":"127.0.0.1:2181","threadpool":"shared"}' WHERE "name" = 'sofa';

-- Fragment 9
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524917', '11', 'corethreads', 'corethreads', 1, 3, 4, '{"required":"0","defaultValue":"0","placeholder":"corethreads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 10
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524918', '11', 'threads', 'threads', 1, 3, 5, '{"required":"0","defaultValue":"2147483647","placeholder":"threads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 11
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524919', '11', 'queues', 'queues', 1, 3, 6, '{"required":"0","defaultValue":"0","placeholder":"queues","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 12
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524920', '11', 'threadpool', 'threadpool', 3, 3, 3, '{"required":"0","defaultValue":"default","placeholder":"threadpool","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 13
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- insert plugin_handle data for sofa

-- Fragment 14
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- UPDATE plugin SET config='{"protocol":"zookeeper","register":"127.0.0.1:2181","threadpool":"shared"}' WHERE "name" = 'sofa';

-- Fragment 15
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613199978534', '11', 'protocol', 'protocol', 2, 1, 1, NULL, '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 16
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613199978535', '11', 'register', 'register', 2, 1, 2, NULL, '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 17
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172874', '11', 'corethreads', 'corethreads', 1, 1, 4, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 18
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172875', '11', 'threads', 'threads', 1, 1, 5, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 19
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172876', '11', 'queues', 'queues', 1, 1, 6, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 20
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172877', '11', 'threadpool', 'threadpool', 3, 1, 3, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 21
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613199978534', '11', 'protocol', 'protocol', 2, 1, 1, NULL, '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 22
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613199978535', '11', 'register', 'register', 2, 1, 2, NULL, '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 23
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613204172874', '11', 'corethreads', 'corethreads', 1, 1, 4, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 24
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613204172875', '11', 'threads', 'threads', 1, 1, 5, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 25
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613204172876', '11', 'queues', 'queues', 1, 1, 6, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 26
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1729402613204172877', '11', 'threadpool', 'threadpool', 3, 1, 3, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 27
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524917', '11', 'corethreads', 'corethreads', 1, 1, 4, '{"required":"0","defaultValue":"","placeholder":"corethreads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 28
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524918', '11', 'threads', 'threads', 1, 1, 5, '{"required":"0","defaultValue":"","placeholder":"threads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 29
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524919', '11', 'queues', 'queues', 1, 1, 6, '{"required":"0","defaultValue":"","placeholder":"queues","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 30
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524920', '11', 'threadpool', 'threadpool', 3, 1, 3, '{"required":"0","defaultValue":"","placeholder":"threadpool","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 31
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902775136289', '11', 'protocol', 'protocol', 2, 1, 1, NULL, '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 32
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902775136290', '11', 'register', 'register', 2, 1, 2, NULL, '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 33
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897210273825', '11', 'protocol', 'protocol', 2, 1, 1, null)

-- Fragment 34
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897210273826', '11', 'register', 'register', 2, 1, 2, null)

-- Fragment 35
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897214468164', '11', 'corethreads', 'corethreads', 1, 1, 4, '{"required":"0","defaultValue":"","placeholder":"corethreads","rule":""}')

-- Fragment 36
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897214468165', '11', 'threads', 'threads', 1, 1, 5, '{"required":"0","defaultValue":"","placeholder":"threads","rule":""}')

-- Fragment 37
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897214468166', '11', 'queues', 'queues', 1, 1, 6, '{"required":"0","defaultValue":"","placeholder":"queues","rule":""}')

-- Fragment 38
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1718229897214468167', '11', 'threadpool', 'threadpool', 3, 1, 3, '{"required":"0","defaultValue":"","placeholder":"threadpool","rule":""}')

-- Fragment 39
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902775136289', '11', 'protocol', 'protocol', 2, 1, 1, NULL, '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 40
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902775136290', '11', 'register', 'register', 2, 1, 2, NULL, '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 41
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524917', '11', 'corethreads', 'corethreads', 1, 1, 4, '{"required":"0","defaultValue":"","placeholder":"corethreads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 42
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524918', '11', 'threads', 'threads', 1, 1, 5, '{"required":"0","defaultValue":"","placeholder":"threads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 43
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524919', '11', 'queues', 'queues', 1, 1, 6, '{"required":"0","defaultValue":"","placeholder":"queues","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 44
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1729403902783524920', '11', 'threadpool', 'threadpool', 3, 1, 3, '{"required":"0","defaultValue":"","placeholder":"threadpool","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')
