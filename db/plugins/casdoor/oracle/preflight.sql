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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '39' AND name <> 'casdoor') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'casdoor' AND id <> '39') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1570590990341775360
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570590990341775360' AND NOT (plugin_id = '39' AND field = 'endpoint' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1570590990341775360
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'endpoint' AND type = 3 AND id <> '1570590990341775360') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1570591047635968000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591047635968000' AND NOT (plugin_id = '39' AND field = 'client_id' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1570591047635968000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'client_id' AND type = 3 AND id <> '1570591047635968000') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1570591109623586816
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591109623586816' AND NOT (plugin_id = '39' AND field = 'client_secrect' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1570591109623586816
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'client_secrect' AND type = 3 AND id <> '1570591109623586816') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1570591165374275584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591165374275584' AND NOT (plugin_id = '39' AND field = 'certificate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1570591165374275584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'certificate' AND type = 3 AND id <> '1570591165374275584') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1570591215131303936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591215131303936' AND NOT (plugin_id = '39' AND field = 'organization-name' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1570591215131303936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'organization-name' AND type = 3 AND id <> '1570591215131303936') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1570591265492312064
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1570591265492312064' AND NOT (plugin_id = '39' AND field = 'application-name' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1570591265492312064
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '39' AND field = 'application-name' AND type = 3 AND id <> '1570591265492312064') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- resource id collision: 1792749362361954340
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- resource id collision: 1792749362445840411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840411' AND NOT (id = '1792749362445840411' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- resource parent identity collision: 1792749362445840411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- resource id collision: 1792749362445840412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840412' AND NOT (id = '1792749362445840412' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- resource parent identity collision: 1792749362445840412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- resource id collision: 1792749362445840413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840413' AND NOT (id = '1792749362445840413' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- resource parent identity collision: 1792749362445840413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- resource id collision: 1792749362445840414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840414' AND NOT (id = '1792749362445840414' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- resource parent identity collision: 1792749362445840414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- resource id collision: 1792749362445840415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840415' AND NOT (id = '1792749362445840415' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- resource parent identity collision: 1792749362445840415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- resource id collision: 1792749362445840416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840416' AND NOT (id = '1792749362445840416' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- resource parent identity collision: 1792749362445840416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- resource id collision: 1792749362445840417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840417' AND NOT (id = '1792749362445840417' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- resource parent identity collision: 1792749362445840417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- resource id collision: 1792749362445840418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840418' AND NOT (id = '1792749362445840418' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- resource parent identity collision: 1792749362445840418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- resource id collision: 1792749362445840419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840419' AND NOT (id = '1792749362445840419' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoor:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- resource parent identity collision: 1792749362445840419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- permission id collision: 1792779493537148928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148928' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954340')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- permission natural-key collision: 1792779493537148928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954340' AND id <> '1792779493537148928') THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- permission resource identity collision: 1792779493537148928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954340' AND NOT (id = '1792749362361954340' AND parent_id = '1346775491550474240' AND name = 'casdoor' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- permission id collision: 1792779493537148929
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148929' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840411')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- permission natural-key collision: 1792779493537148929
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840411' AND id <> '1792779493537148929') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- permission resource identity collision: 1792779493537148929
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840411' AND NOT (id = '1792749362445840411' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- permission id collision: 1792779493537148930
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148930' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840412')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- permission natural-key collision: 1792779493537148930
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840412' AND id <> '1792779493537148930') THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- permission resource identity collision: 1792779493537148930
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840412' AND NOT (id = '1792749362445840412' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- permission id collision: 1792779493537148931
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148931' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840413')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- permission natural-key collision: 1792779493537148931
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840413' AND id <> '1792779493537148931') THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- permission resource identity collision: 1792779493537148931
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840413' AND NOT (id = '1792749362445840413' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- permission id collision: 1792779493537148932
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148932' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840414')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- permission natural-key collision: 1792779493537148932
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840414' AND id <> '1792779493537148932') THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- permission resource identity collision: 1792779493537148932
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840414' AND NOT (id = '1792749362445840414' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- permission id collision: 1792779493537148933
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148933' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840415')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- permission natural-key collision: 1792779493537148933
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840415' AND id <> '1792779493537148933') THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- permission resource identity collision: 1792779493537148933
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840415' AND NOT (id = '1792749362445840415' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- permission id collision: 1792779493537148934
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148934' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840416')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- permission natural-key collision: 1792779493537148934
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840416' AND id <> '1792779493537148934') THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission resource identity collision: 1792779493537148934
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840416' AND NOT (id = '1792749362445840416' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission id collision: 1792779493537148935
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148935' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840417')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission natural-key collision: 1792779493537148935
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840417' AND id <> '1792779493537148935') THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission resource identity collision: 1792779493537148935
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840417' AND NOT (id = '1792749362445840417' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission id collision: 1792779493537148936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148936' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840418')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission natural-key collision: 1792779493537148936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840418' AND id <> '1792779493537148936') THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission resource identity collision: 1792779493537148936
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840418' AND NOT (id = '1792749362445840418' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoorRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission id collision: 1792779493537148937
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148937' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840419')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission natural-key collision: 1792779493537148937
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840419' AND id <> '1792779493537148937') THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission resource identity collision: 1792779493537148937
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840419' AND NOT (id = '1792749362445840419' AND parent_id = '1792749362361954340' AND name = '' AND perms = 'plugin:casdoor:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822176' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '39')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '39' AND id <> '1801816010882822176') THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;
