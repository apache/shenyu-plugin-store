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

-- Archive-only historical SQL fragments for logging-tencent-cls.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin` VALUES ('36', 'loggingTencentCls','{\"endpoint\": \"ap-guangzhou.cls.tencentcs.com\", \"topic\": \"shenyu-topic\"}', 'Logging', 176, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 2
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172922', '36', 'secretId', 'secretId', 2, 3, 1, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 3
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172923', '36', 'secretKey', 'secretKey', 2, 3, 2, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 4
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172924', '36', 'endpoint', 'endpoint', 2, 3, 3, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 5
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172925', '36', 'topic', 'topic', 2, 3, 4, '{\"required\":\"1\",\"defaultValue\":\"\",\"placeholder\":\"\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 6
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172926', '36', 'sendThreadCount', 'sendThreadCount', 1, 3, 5, '{\"required\":\"0\",\"defaultValue\":1,\"placeholder\":\"1-500\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 7
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172927', '36', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 6, '{\"required\":\"0\",\"defaultValue\":104857600}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 8
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172928', '36', 'maxSendThreadCount', 'maxSendThreadCount', 1, 3, 7, '{\"required\":\"0\",\"defaultValue\":1,\"placeholder\":\"availableProcessors + 1\"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 9
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172929', '36', 'maxBlockSec', 'maxBlockSec', 1, 3, 8, '{\"required\":\"0\",\"defaultValue\":60000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 10
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172930', '36', 'maxBatchSize', 'maxBatchSize', 1, 3, 9, '{\"required\":\"0\",\"defaultValue\":524288}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 11
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172931', '36', 'maxBatchCount', 'maxBatchCount', 1, 3, 10, '{\"required\":\"0\",\"defaultValue\":4096}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 12
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172932', '36', 'lingerMs', 'lingerMs', 1, 3, 11, '{\"required\":\"0\",\"defaultValue\":2000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 13
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172933', '36', 'retries', 'retries', 1, 3, 12, '{\"required\":\"0\",\"defaultValue\":10}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 14
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172934', '36', 'maxReservedAttempts', 'maxReservedAttempts', 1, 3, 13, '{\"required\":\"0\",\"defaultValue\":11}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 15
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172935', '36', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{\"required\":\"0\",\"defaultValue\":100}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 16
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172936', '36', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{\"required\":\"0\",\"defaultValue\":50000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 17
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565003', '1346775491550474240', 'loggingTencentCls', 'loggingTencentCls', '/plug/loggingTencentCls', 'loggingTencentCls', 1, 0, 'pic-center', 0, 0, '', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 18
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565004', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 19
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565005', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 20
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565006', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 21
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565007', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 22
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565008', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:add', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 23
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565009', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:query', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 24
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565010', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:edit', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 25
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565011', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:delete', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 26
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `resource` VALUES ('1534585531108565012', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentCls:modify', 1, '2022-05-25 18:02:58', '2022-05-25 18:02:58')

-- Fragment 27
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172764', '36', 'keyword', 'keyword', 2, 2, 0, '{\"required\":\"0\",\"placeholder\":\"please use ‘;’ to split keyword\",\"rule\":\"\"}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 28
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172765', '36', 'maskType', 'maskType', 3, 2, 1, '{\"required\":\"0\",\"defaultValue\":\"dataMaskByMD5\",\"rule\":\"\"}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 29
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1529402613204172766', '36', 'maskStatus', 'maskStatus', 3, 2, 2, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 30
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-mysql.sql
-- -- insert loggingTencentCls plugin

-- Fragment 31
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin(id)) */ INTO plugin (id, name, config, role, sort, enabled) VALUES ('36', 'loggingTencentCls', '{"endpoint": "ap-guangzhou.cls.tencentcs.com", "topic": "shenyu-topic"}', 'Logging', 176, '0')

-- Fragment 32
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468207', '36', 'secretId', 'secretId', 2, 3, 1, '{"required":"1","defaultValue":"","placeholder":""}')

-- Fragment 33
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468208', '36', 'secretKey', 'secretKey', 2, 3, 2, '{"required":"1","defaultValue":"","placeholder":""}')

-- Fragment 34
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468209', '36', 'endpoint', 'endpoint', 2, 3, 3, '{"required":"1","defaultValue":"","placeholder":""}')

-- Fragment 35
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468210', '36', 'topic', 'topic', 2, 3, 4, '{"required":"1","defaultValue":"","placeholder":""}')

-- Fragment 36
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468211', '36', 'sendThreadCount', 'sendThreadCount', 1, 3, 5, '{"required":"0","defaultValue":1,"placeholder":"1-500"}')

-- Fragment 37
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468212', '36', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 6, '{"required":"0","defaultValue":104857600}')

-- Fragment 38
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468213', '36', 'maxSendThreadCount', 'maxSendThreadCount', 1, 3, 7, '{"required":"0","defaultValue":1,"placeholder":"availableProcessors + 1"}')

-- Fragment 39
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468214', '36', 'maxBlockSec', 'maxBlockSec', 1, 3, 8, '{"required":"0","defaultValue":60000}')

-- Fragment 40
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468215', '36', 'maxBatchSize', 'maxBatchSize', 1, 3, 9, '{"required":"0","defaultValue":524288}')

-- Fragment 41
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468216', '36', 'maxBatchCount', 'maxBatchCount', 1, 3, 10, '{"required":"0","defaultValue":4096}')

-- Fragment 42
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468217', '36', 'lingerMs', 'lingerMs', 1, 3, 11, '{"required":"0","defaultValue":2000}')

-- Fragment 43
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468218', '36', 'retries', 'retries', 1, 3, 12, '{"required":"0","defaultValue":10}')

-- Fragment 44
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468219', '36', 'maxReservedAttempts', 'maxReservedAttempts', 1, 3, 13, '{"required":"0","defaultValue":11}')

-- Fragment 45
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468220', '36', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{"required":"0","defaultValue":100}')

-- Fragment 46
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468221', '36', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{"required":"0","defaultValue":50000}')

-- Fragment 47
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468249', '36', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}')

-- Fragment 48
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468250', '36', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}')

-- Fragment 49
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1518229897214468251', '36', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}')

-- Fragment 50
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- -- insert loggingTencentCls plugin start

-- Fragment 51
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- -- insert loggingTencentCls plugin End

-- Fragment 52
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('36', 'loggingTencentCls', '{"endpoint": "ap-guangzhou.cls.tencentcs.com", "topic": "shenyu-topic"}', 'Logging', 176, 0, '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 53
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524982', '36', 'secretId', 'secretId', 2, 3, 1, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 54
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524983', '36', 'secretKey', 'secretKey', 2, 3, 2, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 55
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524984', '36', 'endpoint', 'endpoint', 2, 3, 3, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 56
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524985', '36', 'topic', 'topic', 2, 3, 4, '{"required":"1","defaultValue":"","placeholder":""}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 57
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524986', '36', 'sendThreadCount', 'sendThreadCount', 1, 3, 5, '{"required":"0","defaultValue":1,"placeholder":"1-500"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 58
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524987', '36', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 6, '{"required":"0","defaultValue":104857600}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 59
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524988', '36', 'maxSendThreadCount', 'maxSendThreadCount', 1, 3, 7, '{"required":"0","defaultValue":1,"placeholder":"availableProcessors + 1"}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 60
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524989', '36', 'maxBlockSec', 'maxBlockSec', 1, 3, 8, '{"required":"0","defaultValue":60000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 61
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524990', '36', 'maxBatchSize', 'maxBatchSize', 1, 3, 9, '{"required":"0","defaultValue":524288}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 62
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524991', '36', 'maxBatchCount', 'maxBatchCount', 1, 3, 10, '{"required":"0","defaultValue":4096}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 63
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524992', '36', 'lingerMs', 'lingerMs', 1, 3, 11, '{"required":"0","defaultValue":2000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 64
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524993', '36', 'retries', 'retries', 1, 3, 12, '{"required":"0","defaultValue":10}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 65
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524994', '36', 'maxReservedAttempts', 'maxReservedAttempts', 1, 3, 13, '{"required":"0","defaultValue":11}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 66
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524995', '36', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{"required":"0","defaultValue":100}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 67
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529403902783524996', '36', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{"required":"0","defaultValue":50000}', '2022-06-30 21:00:00', '2022-06-30 21:00:00')

-- Fragment 68
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565003', '1346775491550474240', 'loggingTencentCls', 'loggingTencentCls', '/plug/loggingTencentCls', 'loggingTencentCls', 1, 0, 'block', 0, 0, '', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 69
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565004', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 70
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565005', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 71
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565006', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 72
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565007', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsSelector:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 73
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565008', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:add', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 74
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565009', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:query', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 75
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565010', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:edit', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 76
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565011', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentClsRule:delete', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 77
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1534585531108565012', '1534585531108565003', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingTencentCls:modify', 1, '2022-05-25 18:08:07', '2022-05-25 18:08:07')

-- Fragment 78
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172824', '36', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}', '2022-09-22 00:15:56.158', '2022-09-22 00:23:36.169')

-- Fragment 79
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172825', '36', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}', '2022-09-22 00:16:27.342', '2022-09-22 00:16:27.342')

-- Fragment 80
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1529402613204172826', '36', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}', '2022-09-22 00:17:21.150', '2022-09-22 00:17:21.150')

-- Fragment 81
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-pg.sql
-- -- insert loggingTencentCls plugin

-- Fragment 82
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507015', '36', 'sampleRate', 'sampleRate', 2, 3, 16, '{\"required\":\"0\",\"defaultValue\":\"1\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 83
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507016', '36', 'sampleRate', 'sampleRate', 2, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 84
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507013', '36', 'sampleRate', 'sampleRate', 2, 3, 16, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 85
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507014', '36', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 86
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507017', '36', 'sampleRate', 'sampleRate', 2, 3, 11, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 87
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507018', '36', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 88
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507014', '36', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}')

-- Fragment 89
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507015', '36', 'sampleRate', 'sampleRate', 2, 3, 16, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}')

-- Fragment 90
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507013', '36', 'sampleRate', 'sampleRate', 2, 3, 16, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 91
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507014', '36', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')
