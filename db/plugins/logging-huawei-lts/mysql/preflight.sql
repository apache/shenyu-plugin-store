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

-- Preflight checks for logging-huawei-lts (loggingHuaweiLts).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_huawei_lts$$
CREATE PROCEDURE shenyu_preflight_logging_huawei_lts()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '43' AND name <> 'loggingHuaweiLts') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingHuaweiLts' AND id <> '43') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676472478492946432' AND NOT (plugin_id = '43' AND field = 'projectId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676472478492946432';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'projectId' AND type = 3 AND id <> '1676472478492946432') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676472478492946432';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676473313352380416' AND NOT (plugin_id = '43' AND field = 'logGroupId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676473313352380416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'logGroupId' AND type = 3 AND id <> '1676473313352380416') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676473313352380416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676473453001732096' AND NOT (plugin_id = '43' AND field = 'logStreamId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676473453001732096';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'logStreamId' AND type = 3 AND id <> '1676473453001732096') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676473453001732096';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676473657121730560' AND NOT (plugin_id = '43' AND field = 'accessKeyId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676473657121730560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'accessKeyId' AND type = 3 AND id <> '1676473657121730560') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676473657121730560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676474055324758016' AND NOT (plugin_id = '43' AND field = 'accessKeySecret' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676474055324758016';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'accessKeySecret' AND type = 3 AND id <> '1676474055324758016') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676474055324758016';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676474340008947712' AND NOT (plugin_id = '43' AND field = 'regionName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676474340008947712';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'regionName' AND type = 3 AND id <> '1676474340008947712') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676474340008947712';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676474810655993856' AND NOT (plugin_id = '43' AND field = 'totalSizeInBytes' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676474810655993856';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'totalSizeInBytes' AND type = 3 AND id <> '1676474810655993856') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676474810655993856';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676475051081887744' AND NOT (plugin_id = '43' AND field = 'maxBlockMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676475051081887744';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maxBlockMs' AND type = 3 AND id <> '1676475051081887744') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676475051081887744';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676475293634293760' AND NOT (plugin_id = '43' AND field = 'ioThreadCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676475293634293760';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'ioThreadCount' AND type = 3 AND id <> '1676475293634293760') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676475293634293760';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676475611772252160' AND NOT (plugin_id = '43' AND field = 'batchSizeThresholdInBytes' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676475611772252160';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'batchSizeThresholdInBytes' AND type = 3 AND id <> '1676475611772252160') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676475611772252160';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676475862545494016' AND NOT (plugin_id = '43' AND field = 'batchCountThreshold' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676475862545494016';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'batchCountThreshold' AND type = 3 AND id <> '1676475862545494016') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676475862545494016';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676476047950508032' AND NOT (plugin_id = '43' AND field = 'lingerMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676476047950508032';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'lingerMs' AND type = 3 AND id <> '1676476047950508032') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676476047950508032';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676476207938039808' AND NOT (plugin_id = '43' AND field = 'retries' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676476207938039808';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'retries' AND type = 3 AND id <> '1676476207938039808') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676476207938039808';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676476515359551488' AND NOT (plugin_id = '43' AND field = 'baseRetryBackoffMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676476515359551488';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'baseRetryBackoffMs' AND type = 3 AND id <> '1676476515359551488') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676476515359551488';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676476639779385344' AND NOT (plugin_id = '43' AND field = 'maxRetryBackoffMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676476639779385344';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maxRetryBackoffMs' AND type = 3 AND id <> '1676476639779385344') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676476639779385344';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676477312923234304' AND NOT (plugin_id = '43' AND field = 'enableLocalTest' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676477312923234304';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'enableLocalTest' AND type = 3 AND id <> '1676477312923234304') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676477312923234304';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676477594361032704' AND NOT (plugin_id = '43' AND field = 'setGiveUpExtraLongSingleLog' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676477594361032704';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'setGiveUpExtraLongSingleLog' AND type = 3 AND id <> '1676477594361032704') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676477594361032704';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676477594361032705' AND NOT (plugin_id = '43' AND field = 'keyword' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676477594361032705';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'keyword' AND type = 2 AND id <> '1676477594361032705') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676477594361032705';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676477594361032706' AND NOT (plugin_id = '43' AND field = 'maskType' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676477594361032706';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maskType' AND type = 2 AND id <> '1676477594361032706') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676477594361032706';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1676477594361032707' AND NOT (plugin_id = '43' AND field = 'maskStatus' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1676477594361032707';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maskStatus' AND type = 2 AND id <> '1676477594361032707') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1676477594361032707';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507013' AND NOT (plugin_id = '43' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507013';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507013') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507013';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507014' AND NOT (plugin_id = '43' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507014';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507014') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507014';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945048780800';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278272' AND NOT (id = '1676471945124278272' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278272';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278272';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278273' AND NOT (id = '1676471945124278273' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278273';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278273';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278274' AND NOT (id = '1676471945124278274' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278274';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278274';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278275' AND NOT (id = '1676471945124278275' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278275';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278275';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278276' AND NOT (id = '1676471945124278276' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278276';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278276';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278277' AND NOT (id = '1676471945124278277' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278277';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278277';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278278' AND NOT (id = '1676471945124278278' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278278';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278278';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278279' AND NOT (id = '1676471945124278279' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278279';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278279';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278280' AND NOT (id = '1676471945124278280' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1676471945124278280';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1676471945124278280';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362361954343';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840438' AND NOT (id = '1792749362445840438' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840438';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840438';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840439' AND NOT (id = '1792749362445840439' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840439';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840439';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840440' AND NOT (id = '1792749362445840440' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840440';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840440';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840441' AND NOT (id = '1792749362445840441' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840441';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840441';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840442' AND NOT (id = '1792749362445840442' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840442';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840442';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840443' AND NOT (id = '1792749362445840443' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840443';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840443';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840444' AND NOT (id = '1792749362445840444' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840444';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840444';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840445' AND NOT (id = '1792749362445840445' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840445';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840445';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840446' AND NOT (id = '1792749362445840446' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840446';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840446';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820609' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945048780800')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820609';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945048780800' AND id <> '1572525965658820609') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820609';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820609';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820610' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278272')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820610';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278272' AND id <> '1572525965658820610') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820610';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278272' AND NOT (id = '1676471945124278272' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820610';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820611' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278273')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820611';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278273' AND id <> '1572525965658820611') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820611';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278273' AND NOT (id = '1676471945124278273' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820611';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820612' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278274')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820612';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278274' AND id <> '1572525965658820612') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820612';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278274' AND NOT (id = '1676471945124278274' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820612';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820613' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278275')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820613';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278275' AND id <> '1572525965658820613') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820613';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278275' AND NOT (id = '1676471945124278275' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820613';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820614' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278276')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820614';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278276' AND id <> '1572525965658820614') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820614';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278276' AND NOT (id = '1676471945124278276' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820614';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820615' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278277')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820615';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278277' AND id <> '1572525965658820615') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820615';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278277' AND NOT (id = '1676471945124278277' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820615';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820616' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278278')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820616';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278278' AND id <> '1572525965658820616') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820616';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278278' AND NOT (id = '1676471945124278278' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820616';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820617' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278279')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820617';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278279' AND id <> '1572525965658820617') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820617';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278279' AND NOT (id = '1676471945124278279' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820617';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820618' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278280')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1572525965658820618';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278280' AND id <> '1572525965658820618') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1572525965658820618';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278280' AND NOT (id = '1676471945124278280' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1572525965658820618';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148958' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954343')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148958';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954343' AND id <> '1792779493537148958') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148958';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148958';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148959' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840438')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148959';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840438' AND id <> '1792779493537148959') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148959';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840438' AND NOT (id = '1792749362445840438' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148959';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148960' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840439')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148960';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840439' AND id <> '1792779493537148960') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148960';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840439' AND NOT (id = '1792749362445840439' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148960';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148961' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840440')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148961';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840440' AND id <> '1792779493537148961') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148961';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840440' AND NOT (id = '1792749362445840440' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148961';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148962' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840441')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148962';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840441' AND id <> '1792779493537148962') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148962';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840441' AND NOT (id = '1792749362445840441' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148962';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148963' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840442')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148963';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840442' AND id <> '1792779493537148963') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148963';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840442' AND NOT (id = '1792749362445840442' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148963';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148964' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840443')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148964';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840443' AND id <> '1792779493537148964') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148964';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840443' AND NOT (id = '1792749362445840443' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148964';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148965' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840444')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148965';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840444' AND id <> '1792779493537148965') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148965';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840444' AND NOT (id = '1792749362445840444' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148965';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148966' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840445')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148966';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840445' AND id <> '1792779493537148966') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148966';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840445' AND NOT (id = '1792749362445840445' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148966';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148967' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840446')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148967';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840446' AND id <> '1792779493537148967') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148967';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840446' AND NOT (id = '1792749362445840446' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148967';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822180' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '43')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822180';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '43' AND id <> '1801816010882822180') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822180';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_huawei_lts();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_huawei_lts;
