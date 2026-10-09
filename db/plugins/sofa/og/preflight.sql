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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/og/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '11' AND "name" <> 'sofa') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'sofa' AND "id" <> '11') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902775136289
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902775136289' AND NOT ("plugin_id" = '11' AND "field" = 'protocol' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902775136289
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'protocol' AND "type" = 3 AND "id" <> '1529403902775136289') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902775136290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902775136290' AND NOT ("plugin_id" = '11' AND "field" = 'register' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902775136290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'register' AND "type" = 3 AND "id" <> '1529403902775136290') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1729403902775136289
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1729403902775136289' AND NOT ("plugin_id" = '11' AND "field" = 'protocol' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1729403902775136289
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'protocol' AND "type" = 1 AND "id" <> '1729403902775136289') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1729403902775136290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1729403902775136290' AND NOT ("plugin_id" = '11' AND "field" = 'register' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1729403902775136290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'register' AND "type" = 1 AND "id" <> '1729403902775136290') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902783524917
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524917' AND NOT ("plugin_id" = '11' AND "field" = 'corethreads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902783524917
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'corethreads' AND "type" = 3 AND "id" <> '1529403902783524917') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902783524918
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524918' AND NOT ("plugin_id" = '11' AND "field" = 'threads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902783524918
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'threads' AND "type" = 3 AND "id" <> '1529403902783524918') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529403902783524919
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524919' AND NOT ("plugin_id" = '11' AND "field" = 'queues' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529403902783524919
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'queues' AND "type" = 3 AND "id" <> '1529403902783524919') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529403902783524920
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524920' AND NOT ("plugin_id" = '11' AND "field" = 'threadpool' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529403902783524920
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '11' AND "field" = 'threadpool' AND "type" = 3 AND "id" <> '1529403902783524920') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- resource id collision: 1529403932781187073
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- resource id collision: 1529403932877656082
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656082' AND NOT ("id" = '1529403932877656082' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- resource parent identity collision: 1529403932877656082
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- resource id collision: 1529403932877656083
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656083' AND NOT ("id" = '1529403932877656083' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- resource parent identity collision: 1529403932877656083
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- resource id collision: 1529403932877656084
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656084' AND NOT ("id" = '1529403932877656084' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- resource parent identity collision: 1529403932877656084
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- resource id collision: 1529403932877656085
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656085' AND NOT ("id" = '1529403932877656085' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- resource parent identity collision: 1529403932877656085
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- resource id collision: 1529403932877656086
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656086' AND NOT ("id" = '1529403932877656086' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- resource parent identity collision: 1529403932877656086
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- resource id collision: 1529403932877656087
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656087' AND NOT ("id" = '1529403932877656087' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- resource parent identity collision: 1529403932877656087
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- resource id collision: 1529403932877656088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656088' AND NOT ("id" = '1529403932877656088' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- resource parent identity collision: 1529403932877656088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- resource id collision: 1529403932877656089
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656089' AND NOT ("id" = '1529403932877656089' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- resource parent identity collision: 1529403932877656089
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- resource id collision: 1529403932877656090
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656090' AND NOT ("id" = '1529403932877656090' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofa:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- resource parent identity collision: 1529403932877656090
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- permission id collision: 1529403932797964290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932797964290' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187073')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- permission natural-key collision: 1529403932797964290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187073' AND "id" <> '1529403932797964290') THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- permission resource identity collision: 1529403932797964290
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187073' AND NOT ("id" = '1529403932781187073' AND "parent_id" = '1346775491550474240' AND "name" = 'sofa' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- permission id collision: 1529403932881850530
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850530' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656082')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- permission natural-key collision: 1529403932881850530
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656082' AND "id" <> '1529403932881850530') THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- permission resource identity collision: 1529403932881850530
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656082' AND NOT ("id" = '1529403932877656082' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- permission id collision: 1529403932881850531
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850531' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656083')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- permission natural-key collision: 1529403932881850531
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656083' AND "id" <> '1529403932881850531') THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- permission resource identity collision: 1529403932881850531
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656083' AND NOT ("id" = '1529403932877656083' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- permission id collision: 1529403932881850532
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850532' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656084')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- permission natural-key collision: 1529403932881850532
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656084' AND "id" <> '1529403932881850532') THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- permission resource identity collision: 1529403932881850532
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656084' AND NOT ("id" = '1529403932877656084' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- permission id collision: 1529403932881850533
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850533' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656085')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- permission natural-key collision: 1529403932881850533
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656085' AND "id" <> '1529403932881850533') THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- permission resource identity collision: 1529403932881850533
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656085' AND NOT ("id" = '1529403932877656085' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- permission id collision: 1529403932881850534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850534' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656086')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission natural-key collision: 1529403932881850534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656086' AND "id" <> '1529403932881850534') THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission resource identity collision: 1529403932881850534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656086' AND NOT ("id" = '1529403932877656086' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission id collision: 1529403932881850535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850535' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656087')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission natural-key collision: 1529403932881850535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656087' AND "id" <> '1529403932881850535') THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission resource identity collision: 1529403932881850535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656087' AND NOT ("id" = '1529403932877656087' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission id collision: 1529403932881850536
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850536' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656088')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission natural-key collision: 1529403932881850536
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656088' AND "id" <> '1529403932881850536') THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission resource identity collision: 1529403932881850536
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656088' AND NOT ("id" = '1529403932877656088' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission id collision: 1529403932881850537
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850537' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656089')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission natural-key collision: 1529403932881850537
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656089' AND "id" <> '1529403932881850537') THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission resource identity collision: 1529403932881850537
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656089' AND NOT ("id" = '1529403932877656089' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofaRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission id collision: 1529403932881850538
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850538' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656090')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission natural-key collision: 1529403932881850538
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656090' AND "id" <> '1529403932881850538') THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission resource identity collision: 1529403932881850538
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656090' AND NOT ("id" = '1529403932877656090' AND "parent_id" = '1529403932781187073' AND "name" = '' AND "perms" = 'plugin:sofa:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- namespace_plugin_rel id collision: 1801816010882822147
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822147' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '11')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- namespace_plugin_rel natural-key collision: 1801816010882822147
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '11' AND "id" <> '1801816010882822147') THEN 0 ELSE 1 END AS shenyu_preflight_check_69;
