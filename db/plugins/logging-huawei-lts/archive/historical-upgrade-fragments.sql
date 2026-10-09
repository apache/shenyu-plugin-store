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

-- Archive-only historical SQL fragments for logging-huawei-lts.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin` VALUES ('43', 'loggingHuaweiLts', '{\"totalSizeInBytes\":\"104857600\",\"maxBlockMs\":\"0\",\"ioThreadCount\":\"1\",\"batchSizeThresholdInBytes\":\"524288\",\"batchCountThreshold\":\"4096\",\"lingerMs\":\"2000\",\"retries\":\"100\",\"baseRetryBackoffMs\":\"100\",\"maxRetryBackoffMs\":\"100\",\"enableLocalTest\":\"true\",\"setGiveUpExtraLongSingleLog\":\"false\"}', 'Logging', 177, 0, '2023-07-05 14:03:53.686', '2023-07-06 12:42:07.234', NULL)

-- Fragment 2
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676472478492946432', '43', 'projectId', 'projectId', 2, 3, 0, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:06:00.893', '2023-07-07 22:50:00.597')

-- Fragment 3
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676473313352380416', '43', 'logGroupId', 'logGroupId', 2, 3, 1, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:09:19.928', '2023-07-07 22:50:00.606')

-- Fragment 4
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676473453001732096', '43', 'logStreamId', 'logStreamId', 2, 3, 2, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:09:53.224', '2023-07-07 22:50:00.607')

-- Fragment 5
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676473657121730560', '43', 'accessKeyId', 'AccessKey', 2, 3, 4, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:10:41.897', '2023-07-07 22:50:00.608')

-- Fragment 6
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676474055324758016', '43', 'accessKeySecret', 'accessKey', 2, 3, 5, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:12:16.828', '2023-07-07 22:50:00.609')

-- Fragment 7
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676474340008947712', '43', 'regionName', 'regionName', 2, 3, 6, '{\"required\":\"1\",\"rule\":\"\"}', '2023-07-05 14:13:24.703', '2023-07-07 22:50:00.610')

-- Fragment 8
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676474810655993856', '43', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 8, '{\"required\":\"0\",\"defaultValue\":\"104857600\",\"rule\":\"\"}', '2023-07-05 14:15:16.913', '2023-07-07 22:50:00.611')

-- Fragment 9
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676475051081887744', '43', 'maxBlockMs', 'maxBlockMs', 1, 3, 9, '{\"required\":\"0\",\"defaultValue\":\"0\",\"rule\":\"\"}', '2023-07-05 14:16:14.236', '2023-07-07 22:50:00.612')

-- Fragment 10
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676475293634293760', '43', 'ioThreadCount', 'ioThreadCount', 1, 3, 10, '{\"required\":\"0\",\"defaultValue\":\"1\",\"rule\":\"\"}', '2023-07-05 14:17:12.065', '2023-07-07 22:50:00.612')

-- Fragment 11
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676475611772252160', '43', 'batchSizeThresholdInBytes', 'batchSizeThresholdInBytes', 1, 3, 11, '{\"required\":\"0\",\"defaultValue\":\"524288\",\"rule\":\"\"}', '2023-07-05 14:18:27.915', '2023-07-07 22:50:00.614')

-- Fragment 12
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676475862545494016', '43', 'batchCountThreshold', 'batchCountThreshold', 1, 3, 12, '{\"required\":\"0\",\"defaultValue\":\"4096\",\"rule\":\"\"}', '2023-07-05 14:19:27.704', '2023-07-07 22:50:00.615')

-- Fragment 13
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676476047950508032', '43', 'lingerMs', 'lingerMs', 1, 3, 12, '{\"required\":\"0\",\"defaultValue\":\"2000\",\"rule\":\"\"}', '2023-07-05 14:20:11.908', '2023-07-07 22:50:00.616')

-- Fragment 14
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676476207938039808', '43', 'retries', 'retries', 1, 3, 13, '{\"required\":\"0\",\"defaultValue\":\"100\",\"rule\":\"\"}', '2023-07-05 14:20:50.052', '2023-07-07 22:50:00.617')

-- Fragment 15
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676476515359551488', '43', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{\"required\":\"0\",\"defaultValue\":\"100\",\"rule\":\"\"}', '2023-07-05 14:22:03.347', '2023-07-07 22:50:00.618')

-- Fragment 16
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676476639779385344', '43', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{\"required\":\"0\",\"defaultValue\":\"100\",\"rule\":\"\"}', '2023-07-05 14:22:33.010', '2023-07-07 22:50:00.619')

-- Fragment 17
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676477312923234304', '43', 'enableLocalTest', 'enableLocalTest', 2, 3, 15, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}', '2023-07-05 14:25:13.500', '2023-07-07 22:50:00.619')

-- Fragment 18
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676477594361032704', '43', 'setGiveUpExtraLongSingleLog', 'setGiveUpExtraLongSingleLog', 2, 3, 16, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 19
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676477594361032705', '43', 'keyword', 'keyword', 2, 2, 0, '{\"required\":\"0\",\"placeholder\":\"please use ‘;’ to split keyword\",\"rule\":\"\"}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 20
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676477594361032706', '43', 'maskType', 'maskType', 3, 2, 1, '{\"required\":\"0\",\"defaultValue\":\"dataMaskByMD5\",\"rule\":\"\"}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 21
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1676477594361032707', '43', 'maskStatus', 'maskStatus', 3, 2, 2, '{\"required\":\"0\",\"defaultValue\":\"false\",\"rule\":\"\"}','2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 22
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945048780800', '1346775491550474240', 'loggingHuaweiLts', 'loggingHuaweiLts', '/plug/loggingHuaweiLts', 'loggingHuaweiLts', 1, 0, 'block', 0, 0, '', 1, '2023-07-05 14:03:53.699', '2023-07-05 14:03:53.709')

-- Fragment 23
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278272', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:add', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 24
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278273', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:delete', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 25
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278274', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:edit', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 26
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278275', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:query', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 27
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278276', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:add', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 28
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278277', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:delete', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 29
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278278', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:edit', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 30
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278279', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:query', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 31
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `resource` VALUES ('1676471945124278280', '1676471945048780800', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLts:modify', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 32
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin(id)) */ INTO plugin (id, name, role, sort, config, enabled) VALUES ('43', 'loggingHuaweiLts', 'Logging', 177, '{"totalSizeInBytes":"104857600","maxBlockMs":"0","ioThreadCount":"1","batchSizeThresholdInBytes":"524288","batchCountThreshold":"4096","lingerMs":"2000","retries":"100","baseRetryBackoffMs":"100","maxRetryBackoffMs":"100","enableLocalTest":"true","setGiveUpExtraLongSingleLog":"false"}','0')

-- Fragment 33
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172863', '43', 'projectId', 'projectId', 2, 3, 0, '{"required":"1","rule":""}')

-- Fragment 34
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172864', '43', 'logGroupId', 'logGroupId', 2, 3, 1, '{"required":"1","rule":""}')

-- Fragment 35
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172865', '43', 'logStreamId', 'logStreamId', 2, 3, 2, '{"required":"1","rule":""}')

-- Fragment 36
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172866', '43', 'accessKeyId', 'AccessKey', 2, 3, 4, '{"required":"1","placeholder":"accessKeyId","rule":""}')

-- Fragment 37
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172867', '43','accessKeySecret', 'accessKey', 2, 3, 5, '{"required":"1","placeholder":"accessKeySecret","rule":""}')

-- Fragment 38
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172868', '43', 'regionName', 'regionName', 2, 3, 6, '{"required":"1","placeholder":"regionName","rule":""}')

-- Fragment 39
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172869', '43', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 8, '{"required":"0","defaultValue":"104857600","placeholder":"totalSizeInBytes","rule":""}')

-- Fragment 40
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172870', '43', 'maxBlockMs', 'maxBlockMs', 1, 3, 9, '{"required":"0","defaultValue":"0","placeholder":"maxBlockMs","rule":""}')

-- Fragment 41
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172871', '43', 'ioThreadCount', 'ioThreadCount', 1, 3, 10, '{"required":"0","defaultValue":"1","placeholder":"ioThreadCount","rule":""}')

-- Fragment 42
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172872', '43', 'batchSizeThresholdInBytes', 'batchSizeThresholdInBytes', 1, 3, 11, '{"required":"0","defaultValue":"524288","placeholder":" batchSizeThresholdInBytes","rule":""}')

-- Fragment 43
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172873', '43', 'batchCountThreshold', 'batchCountThreshold', 1, 3, 12, '{"required":"0","defaultValue":"4096","placeholder":" batchCountThreshold","rule":""}')

-- Fragment 44
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172874', '43', 'lingerMs', 'lingerMs', 1, 3, 12, '{"required":"0","defaultValue":"2000","placeholder":"lingerMs","rule":""}')

-- Fragment 45
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172875', '43', 'retries', 'retries', 1, 3, 13, '{"required":"0","defaultValue":"100","placeholder":"retries","rule":""}')

-- Fragment 46
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172876', '43', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{"required":"0","defaultValue":"100","placeholder":"baseRetryBackoffMs","rule":""}')

-- Fragment 47
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172877', '43', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{"required":"0","defaultValue":"100","placeholder":"maxRetryBackoffMs","rule":""}')

-- Fragment 48
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172878', '43', 'enableLocalTest', 'enableLocalTest', 2, 3, 15, '{"required":"0","defaultValue":"false","placeholder":"enableLocalTest","rule":""}')

-- Fragment 49
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- VALUES ('1529402613204172879', '43', 'setGiveUpExtraLongSingleLog', 'setGiveUpExtraLongSingleLog', 2, 3, 16, '{"required":"0","defaultValue":"false","placeholder":"setGiveUpExtraLongSingleLog","rule":""}')

-- Fragment 50
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1529402613204172880', '43', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}')

-- Fragment 51
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1529402613204172881', '43', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}')

-- Fragment 52
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1529402613204172882', '43', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}')

-- Fragment 53
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('43', 'loggingHuaweiLts', '{ "totalSizeInBytes": "104857600","maxBlockMs":"0","ioThreadCount":"1","batchSizeThresholdInBytes":"524288","batchCountThreshold":"4096","lingerMs":"2000","retries":"100","baseRetryBackoffMs":"100","maxRetryBackoffMs":"100","enableLocalTest":"true","setGiveUpExtraLongSingleLog":"false"}', 'Logging', 177, 0, '2023-07-05 14:03:53', '2023-07-06 12:42:07', null)

-- Fragment 54
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312065', '43', 'projectId', 'projectId', 2, 3, 0, '{"required":"1","rule":""}', '2023-07-05 14:06:00.893', '2023-07-07 22:50:00.597')

-- Fragment 55
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312066', '43', 'logGroupId', 'logGroupId', 2, 3, 1, '{"required":"1","rule":""}', '2023-07-05 14:09:19.928', '2023-07-07 22:50:00.606')

-- Fragment 56
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312067', '43', 'logStreamId', 'logStreamId', 2, 3, 2, '{"required":"1","rule":""}', '2023-07-05 14:09:53.224', '2023-07-07 22:50:00.607')

-- Fragment 57
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312068', '43', 'accessKeyId', 'AccessKey', 2, 3, 4, '{"required":"1","rule":""}', '2023-07-05 14:10:41.897', '2023-07-07 22:50:00.608')

-- Fragment 58
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312069', '43', 'accessKeySecret', 'accessKey', 2, 3, 5, '{"required":"1","rule":""}', '2023-07-05 14:12:16.828', '2023-07-07 22:50:00.609')

-- Fragment 59
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312070', '43', 'regionName', 'regionName', 2, 3, 6, '{"required":"1","rule":""}', '2023-07-05 14:13:24.703', '2023-07-07 22:50:00.610')

-- Fragment 60
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312071', '43', 'totalSizeInBytes', 'totalSizeInBytes', 1, 3, 8, '{"required":"0","defaultValue":"104857600","rule":""}', '2023-07-05 14:15:16.913', '2023-07-07 22:50:00.611')

-- Fragment 61
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312072', '43', 'maxBlockMs', 'maxBlockMs', 1, 3, 9, '{"required":"0","defaultValue":"0","rule":""}', '2023-07-05 14:16:14.236', '2023-07-07 22:50:00.612')

-- Fragment 62
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312073', '43', 'ioThreadCount', 'ioThreadCount', 1, 3, 10, '{"required":"0","defaultValue":"1","rule":""}', '2023-07-05 14:17:12.065', '2023-07-07 22:50:00.612')

-- Fragment 63
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312074', '43', 'batchSizeThresholdInBytes', 'batchSizeThresholdInBytes', 1, 3, 11, '{"required":"0","defaultValue":"524288","rule":""}', '2023-07-05 14:18:27.915', '2023-07-07 22:50:00.614')

-- Fragment 64
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312075', '43', 'batchCountThreshold', 'batchCountThreshold', 1, 3, 12, '{"required":"0","defaultValue":"4096","rule":""}', '2023-07-05 14:19:27.704', '2023-07-07 22:50:00.615')

-- Fragment 65
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312076', '43', 'lingerMs', 'lingerMs', 1, 3, 12, '{"required":"0","defaultValue":"2000","rule":""}', '2023-07-05 14:20:11.908', '2023-07-07 22:50:00.616')

-- Fragment 66
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312077', '43', 'retries', 'retries', 1, 3, 13, '{"required":"0","defaultValue":"100","rule":""}', '2023-07-05 14:20:50.052', '2023-07-07 22:50:00.617')

-- Fragment 67
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312078', '43', 'baseRetryBackoffMs', 'baseRetryBackoffMs', 1, 3, 14, '{"required":"0","defaultValue":"100","rule":""}', '2023-07-05 14:22:03.347', '2023-07-07 22:50:00.618')

-- Fragment 68
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312079', '43', 'maxRetryBackoffMs', 'maxRetryBackoffMs', 1, 3, 15, '{"required":"0","defaultValue":"100","rule":""}', '2023-07-05 14:22:33.010', '2023-07-07 22:50:00.619')

-- Fragment 69
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312080', '43', 'enableLocalTest', 'enableLocalTest', 2, 3, 15, '{"required":"0","defaultValue":"false","rule":""}', '2023-07-05 14:25:13.500', '2023-07-07 22:50:00.619')

-- Fragment 70
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312081', '43', 'setGiveUpExtraLongSingleLog', 'setGiveUpExtraLongSingleLog', 2, 3, 16, '{"required":"0","defaultValue":"false","rule":""}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 71
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312082', '43', 'keyword', 'keyword', 2, 2, 0, '{"required":"0","placeholder":"please use ‘;’ to split keyword","rule":""}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 72
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312083', '43', 'maskType', 'maskType', 3, 2, 1, '{"required":"0","defaultValue":"dataMaskByMD5","rule":""}', '2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 73
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1570591265492312084', '43', 'maskStatus', 'maskStatus', 3, 2, 2, '{"required":"0","defaultValue":"false","rule":""}','2023-07-05 14:26:20.600', '2023-07-07 22:50:00.620')

-- Fragment 74
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266177', '1346775491550474240', 'loggingHuaweiLts', 'loggingHuaweiLts', '/plug/loggingHuaweiLts', 'loggingHuaweiLts', 1, 0, 'block', 0, 0, '', 1, '2023-07-05 14:03:53.699', '2023-07-05 14:03:53.709')

-- Fragment 75
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266178', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.SELECTOR.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:add', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 76
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266179', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.SELECTOR.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:delete', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 77
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266180', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.SELECTOR.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:edit', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 78
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266181', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.SELECTOR.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsSelector:query', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 79
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266182', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.RULE.ADD', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:add', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 80
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266183', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.RULE.DELETE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:delete', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 81
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266184', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.RULE.EDIT', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:edit', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 82
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266185', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.RULE.QUERY', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLtsRule:query', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 83
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."resource" VALUES ('1572525965625266186', '1572525965625266177', 'SHENYU.BUTTON.PLUGIN.SYNCHRONIZE', '', '', '', 2, 0, '', 1, 0, 'plugin:loggingHuaweiLts:modify', 1, '2023-07-05 14:03:53.721', '2023-07-05 14:03:53.721')

-- Fragment 84
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507013', '43', 'sampleRate', 'sampleRate', 2, 3, 17, '{\"required\":\"0\",\"defaultValue\":\"1\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 85
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507014', '43', 'sampleRate', 'sampleRate', 2, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 86
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507011', '43', 'sampleRate', 'sampleRate', 2, 3, 17, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 87
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507012', '43', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 88
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507012', '43', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}')

-- Fragment 89
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507013', '43', 'sampleRate', 'sampleRate', 2, 3, 17, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}')

-- Fragment 90
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507011', '43', 'sampleRate', 'sampleRate', 2, 3, 17, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 91
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507012', '43', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')
