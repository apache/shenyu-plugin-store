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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/pg/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '39' AND "name" <> 'casdoor') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'casdoor' AND "id" <> '39') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1570590990341775360
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570590990341775360' AND NOT ("plugin_id" = '39' AND "field" = 'endpoint' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1570590990341775360
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'endpoint' AND "type" = 3 AND "id" <> '1570590990341775360') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1570591047635968000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591047635968000' AND NOT ("plugin_id" = '39' AND "field" = 'client_id' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1570591047635968000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'client_id' AND "type" = 3 AND "id" <> '1570591047635968000') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1570591109623586816
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591109623586816' AND NOT ("plugin_id" = '39' AND "field" = 'client_secrect' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1570591109623586816
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'client_secrect' AND "type" = 3 AND "id" <> '1570591109623586816') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1570591165374275584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591165374275584' AND NOT ("plugin_id" = '39' AND "field" = 'certificate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1570591165374275584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'certificate' AND "type" = 3 AND "id" <> '1570591165374275584') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1570591215131303936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591215131303936' AND NOT ("plugin_id" = '39' AND "field" = 'organization-name' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1570591215131303936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'organization-name' AND "type" = 3 AND "id" <> '1570591215131303936') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1570591265492312064
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312064' AND NOT ("plugin_id" = '39' AND "field" = 'application-name' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1570591265492312064
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '39' AND "field" = 'application-name' AND "type" = 3 AND "id" <> '1570591265492312064') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- resource id collision: 1792749362361954340
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- resource id collision: 1792749362445840411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840411' AND NOT ("id" = '1792749362445840411' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- resource parent identity collision: 1792749362445840411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- resource id collision: 1792749362445840412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840412' AND NOT ("id" = '1792749362445840412' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- resource parent identity collision: 1792749362445840412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- resource id collision: 1792749362445840413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840413' AND NOT ("id" = '1792749362445840413' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- resource parent identity collision: 1792749362445840413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- resource id collision: 1792749362445840414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840414' AND NOT ("id" = '1792749362445840414' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- resource parent identity collision: 1792749362445840414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- resource id collision: 1792749362445840415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840415' AND NOT ("id" = '1792749362445840415' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- resource parent identity collision: 1792749362445840415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- resource id collision: 1792749362445840416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840416' AND NOT ("id" = '1792749362445840416' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- resource parent identity collision: 1792749362445840416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- resource id collision: 1792749362445840417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840417' AND NOT ("id" = '1792749362445840417' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- resource parent identity collision: 1792749362445840417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- resource id collision: 1792749362445840418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840418' AND NOT ("id" = '1792749362445840418' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- resource parent identity collision: 1792749362445840418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- resource id collision: 1792749362445840419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840419' AND NOT ("id" = '1792749362445840419' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoor:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- resource parent identity collision: 1792749362445840419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- permission id collision: 1792793304205819904
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304205819904' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362361954340')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- permission natural-key collision: 1792793304205819904
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362361954340' AND "id" <> '1792793304205819904') THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- permission resource identity collision: 1792793304205819904
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362361954340' AND NOT ("id" = '1792749362361954340' AND "parent_id" = '1346775491550474240' AND "name" = 'casdoor' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- permission id collision: 1792793304205819905
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304205819905' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840411')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- permission natural-key collision: 1792793304205819905
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840411' AND "id" <> '1792793304205819905') THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- permission resource identity collision: 1792793304205819905
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840411' AND NOT ("id" = '1792749362445840411' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- permission id collision: 1792793304205819906
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304205819906' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840412')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- permission natural-key collision: 1792793304205819906
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840412' AND "id" <> '1792793304205819906') THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- permission resource identity collision: 1792793304205819906
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840412' AND NOT ("id" = '1792749362445840412' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- permission id collision: 1792793304210014208
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014208' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840413')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- permission natural-key collision: 1792793304210014208
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840413' AND "id" <> '1792793304210014208') THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- permission resource identity collision: 1792793304210014208
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840413' AND NOT ("id" = '1792749362445840413' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- permission id collision: 1792793304210014209
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014209' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840414')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- permission natural-key collision: 1792793304210014209
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840414' AND "id" <> '1792793304210014209') THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- permission resource identity collision: 1792793304210014209
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840414' AND NOT ("id" = '1792749362445840414' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- permission id collision: 1792793304210014210
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014210' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840415')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- permission natural-key collision: 1792793304210014210
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840415' AND "id" <> '1792793304210014210') THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- permission resource identity collision: 1792793304210014210
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840415' AND NOT ("id" = '1792749362445840415' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- permission id collision: 1792793304210014211
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014211' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840416')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- permission natural-key collision: 1792793304210014211
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840416' AND "id" <> '1792793304210014211') THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission resource identity collision: 1792793304210014211
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840416' AND NOT ("id" = '1792749362445840416' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission id collision: 1792793304210014212
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014212' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840417')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission natural-key collision: 1792793304210014212
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840417' AND "id" <> '1792793304210014212') THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission resource identity collision: 1792793304210014212
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840417' AND NOT ("id" = '1792749362445840417' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission id collision: 1792793304210014213
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014213' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840418')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission natural-key collision: 1792793304210014213
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840418' AND "id" <> '1792793304210014213') THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission resource identity collision: 1792793304210014213
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840418' AND NOT ("id" = '1792749362445840418' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoorRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission id collision: 1792793304210014214
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1792793304210014214' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840419')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission natural-key collision: 1792793304210014214
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1792749362445840419' AND "id" <> '1792793304210014214') THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission resource identity collision: 1792793304210014214
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1792749362445840419' AND NOT ("id" = '1792749362445840419' AND "parent_id" = '1792749362361954340' AND "name" = '' AND "perms" = 'plugin:casdoor:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- namespace_plugin_rel id collision: 1801816010882822176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822176' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '39')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- namespace_plugin_rel natural-key collision: 1801816010882822176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '39' AND "id" <> '1801816010882822176') THEN 0 ELSE 1 END AS shenyu_preflight_check_65;
