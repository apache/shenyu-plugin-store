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

-- Preflight checks for hystrix (hystrix).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/ob/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_hystrix$$
CREATE PROCEDURE shenyu_preflight_hystrix()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '9' AND name <> 'hystrix') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'hystrix' AND id <> '9') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639284355099';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435654' AND NOT (id = '1529402639372435654' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435654';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435654';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435655' AND NOT (id = '1529402639372435655' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435655';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435655';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435656' AND NOT (id = '1529402639372435656' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435656';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435656';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435657' AND NOT (id = '1529402639372435657' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435657';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435657';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435658' AND NOT (id = '1529402639372435658' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435658';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435658';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435659' AND NOT (id = '1529402639372435659' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435659';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435659';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435660' AND NOT (id = '1529402639372435660' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435660';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435660';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435661' AND NOT (id = '1529402639372435661' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435661';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435661';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435662' AND NOT (id = '1529402639372435662' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrix:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435662';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435662';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326620' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355099')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639305326620';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355099' AND id <> '1529402639305326620') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639305326620';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639305326620';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629888' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435654')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629888';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435654' AND id <> '1529402639376629888') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629888';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435654' AND NOT (id = '1529402639372435654' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629888';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629889' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435655')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629889';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435655' AND id <> '1529402639376629889') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629889';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435655' AND NOT (id = '1529402639372435655' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629889';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629890' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435656')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629890';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435656' AND id <> '1529402639376629890') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629890';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435656' AND NOT (id = '1529402639372435656' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629890';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629891' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435657')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629891';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435657' AND id <> '1529402639376629891') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629891';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435657' AND NOT (id = '1529402639372435657' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629891';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629892' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435658')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629892';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435658' AND id <> '1529402639376629892') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629892';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435658' AND NOT (id = '1529402639372435658' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629892';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629893' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435659')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629893';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435659' AND id <> '1529402639376629893') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629893';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435659' AND NOT (id = '1529402639372435659' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629893';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629894' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435660')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629894';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435660' AND id <> '1529402639376629894') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629894';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435660' AND NOT (id = '1529402639372435660' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629894';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629895' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435661')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629895';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435661' AND id <> '1529402639376629895') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629895';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435661' AND NOT (id = '1529402639372435661' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629895';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629896' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435662')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639376629896';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435662' AND id <> '1529402639376629896') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639376629896';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435662' AND NOT (id = '1529402639372435662' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrix:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639376629896';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822186' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '9')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822186';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '9' AND id <> '1801816010882822186') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822186';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_hystrix();
DROP PROCEDURE IF EXISTS shenyu_preflight_hystrix;
