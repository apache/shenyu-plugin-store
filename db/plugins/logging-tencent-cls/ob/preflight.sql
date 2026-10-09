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

-- Preflight checks for logging-tencent-cls (loggingTencentCls).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/ob/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_tencent_cls$$
CREATE PROCEDURE shenyu_preflight_logging_tencent_cls()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '36' AND name <> 'loggingTencentCls') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingTencentCls' AND id <> '36') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172922' AND NOT (plugin_id = '36' AND field = 'secretId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172922';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'secretId' AND type = 3 AND id <> '1529402613204172922') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172922';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172923' AND NOT (plugin_id = '36' AND field = 'secretKey' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172923';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'secretKey' AND type = 3 AND id <> '1529402613204172923') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172923';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172924' AND NOT (plugin_id = '36' AND field = 'endpoint' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172924';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'endpoint' AND type = 3 AND id <> '1529402613204172924') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172924';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172925' AND NOT (plugin_id = '36' AND field = 'topic' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172925';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'topic' AND type = 3 AND id <> '1529402613204172925') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172925';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172926' AND NOT (plugin_id = '36' AND field = 'sendThreadCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172926';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sendThreadCount' AND type = 3 AND id <> '1529402613204172926') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172926';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172927' AND NOT (plugin_id = '36' AND field = 'totalSizeInBytes' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172927';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'totalSizeInBytes' AND type = 3 AND id <> '1529402613204172927') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172927';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172928' AND NOT (plugin_id = '36' AND field = 'maxSendThreadCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxSendThreadCount' AND type = 3 AND id <> '1529402613204172928') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172929' AND NOT (plugin_id = '36' AND field = 'maxBlockSec' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172929';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBlockSec' AND type = 3 AND id <> '1529402613204172929') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172929';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172930' AND NOT (plugin_id = '36' AND field = 'maxBatchSize' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172930';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBatchSize' AND type = 3 AND id <> '1529402613204172930') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172930';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172931' AND NOT (plugin_id = '36' AND field = 'maxBatchCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172931';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBatchCount' AND type = 3 AND id <> '1529402613204172931') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172931';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172932' AND NOT (plugin_id = '36' AND field = 'lingerMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172932';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'lingerMs' AND type = 3 AND id <> '1529402613204172932') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172932';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172933' AND NOT (plugin_id = '36' AND field = 'retries' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172933';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'retries' AND type = 3 AND id <> '1529402613204172933') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172933';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172934' AND NOT (plugin_id = '36' AND field = 'maxReservedAttempts' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172934';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxReservedAttempts' AND type = 3 AND id <> '1529402613204172934') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172934';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172935' AND NOT (plugin_id = '36' AND field = 'baseRetryBackoffMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172935';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'baseRetryBackoffMs' AND type = 3 AND id <> '1529402613204172935') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172935';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172936' AND NOT (plugin_id = '36' AND field = 'maxRetryBackoffMs' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172936';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxRetryBackoffMs' AND type = 3 AND id <> '1529402613204172936') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172936';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172764' AND NOT (plugin_id = '36' AND field = 'keyword' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172764';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172764') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172764';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172765' AND NOT (plugin_id = '36' AND field = 'maskType' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172765';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172765') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172765';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172766' AND NOT (plugin_id = '36' AND field = 'maskStatus' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172766';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172766') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172766';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507015' AND NOT (plugin_id = '36' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507015';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507015') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507015';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507016' AND NOT (plugin_id = '36' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507016';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507016') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507016';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565003';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565004' AND NOT (id = '1534585531108565004' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565004';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565004';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565005' AND NOT (id = '1534585531108565005' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565005';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565005';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565006' AND NOT (id = '1534585531108565006' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565006';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565006';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565007' AND NOT (id = '1534585531108565007' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565007';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565007';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565008' AND NOT (id = '1534585531108565008' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565008';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565008';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565009' AND NOT (id = '1534585531108565009' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565009';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565009';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565010' AND NOT (id = '1534585531108565010' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565010';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565010';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565011' AND NOT (id = '1534585531108565011' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565011';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565011';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565012' AND NOT (id = '1534585531108565012' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentCls:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565012';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565012';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583371' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565003')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583371';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565003' AND id <> '1534585531389583371') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583371';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583371';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583372' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565004')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583372';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565004' AND id <> '1534585531389583372') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583372';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565004' AND NOT (id = '1534585531108565004' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583372';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583373' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565005')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583373';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565005' AND id <> '1534585531389583373') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583373';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565005' AND NOT (id = '1534585531108565005' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583373';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583374' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565006')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583374';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565006' AND id <> '1534585531389583374') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583374';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565006' AND NOT (id = '1534585531108565006' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583374';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583375' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565007')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583375';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565007' AND id <> '1534585531389583375') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583375';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565007' AND NOT (id = '1534585531108565007' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583375';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583376' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565008')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583376';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565008' AND id <> '1534585531389583376') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583376';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565008' AND NOT (id = '1534585531108565008' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583376';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583377' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565009')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583377';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565009' AND id <> '1534585531389583377') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583377';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565009' AND NOT (id = '1534585531108565009' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583377';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583378' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565010')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583378';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565010' AND id <> '1534585531389583378') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583378';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565010' AND NOT (id = '1534585531108565010' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583378';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583379' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565011')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583379';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565011' AND id <> '1534585531389583379') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583379';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565011' AND NOT (id = '1534585531108565011' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583379';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583380' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565012')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583380';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565012' AND id <> '1534585531389583380') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583380';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565012' AND NOT (id = '1534585531108565012' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentCls:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583380';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822174' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '36')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822174';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '36' AND id <> '1801816010882822174') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822174';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_tencent_cls();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_tencent_cls;
