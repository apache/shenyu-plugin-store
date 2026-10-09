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

-- Archive-only historical SQL fragments for logging-clickhouse.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin` VALUES ('38', 'loggingClickHouse', '{\"host\":\"127.0.0.1\",\"port\":\"8123\",\"databse\":\"shenyu-gateway\",\"username\":\"foo\",\"password\":\"bar\"}', 'Logging', 195, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 2
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172767', '38', 'keyword', 'keyword', 2, 2, 0, '{\"required\":\"0\",\"placeholder\":\"please use ‘;’ to split keyword\",\"rule\":\"\"}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 3
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172768', '38', 'maskType', 'maskType', 3, 2, 1, '{\"required\":\"0\",\"defaultValue\":\"dataMaskByMD5\",\"rule\":\"\"}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 4
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172769', '38', 'maskStatus', 'maskStatus', 3, 2, 2, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 5
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172770', '38', 'host', 'host', 2, 3, 3, '{\"required\":\"1\",\"defaultValue\":\"127.0.0.1\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 6
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172771', '38', 'port', 'port', 2, 3, 4, '{\"required\":\"1\",\"defaultValue\":\"8123\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 7
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172772', '38', 'database', 'database', 2, 3, 5, '{\"required\":\"0\",\"defaultValue\":\"shenyu-gateway\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 8
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172773', '38', 'username', 'username', 2, 3, 6, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 9
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172774', '38', 'password', 'password', 2, 3, 7, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 10
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172775', '38', 'engine', 'engine', 3, 3, 8, '{\"required\":\"0\",\"defaultValue\":\"MergeTree\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 11
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172776', '38', 'clusterName', 'clusterName', 3, 3, 9, '{\"required\":\"1\",\"defaultValue\":\"cluster\",\"rule\":\"\"}', '2022-12-30 00:17:21.150', '2022-12-30 00:17:21.150')

-- Fragment 12
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565043', '1346775491550474240', 'loggingClickHouse', 'loggingClickHouse', '/plug/loggingClickHouse', 'loggingClickHouse', 1, 0, 'pic-center', 0, 0, '', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 13
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565044', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 14
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565045', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 15
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565046', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 16
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565047', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 17
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565048', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 18
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565049', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 19
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565050', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 20
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565051', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 21
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565052', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouse:modify', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 22
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin(id)) */ INTO plugin (id, name, config, role, sort, enabled) VALUES ('38', 'loggingClickHouse', '{"host":"127.0.0.1","port":"8123","databse":"shenyu-gateway","username":"foo","password":"bar"}', 'Logging', 195, '0')

-- Fragment 23
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468255', '38', 'host', 'host', 2, 3, 3, '{"required":"1","defaultValue":"127.0.0.1"}')

-- Fragment 24
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468256', '38', 'port', 'port', 2, 3, 4, '{"required":"1","defaultValue":"8123"}')

-- Fragment 25
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468257', '38', 'database', 'database', 2, 3, 5, '{"required":"0","defaultValue":"shenyu-gateway"}')

-- Fragment 26
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468258', '38', 'username', 'username', 2, 3, 6, '{"required":"1","defaultValue":""}')

-- Fragment 27
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468259', '38', 'password', 'password', 2, 3, 7, '{"required":"1","defaultValue":""}')

-- Fragment 28
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468260', '38', 'password', 'password', 2, 3, 7, '{"required":"1","defaultValue":""}')

-- Fragment 29
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468261', '38', 'engine', 'engine', 3, 3, 8, '{"required":"0","defaultValue":"MergeTree"}')

-- Fragment 30
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172862', '38', 'clusterName', 'clusterName', 3, 3, 9, '{"required":"1","defaultValue":"cluster"}')

-- Fragment 31
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468252', '38', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}')

-- Fragment 32
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468253', '38', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}')

-- Fragment 33
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468254', '38', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}')

-- Fragment 34
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- -- insert loggingClickHouse plugin start

-- Fragment 35
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- -- insert loggingClickHouse plugin End

-- Fragment 36
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('38', 'loggingClickHouse', '{"host":"127.0.0.1","port":"8123","databse":"shenyu-gateway","username":"foo","password":"bar"}', 'Logging', 195, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 37
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172830', '38', 'host', 'host', 2, 3, 3, '{"required":"1","defaultValue":"127.0.0.1"}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 38
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172831', '38', 'port', 'port', 2, 3, 4, '{"required":"1","defaultValue":"8123"}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 39
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172832', '38', 'database', 'database', 2, 3, 5, '{"required":"0","defaultValue":"shenyu-gateway"}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 40
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172833', '38', 'username', 'username', 2, 3, 6, '{"required":"1","defaultValue":""}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 41
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172834', '38', 'password', 'password', 2, 3, 7, '{"required":"1","defaultValue":""}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 42
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172835', '38', 'engine', 'engine', 3, 3, 8, '{"required":"0","defaultValue":"MergeTree"}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 43
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172836', '38', 'clusterName', 'clusterName', 3, 3, 9, '{"required":"1","defaultValue":"cluster"}', '2023-01-02 00:17:21.150', '2023-01-02 00:17:21.150')

-- Fragment 44
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565043', '1346775491550474240', 'loggingClickHouse', 'loggingClickHouse', '/plug/loggingClickHouse', 'loggingClickHouse', 1, 0, 'block', 0, 0, '', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 45
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565044', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 46
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565045', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 47
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565046', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 48
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565047', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseSelector:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 49
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565048', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 50
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565049', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 51
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565050', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 52
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565051', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouseRule:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 53
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565052', '1534585531108565043', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingClickHouse:modify', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 54
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172827', '38', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 55
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172829', '38', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 56
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172830', '38', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 57
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172777', '38', 'ttl', 'ttl', 3, 3, 10,  '{\"required\":\"0\",\"defaultValue\":\"30\"}', '2023-03-01 11:14:15', '2023-08-16 11:15:14')

-- Fragment 58
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507019', '38', 'sampleRate', 'sampleRate', 2, 3, 11, '{\"required\":\"0\",\"defaultValue\":\"1\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 59
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507020', '38', 'sampleRate', 'sampleRate', 2, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 60
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO  "public"."plugin_handle" VALUES ('1529402613204172777', '38', 'ttl', 'ttl', 3, 3, 10, '{"required":"0","defaultValue":"30"}', '2023-03-01 11:14:15', '2023-08-16 11:15:14')

-- Fragment 61
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1529402613204172777', '38', 'ttl', 'ttl', 3, 3, 10,  '{\"required\":\"0\",\"defaultValue\":\"30\"}')

-- Fragment 62
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507018', '38', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}')

-- Fragment 63
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507019', '38', 'sampleRate', 'sampleRate', 2, 3, 11,'{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}')

-- Fragment 64
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172737', '38', 'ttl', 'ttl', 3, 3, 10,  '{"required":"0","defaultValue":"30"}', '2023-03-01 11:14:15', '2023-08-16 11:15:14')

-- Fragment 65
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507017', '38', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 66
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507018', '38', 'sampleRate', 'sampleRate', 2, 3, 11, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')
