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

-- Preflight checks for sofa (sofa).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_sofa$$
CREATE PROCEDURE shenyu_preflight_sofa()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '11' AND name <> 'sofa') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'sofa' AND id <> '11') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978534' AND NOT (plugin_id = '11' AND field = 'protocol' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978534';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'protocol' AND type = 3 AND id <> '1529402613199978534') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978534';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978535' AND NOT (plugin_id = '11' AND field = 'register' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613199978535';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'register' AND type = 3 AND id <> '1529402613199978535') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613199978535';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1729402613199978534' AND NOT (plugin_id = '11' AND field = 'protocol' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1729402613199978534';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'protocol' AND type = 1 AND id <> '1729402613199978534') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1729402613199978534';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1729402613199978535' AND NOT (plugin_id = '11' AND field = 'register' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1729402613199978535';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'register' AND type = 1 AND id <> '1729402613199978535') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1729402613199978535';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172874' AND NOT (plugin_id = '11' AND field = 'corethreads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172874';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'corethreads' AND type = 3 AND id <> '1529402613204172874') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172874';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172875' AND NOT (plugin_id = '11' AND field = 'threads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172875';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'threads' AND type = 3 AND id <> '1529402613204172875') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172875';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172876' AND NOT (plugin_id = '11' AND field = 'queues' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172876';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'queues' AND type = 3 AND id <> '1529402613204172876') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172876';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172877' AND NOT (plugin_id = '11' AND field = 'threadpool' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172877';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'threadpool' AND type = 3 AND id <> '1529402613204172877') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172877';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639284355073';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241170' AND NOT (id = '1529402639368241170' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241170';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241170';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241171' AND NOT (id = '1529402639368241171' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241171';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241171';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241172' AND NOT (id = '1529402639368241172' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241172';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241172';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241173' AND NOT (id = '1529402639368241173' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241173';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241173';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241174' AND NOT (id = '1529402639368241174' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241174';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241174';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241175' AND NOT (id = '1529402639368241175' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241175';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241175';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241176' AND NOT (id = '1529402639368241176' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241176';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241176';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241177' AND NOT (id = '1529402639368241177' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241177';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241177';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241178' AND NOT (id = '1529402639368241178' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofa:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639368241178';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639368241178';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326594' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355073')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639305326594';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355073' AND id <> '1529402639305326594') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639305326594';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639305326594';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435681' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241170')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435681';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241170' AND id <> '1529402639372435681') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435681';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241170' AND NOT (id = '1529402639368241170' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435681';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435682' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241171')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435682';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241171' AND id <> '1529402639372435682') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435682';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241171' AND NOT (id = '1529402639368241171' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435682';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435683' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241172')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435683';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241172' AND id <> '1529402639372435683') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435683';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241172' AND NOT (id = '1529402639368241172' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435683';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435684' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241173')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435684';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241173' AND id <> '1529402639372435684') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435684';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241173' AND NOT (id = '1529402639368241173' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435684';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435685' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241174')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435685';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241174' AND id <> '1529402639372435685') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435685';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241174' AND NOT (id = '1529402639368241174' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435685';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435686' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241175')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435686';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241175' AND id <> '1529402639372435686') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435686';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241175' AND NOT (id = '1529402639368241175' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435686';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435687' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241176')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435687';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241176' AND id <> '1529402639372435687') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435687';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241176' AND NOT (id = '1529402639368241176' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435687';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435688' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241177')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435688';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241177' AND id <> '1529402639372435688') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435688';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241177' AND NOT (id = '1529402639368241177' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435688';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435689' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241178')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435689';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241178' AND id <> '1529402639372435689') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435689';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241178' AND NOT (id = '1529402639368241178' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofa:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435689';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822147' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '11')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822147';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '11' AND id <> '1801816010882822147') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822147';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_sofa();
DROP PROCEDURE IF EXISTS shenyu_preflight_sofa;
