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

-- Preflight checks for tars (tars).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/ob/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_tars$$
CREATE PROCEDURE shenyu_preflight_tars()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '13' AND name <> 'tars') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'tars' AND id <> '13') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978555' AND NOT (plugin_id = '13' AND field = 'upstreamHost' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978555';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'upstreamHost' AND type = 1 AND id <> '1529402613199978555') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978555';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978556' AND NOT (plugin_id = '13' AND field = 'protocol' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978556';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'protocol' AND type = 1 AND id <> '1529402613199978556') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978556';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978557' AND NOT (plugin_id = '13' AND field = 'upstreamUrl' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978557';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'upstreamUrl' AND type = 1 AND id <> '1529402613199978557') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978557';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978558' AND NOT (plugin_id = '13' AND field = 'weight' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978558';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'weight' AND type = 1 AND id <> '1529402613199978558') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978558';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978559' AND NOT (plugin_id = '13' AND field = 'timestamp' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978559';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'timestamp' AND type = 1 AND id <> '1529402613199978559') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978559';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978560' AND NOT (plugin_id = '13' AND field = 'warmup' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'warmup' AND type = 1 AND id <> '1529402613199978560') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978561' AND NOT (plugin_id = '13' AND field = 'status' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978561';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'status' AND type = 1 AND id <> '1529402613199978561') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978561';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978562' AND NOT (plugin_id = '13' AND field = 'loadBalance' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978562';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'loadBalance' AND type = 2 AND id <> '1529402613199978562') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978562';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978563' AND NOT (plugin_id = '13' AND field = 'retry' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978563';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'retry' AND type = 2 AND id <> '1529402613199978563') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978563';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978564' AND NOT (plugin_id = '13' AND field = 'timeout' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978564';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'timeout' AND type = 2 AND id <> '1529402613199978564') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978564';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978565' AND NOT (plugin_id = '13' AND field = 'multiSelectorHandle' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978565';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'multiSelectorHandle' AND type = 3 AND id <> '1529402613199978565') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978565';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978566' AND NOT (plugin_id = '13' AND field = 'multiRuleHandle' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978566';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'multiRuleHandle' AND type = 3 AND id <> '1529402613199978566') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978566';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172870' AND NOT (plugin_id = '13' AND field = 'corethreads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172870';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'corethreads' AND type = 3 AND id <> '1529402613204172870') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172870';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172871' AND NOT (plugin_id = '13' AND field = 'threads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172871';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'threads' AND type = 3 AND id <> '1529402613204172871') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172871';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172872' AND NOT (plugin_id = '13' AND field = 'queues' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172872';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'queues' AND type = 3 AND id <> '1529402613204172872') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172872';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172873' AND NOT (plugin_id = '13' AND field = 'threadpool' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172873';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'threadpool' AND type = 3 AND id <> '1529402613204172873') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172873';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639284355075';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241188' AND NOT (id = '1529402639368241188' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241188';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241188';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241189' AND NOT (id = '1529402639368241189' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241189';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241189';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241190' AND NOT (id = '1529402639368241190' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241190';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241190';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241191' AND NOT (id = '1529402639368241191' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241191';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241191';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241192' AND NOT (id = '1529402639368241192' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241192';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241192';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241193' AND NOT (id = '1529402639368241193' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241193';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241193';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241194' AND NOT (id = '1529402639368241194' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241194';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241194';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241195' AND NOT (id = '1529402639368241195' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241195';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241195';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241196' AND NOT (id = '1529402639368241196' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tars:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241196';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241196';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326596' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355075')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639305326596';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355075' AND id <> '1529402639305326596') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639305326596';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639305326596';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435699' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241188')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435699';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241188' AND id <> '1529402639372435699') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435699';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241188' AND NOT (id = '1529402639368241188' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435699';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435700' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241189')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435700';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241189' AND id <> '1529402639372435700') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435700';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241189' AND NOT (id = '1529402639368241189' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435700';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435701' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241190')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435701';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241190' AND id <> '1529402639372435701') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435701';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241190' AND NOT (id = '1529402639368241190' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435701';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435702' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241191')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435702';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241191' AND id <> '1529402639372435702') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435702';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241191' AND NOT (id = '1529402639368241191' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435702';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435703' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241192')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435703';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241192' AND id <> '1529402639372435703') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435703';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241192' AND NOT (id = '1529402639368241192' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435703';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435704' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241193')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435704';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241193' AND id <> '1529402639372435704') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435704';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241193' AND NOT (id = '1529402639368241193' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435704';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435705' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241194')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435705';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241194' AND id <> '1529402639372435705') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435705';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241194' AND NOT (id = '1529402639368241194' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435705';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435706' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241195')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435706';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241195' AND id <> '1529402639372435706') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435706';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241195' AND NOT (id = '1529402639368241195' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435706';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435707' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241196')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435707';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241196' AND id <> '1529402639372435707') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435707';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241196' AND NOT (id = '1529402639368241196' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tars:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435707';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822149' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '13')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822149';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '13' AND id <> '1801816010882822149') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822149';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_tars();
DROP PROCEDURE IF EXISTS shenyu_preflight_tars;
