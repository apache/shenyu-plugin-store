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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '9' AND name <> 'hystrix') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'hystrix' AND id <> '9') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- resource id collision: 1529402639284355099
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- resource id collision: 1529402639372435654
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435654' AND NOT (id = '1529402639372435654' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- resource parent identity collision: 1529402639372435654
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- resource id collision: 1529402639372435655
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435655' AND NOT (id = '1529402639372435655' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- resource parent identity collision: 1529402639372435655
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- resource id collision: 1529402639372435656
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435656' AND NOT (id = '1529402639372435656' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- resource parent identity collision: 1529402639372435656
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- resource id collision: 1529402639372435657
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435657' AND NOT (id = '1529402639372435657' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- resource parent identity collision: 1529402639372435657
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- resource id collision: 1529402639372435658
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435658' AND NOT (id = '1529402639372435658' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- resource parent identity collision: 1529402639372435658
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- resource id collision: 1529402639372435659
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435659' AND NOT (id = '1529402639372435659' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- resource parent identity collision: 1529402639372435659
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- resource id collision: 1529402639372435660
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435660' AND NOT (id = '1529402639372435660' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- resource parent identity collision: 1529402639372435660
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- resource id collision: 1529402639372435661
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435661' AND NOT (id = '1529402639372435661' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- resource parent identity collision: 1529402639372435661
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- resource id collision: 1529402639372435662
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435662' AND NOT (id = '1529402639372435662' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrix:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- resource parent identity collision: 1529402639372435662
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- permission id collision: 1529402639305326620
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326620' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355099')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- permission natural-key collision: 1529402639305326620
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355099' AND id <> '1529402639305326620') THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- permission resource identity collision: 1529402639305326620
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355099' AND NOT (id = '1529402639284355099' AND parent_id = '1346775491550474240' AND name = 'hystrix' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- permission id collision: 1529402639376629888
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629888' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435654')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- permission natural-key collision: 1529402639376629888
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435654' AND id <> '1529402639376629888') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- permission resource identity collision: 1529402639376629888
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435654' AND NOT (id = '1529402639372435654' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- permission id collision: 1529402639376629889
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629889' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435655')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- permission natural-key collision: 1529402639376629889
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435655' AND id <> '1529402639376629889') THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- permission resource identity collision: 1529402639376629889
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435655' AND NOT (id = '1529402639372435655' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- permission id collision: 1529402639376629890
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629890' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435656')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- permission natural-key collision: 1529402639376629890
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435656' AND id <> '1529402639376629890') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- permission resource identity collision: 1529402639376629890
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435656' AND NOT (id = '1529402639372435656' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- permission id collision: 1529402639376629891
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629891' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435657')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- permission natural-key collision: 1529402639376629891
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435657' AND id <> '1529402639376629891') THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- permission resource identity collision: 1529402639376629891
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435657' AND NOT (id = '1529402639372435657' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- permission id collision: 1529402639376629892
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629892' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435658')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- permission natural-key collision: 1529402639376629892
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435658' AND id <> '1529402639376629892') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- permission resource identity collision: 1529402639376629892
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435658' AND NOT (id = '1529402639372435658' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- permission id collision: 1529402639376629893
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629893' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435659')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- permission natural-key collision: 1529402639376629893
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435659' AND id <> '1529402639376629893') THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- permission resource identity collision: 1529402639376629893
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435659' AND NOT (id = '1529402639372435659' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- permission id collision: 1529402639376629894
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629894' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435660')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- permission natural-key collision: 1529402639376629894
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435660' AND id <> '1529402639376629894') THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- permission resource identity collision: 1529402639376629894
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435660' AND NOT (id = '1529402639372435660' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- permission id collision: 1529402639376629895
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629895' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435661')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- permission natural-key collision: 1529402639376629895
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435661' AND id <> '1529402639376629895') THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- permission resource identity collision: 1529402639376629895
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435661' AND NOT (id = '1529402639372435661' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrixRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- permission id collision: 1529402639376629896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639376629896' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435662')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- permission natural-key collision: 1529402639376629896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435662' AND id <> '1529402639376629896') THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- permission resource identity collision: 1529402639376629896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435662' AND NOT (id = '1529402639372435662' AND parent_id = '1529402639284355099' AND name = '' AND perms = 'plugin:hystrix:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822186' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '9')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '9' AND id <> '1801816010882822186') THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;
