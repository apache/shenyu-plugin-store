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

-- Preflight checks for logging-aliyun-sls (loggingAliyunSls).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_aliyun_sls$$
CREATE PROCEDURE shenyu_preflight_logging_aliyun_sls()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '34' AND name <> 'loggingAliyunSls') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingAliyunSls' AND id <> '34') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172902' AND NOT (plugin_id = '34' AND field = 'accessId' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172902';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'accessId' AND type = 3 AND id <> '1529402613204172902') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172902';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172903' AND NOT (plugin_id = '34' AND field = 'accessKey' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172903';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'accessKey' AND type = 3 AND id <> '1529402613204172903') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172903';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172904' AND NOT (plugin_id = '34' AND field = 'host' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172904';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'host' AND type = 3 AND id <> '1529402613204172904') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172904';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172905' AND NOT (plugin_id = '34' AND field = 'projectName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172905';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'projectName' AND type = 3 AND id <> '1529402613204172905') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172905';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172906' AND NOT (plugin_id = '34' AND field = 'logStoreName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172906';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'logStoreName' AND type = 3 AND id <> '1529402613204172906') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172906';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172907' AND NOT (plugin_id = '34' AND field = 'topic' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172907';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'topic' AND type = 3 AND id <> '1529402613204172907') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172907';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172908' AND NOT (plugin_id = '34' AND field = 'ttlInDay' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172908';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'ttlInDay' AND type = 3 AND id <> '1529402613204172908') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172908';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172909' AND NOT (plugin_id = '34' AND field = 'shardCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172909';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'shardCount' AND type = 3 AND id <> '1529402613204172909') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172909';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172910' AND NOT (plugin_id = '34' AND field = 'sendThreadCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172910';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sendThreadCount' AND type = 3 AND id <> '1529402613204172910') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172910';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172911' AND NOT (plugin_id = '34' AND field = 'ioThreadCount' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172911';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'ioThreadCount' AND type = 3 AND id <> '1529402613204172911') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172911';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172912' AND NOT (plugin_id = '34' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172912';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sampleRate' AND type = 3 AND id <> '1529402613204172912') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172912';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172913' AND NOT (plugin_id = '34' AND field = 'maxRequestBody' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172913';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maxRequestBody' AND type = 3 AND id <> '1529402613204172913') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172913';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172914' AND NOT (plugin_id = '34' AND field = 'maxResponseBody' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172914';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maxResponseBody' AND type = 3 AND id <> '1529402613204172914') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172914';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172915' AND NOT (plugin_id = '34' AND field = 'bufferQueueSize' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172915';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'bufferQueueSize' AND type = 3 AND id <> '1529402613204172915') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172915';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172758' AND NOT (plugin_id = '34' AND field = 'keyword' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172758';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172758') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172758';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172759' AND NOT (plugin_id = '34' AND field = 'maskType' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172759';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172759') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172759';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172760' AND NOT (plugin_id = '34' AND field = 'maskStatus' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172760';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172760') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172760';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507017' AND NOT (plugin_id = '34' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507017';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507017') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507017';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564993';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564994' AND NOT (id = '1534585531108564994' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564994';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564994';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564995' AND NOT (id = '1534585531108564995' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564995';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564995';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564996' AND NOT (id = '1534585531108564996' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564996';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564996';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564997' AND NOT (id = '1534585531108564997' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564997';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564997';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564998' AND NOT (id = '1534585531108564998' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564998';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564998';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564999' AND NOT (id = '1534585531108564999' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108564999';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108564999';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565000' AND NOT (id = '1534585531108565000' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565000';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565000';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565001' AND NOT (id = '1534585531108565001' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565001';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565001';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565002' AND NOT (id = '1534585531108565002' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSls:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565002';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565002';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583361' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564993')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583361';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564993' AND id <> '1534585531389583361') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583361';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583361';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583362' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564994')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583362';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564994' AND id <> '1534585531389583362') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583362';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564994' AND NOT (id = '1534585531108564994' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583362';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583363' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564995')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583363';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564995' AND id <> '1534585531389583363') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583363';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564995' AND NOT (id = '1534585531108564995' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583363';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583364' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564996')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583364';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564996' AND id <> '1534585531389583364') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583364';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564996' AND NOT (id = '1534585531108564996' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583364';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583365' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564997')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583365';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564997' AND id <> '1534585531389583365') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583365';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564997' AND NOT (id = '1534585531108564997' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583365';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583366' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564998')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583366';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564998' AND id <> '1534585531389583366') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583366';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564998' AND NOT (id = '1534585531108564998' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583366';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583367' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564999')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583367';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564999' AND id <> '1534585531389583367') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583367';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564999' AND NOT (id = '1534585531108564999' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583367';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583368' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565000')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583368';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565000' AND id <> '1534585531389583368') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583368';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565000' AND NOT (id = '1534585531108565000' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583368';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583369' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565001')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583369';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565001' AND id <> '1534585531389583369') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583369';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565001' AND NOT (id = '1534585531108565001' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583369';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583370' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565002')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583370';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565002' AND id <> '1534585531389583370') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583370';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565002' AND NOT (id = '1534585531108565002' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSls:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583370';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822172' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '34')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822172';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '34' AND id <> '1801816010882822172') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822172';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_aliyun_sls();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_aliyun_sls;
