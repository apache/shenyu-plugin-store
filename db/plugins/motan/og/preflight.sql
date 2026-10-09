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

-- Preflight checks for motan (motan).
-- Source: apache/shenyu c8961528b72a2a7f81f0d1cd7525af1659a670bc:db/init/og/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '17' AND "name" <> 'motan') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'motan' AND "id" <> '17') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902783524879
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524879' AND NOT ("plugin_id" = '17' AND "field" = 'registerProtocol' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902783524879
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'registerProtocol' AND "type" = 3 AND "id" <> '1529403902783524879') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1678997557628272641
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1678997557628272641' AND NOT ("plugin_id" = '17' AND "field" = 'registerAddress' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1678997557628272641
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'registerAddress' AND "type" = 3 AND "id" <> '1678997557628272641') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902783524880
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524880' AND NOT ("plugin_id" = '17' AND "field" = 'corethreads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902783524880
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'corethreads' AND "type" = 3 AND "id" <> '1529403902783524880') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529403902783524881
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524881' AND NOT ("plugin_id" = '17' AND "field" = 'threads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529403902783524881
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'threads' AND "type" = 3 AND "id" <> '1529403902783524881') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902783524882
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524882' AND NOT ("plugin_id" = '17' AND "field" = 'queues' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902783524882
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'queues' AND "type" = 3 AND "id" <> '1529403902783524882') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902783524883
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524883' AND NOT ("plugin_id" = '17' AND "field" = 'threadpool' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902783524883
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'threadpool' AND "type" = 3 AND "id" <> '1529403902783524883') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1829402613204172834
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1829402613204172834' AND NOT ("plugin_id" = '17' AND "field" = 'registerProtocol' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1829402613204172834
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'registerProtocol' AND "type" = 1 AND "id" <> '1829402613204172834') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1878997557628272641
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1878997557628272641' AND NOT ("plugin_id" = '17' AND "field" = 'registerAddress' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1878997557628272641
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '17' AND "field" = 'registerAddress' AND "type" = 1 AND "id" <> '1878997557628272641') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- resource id collision: 1529403932781187079
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- resource id collision: 1529403932877656136
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656136' AND NOT ("id" = '1529403932877656136' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- resource parent identity collision: 1529403932877656136
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- resource id collision: 1529403932877656137
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656137' AND NOT ("id" = '1529403932877656137' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- resource parent identity collision: 1529403932877656137
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- resource id collision: 1529403932877656138
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656138' AND NOT ("id" = '1529403932877656138' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- resource parent identity collision: 1529403932877656138
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- resource id collision: 1529403932877656139
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656139' AND NOT ("id" = '1529403932877656139' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- resource parent identity collision: 1529403932877656139
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- resource id collision: 1529403932877656140
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656140' AND NOT ("id" = '1529403932877656140' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- resource parent identity collision: 1529403932877656140
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- resource id collision: 1529403932877656141
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656141' AND NOT ("id" = '1529403932877656141' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- resource parent identity collision: 1529403932877656141
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- resource id collision: 1529403932877656142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656142' AND NOT ("id" = '1529403932877656142' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- resource parent identity collision: 1529403932877656142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- resource id collision: 1529403932877656143
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656143' AND NOT ("id" = '1529403932877656143' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- resource parent identity collision: 1529403932877656143
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- resource id collision: 1529403932877656144
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656144' AND NOT ("id" = '1529403932877656144' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motan:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- resource parent identity collision: 1529403932877656144
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- permission id collision: 1529403932797964296
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932797964296' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187079')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- permission natural-key collision: 1529403932797964296
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187079' AND "id" <> '1529403932797964296') THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- permission resource identity collision: 1529403932797964296
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187079' AND NOT ("id" = '1529403932781187079' AND "parent_id" = '1346775491550474240' AND "name" = 'motan' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- permission id collision: 1529403932881850584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850584' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656136')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- permission natural-key collision: 1529403932881850584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656136' AND "id" <> '1529403932881850584') THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- permission resource identity collision: 1529403932881850584
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656136' AND NOT ("id" = '1529403932877656136' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- permission id collision: 1529403932881850585
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850585' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656137')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- permission natural-key collision: 1529403932881850585
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656137' AND "id" <> '1529403932881850585') THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- permission resource identity collision: 1529403932881850585
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656137' AND NOT ("id" = '1529403932877656137' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- permission id collision: 1529403932881850586
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850586' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656138')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- permission natural-key collision: 1529403932881850586
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656138' AND "id" <> '1529403932881850586') THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- permission resource identity collision: 1529403932881850586
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656138' AND NOT ("id" = '1529403932877656138' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- permission id collision: 1529403932881850587
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850587' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656139')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- permission natural-key collision: 1529403932881850587
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656139' AND "id" <> '1529403932881850587') THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- permission resource identity collision: 1529403932881850587
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656139' AND NOT ("id" = '1529403932877656139' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- permission id collision: 1529403932881850588
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850588' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656140')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission natural-key collision: 1529403932881850588
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656140' AND "id" <> '1529403932881850588') THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission resource identity collision: 1529403932881850588
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656140' AND NOT ("id" = '1529403932877656140' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission id collision: 1529403932881850589
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850589' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656141')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission natural-key collision: 1529403932881850589
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656141' AND "id" <> '1529403932881850589') THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission resource identity collision: 1529403932881850589
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656141' AND NOT ("id" = '1529403932877656141' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission id collision: 1529403932881850590
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850590' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656142')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission natural-key collision: 1529403932881850590
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656142' AND "id" <> '1529403932881850590') THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission resource identity collision: 1529403932881850590
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656142' AND NOT ("id" = '1529403932877656142' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission id collision: 1529403932881850591
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850591' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656143')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission natural-key collision: 1529403932881850591
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656143' AND "id" <> '1529403932881850591') THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission resource identity collision: 1529403932881850591
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656143' AND NOT ("id" = '1529403932877656143' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motanRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission id collision: 1529403932881850592
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850592' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656144')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission natural-key collision: 1529403932881850592
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656144' AND "id" <> '1529403932881850592') THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission resource identity collision: 1529403932881850592
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656144' AND NOT ("id" = '1529403932877656144' AND "parent_id" = '1529403932781187079' AND "name" = '' AND "perms" = 'plugin:motan:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- namespace_plugin_rel id collision: 1801816010882822153
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822153' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '17')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- namespace_plugin_rel natural-key collision: 1801816010882822153
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '17' AND "id" <> '1801816010882822153') THEN 0 ELSE 1 END AS shenyu_preflight_check_69;
