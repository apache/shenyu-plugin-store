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

-- Preflight checks for casdoor (casdoor).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_casdoor$$
CREATE PROCEDURE shenyu_preflight_casdoor()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '39' AND name <> 'casdoor') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'casdoor' AND id <> '39') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570590990341775360' AND NOT (plugin_id = '39' AND field = 'endpoint' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570590990341775360';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'endpoint' AND type = 3 AND id <> '1570590990341775360') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570590990341775360';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591047635968000' AND NOT (plugin_id = '39' AND field = 'client_id' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570591047635968000';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'client_id' AND type = 3 AND id <> '1570591047635968000') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570591047635968000';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591109623586816' AND NOT (plugin_id = '39' AND field = 'client_secrect' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570591109623586816';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'client_secrect' AND type = 3 AND id <> '1570591109623586816') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570591109623586816';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591165374275584' AND NOT (plugin_id = '39' AND field = 'certificate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570591165374275584';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'certificate' AND type = 3 AND id <> '1570591165374275584') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570591165374275584';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591215131303936' AND NOT (plugin_id = '39' AND field = 'organization-name' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570591215131303936';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'organization-name' AND type = 3 AND id <> '1570591215131303936') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570591215131303936';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591265492312064' AND NOT (plugin_id = '39' AND field = 'application-name' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1570591265492312064';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'application-name' AND type = 3 AND id <> '1570591265492312064') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1570591265492312064';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362361954340';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840411' AND NOT (id = '1792749362445840411' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840411';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840411';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840412' AND NOT (id = '1792749362445840412' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840412';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840412';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840413' AND NOT (id = '1792749362445840413' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840413';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840413';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840414' AND NOT (id = '1792749362445840414' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840414';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840414';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840415' AND NOT (id = '1792749362445840415' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840415';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840415';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840416' AND NOT (id = '1792749362445840416' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840416';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840416';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840417' AND NOT (id = '1792749362445840417' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840417';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840417';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840418' AND NOT (id = '1792749362445840418' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840418';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840418';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840419' AND NOT (id = '1792749362445840419' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoor:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840419';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840419';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148928' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954340')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148928';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954340' AND id <> '1792779493537148928') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148928';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148928';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148929' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840411')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148929';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840411' AND id <> '1792779493537148929') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148929';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840411' AND NOT (id = '1792749362445840411' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148929';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148930' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840412')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148930';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840412' AND id <> '1792779493537148930') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148930';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840412' AND NOT (id = '1792749362445840412' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148930';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148931' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840413')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148931';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840413' AND id <> '1792779493537148931') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148931';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840413' AND NOT (id = '1792749362445840413' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148931';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148932' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840414')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148932';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840414' AND id <> '1792779493537148932') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148932';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840414' AND NOT (id = '1792749362445840414' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148932';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148933' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840415')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148933';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840415' AND id <> '1792779493537148933') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148933';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840415' AND NOT (id = '1792749362445840415' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148933';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148934' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840416')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148934';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840416' AND id <> '1792779493537148934') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148934';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840416' AND NOT (id = '1792749362445840416' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148934';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148935' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840417')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148935';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840417' AND id <> '1792779493537148935') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148935';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840417' AND NOT (id = '1792749362445840417' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148935';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148936' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840418')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148936';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840418' AND id <> '1792779493537148936') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148936';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840418' AND NOT (id = '1792749362445840418' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148936';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148937' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840419')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493537148937';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840419' AND id <> '1792779493537148937') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493537148937';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840419' AND NOT (id = '1792749362445840419' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoor:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493537148937';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822176' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '39')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822176';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '39' AND id <> '1801816010882822176') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822176';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_casdoor();
DROP PROCEDURE IF EXISTS shenyu_preflight_casdoor;
