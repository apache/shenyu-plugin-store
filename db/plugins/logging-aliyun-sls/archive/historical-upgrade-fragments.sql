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

-- Archive-only historical SQL fragments for logging-aliyun-sls.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin` VALUES ('34', 'loggingAliyunSls','{\"projectName\": \"shenyu\", \"logStoreName\": \"shenyu-logstore\", \"topic\": \"shenyu-topic\"}', 'Logging', 175, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 2
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172892', '34', 'accessId', 'accessId', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 3
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172893', '34', 'accessKey', 'accessKey', 2, 3, 1, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 4
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172894', '34', 'host', 'host', 2, 3, 2, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 5
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172895', '34', 'projectName', 'projectName', 2, 3, 3, '{\"required\":\"0\",\"defaultValue\":\"shenyu\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 6
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172896', '34', 'logStoreName', 'logStoreName', 2, 3, 4, '{\"required\":\"0\",\"defaultValue\":\"shenyu-logstore\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 7
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172897', '34', 'topic', 'topic', 2, 3, 5, '{\"required\":\"0\",\"defaultValue\":\"shenyu-topic\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 8
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172898', '34', 'ttlInDay', 'ttlInDay', 1, 3, 6, '{\"required\":\"0\",\"defaultValue\":3,\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 9
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172899', '34', 'shardCount', 'shardCount', 1, 3, 7, '{\"required\":\"0\",\"defaultValue\":10,\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 10
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172900', '34', 'sendThreadCount', 'sendThreadCount', 1, 3, 8, '{\"required\":\"0\",\"defaultValue\":1,\"placeholder\":\"1-500\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 11
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172901', '34', 'ioThreadCount', 'ioThreadCount', 1, 3, 9, '{\"required\":\"0\",\"defaultValue\":1,\"placeholder\":\"1-500\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 12
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172902', '34', 'sampleRate', 'sampleRate', 2, 3, 10, '{\"required\":\"0\",\"defaultValue\":\"1\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 13
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172903', '34', 'maxRequestBody', 'maxRequestBody', 1, 3, 11, '{\"required\":\"0\",\"defaultValue\":524288}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 14
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172904', '34', 'maxResponseBody', 'maxResponseBody', 1, 3, 12, '{\"required\":\"0\",\"defaultValue\":524288}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 15
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172905', '34', 'bufferQueueSize', 'bufferQueueSize', 1, 3, 13, '{\"required\":\"0\",\"defaultValue\":50000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 16
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('34', 'loggingAliyunSls', '{"accessId":"accessId", "accessKey": "accessKey", "host": "cn-guangzhou.log.aliyuncs.com", "projectName": "shenyu", "logStoreName": "shenyu-logstore", "topic": "shenyu-topic"}', 'Logging', 175, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 17
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524958', '34', 'accessId', 'accessId', 2, 3, 0, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 18
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524959', '34', 'accessKey', 'accessKey', 2, 3, 1, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 19
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524960', '34', 'host', 'host', 2, 3, 2, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 20
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524961', '34', 'projectName', 'projectName', 2, 3, 3, '{"required":"0","defaultValue":"shenyu","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 21
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524962', '34', 'logStoreName', 'logStoreName', 2, 3, 4, '{"required":"0","defaultValue":"shenyu-logstore","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 22
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524963', '34', 'topic', 'topic', 2, 3, 5, '{"required":"0","defaultValue":"shenyu-topic","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 23
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524964', '34', 'ttlInDay', 'ttlInDay', 1, 3, 6, '{"required":"0","defaultValue":3,"placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 24
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524965', '34', 'shardCount', 'shardCount', 1, 3, 7, '{"required":"0","defaultValue":10,"placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 25
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524966', '34', 'sendThreadCount', 'sendThreadCount', 1, 3, 8, '{"required":"0","defaultValue":1,"placeholder":"1-500"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 26
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524967', '34', 'ioThreadCount', 'ioThreadCount', 1, 3, 9, '{"required":"0","defaultValue":1,"placeholder":"1-500"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 27
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524968', '34', 'sampleRate', 'sampleRate', 2, 3, 10, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 28
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524969', '34', 'maxRequestBody', 'maxRequestBody', 1, 3, 11, '{"required":"0","defaultValue":524288,"placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 29
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524970', '34', 'maxResponseBody', 'maxResponseBody', 1, 3, 12, '{"required":"0","defaultValue":524288,"placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 30
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524971', '34', 'bufferQueueSize', 'bufferQueueSize', 1, 3, 13, '{"required":"0","defaultValue":50000,"placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 31
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564993', '1346775491550474240', 'loggingAliyunSls', 'loggingAliyunSls', '/plug/loggingAliyunSls', 'loggingAliyunSls', 1, 0, 'pic-center', 0, 0, '', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 32
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564994', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 33
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564995', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 34
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564996', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 35
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564997', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 36
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564998', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 37
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108564999', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 38
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565000', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 39
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565001', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 40
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565002', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSls:modify', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 41
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172758', '34', 'keyword', 'keyword', 2, 2, 0, '{\"required\":\"0\",\"placeholder\":\"please use ‘;’ to split keyword\",\"rule\":\"\"}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 42
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172759', '34', 'maskType', 'maskType', 3, 2, 1, '{\"required\":\"0\",\"defaultValue\":\"dataMaskByMD5\",\"rule\":\"\"}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 43
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172760', '34', 'maskStatus', 'maskStatus', 3, 2, 2, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 44
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468243', '34', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}')

-- Fragment 45
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468244', '34', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}')

-- Fragment 46
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468245', '34', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}')

-- Fragment 47
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564993', '1346775491550474240', 'loggingAliyunSls', 'loggingAliyunSls', '/plug/loggingAliyunSls', 'loggingAliyunSls', 1, 0, 'block', 0, 0, '', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 48
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564994', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 49
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564995', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 50
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564996', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 51
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564997', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsSelector:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 52
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564998', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 53
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108564999', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 54
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565000', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 55
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565001', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSlsRule:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 56
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565002', '1534585531108564993', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingAliyunSls:modify', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 57
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172818', '34', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 58
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172819', '34', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 59
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172820', '34', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 60
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507017', '34', 'sampleRate', 'sampleRate', 2, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 61
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507015', '34', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 62
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507016', '34', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}')

-- Fragment 63
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507015', '34', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')
