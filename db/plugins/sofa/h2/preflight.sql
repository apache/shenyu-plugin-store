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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:shenyu-admin/src/main/resources/sql-script/h2/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '11' AND name <> 'sofa') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'sofa' AND id <> '11') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1529402613199978534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978534' AND NOT (plugin_id = '11' AND field = 'protocol' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613199978534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'protocol' AND type = 3 AND id <> '1529402613199978534') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1529402613199978535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613199978535' AND NOT (plugin_id = '11' AND field = 'register' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613199978535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'register' AND type = 3 AND id <> '1529402613199978535') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1729402613199978534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1729402613199978534' AND NOT (plugin_id = '11' AND field = 'protocol' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1729402613199978534
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'protocol' AND type = 1 AND id <> '1729402613199978534') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1729402613199978535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1729402613199978535' AND NOT (plugin_id = '11' AND field = 'register' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1729402613199978535
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'register' AND type = 1 AND id <> '1729402613199978535') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1529402613204172872
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172872' AND NOT (plugin_id = '11' AND field = 'corethreads' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172872
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'corethreads' AND type = 3 AND id <> '1529402613204172872') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1529402613204172873
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172873' AND NOT (plugin_id = '11' AND field = 'threads' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172873
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'threads' AND type = 3 AND id <> '1529402613204172873') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1529402613204172874
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172874' AND NOT (plugin_id = '11' AND field = 'queues' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172874
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'queues' AND type = 3 AND id <> '1529402613204172874') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1529402613204172875
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172875' AND NOT (plugin_id = '11' AND field = 'threadpool' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172875
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '11' AND field = 'threadpool' AND type = 3 AND id <> '1529402613204172875') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- resource id collision: 1529402639284355073
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- resource id collision: 1529402639368241170
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241170' AND NOT (id = '1529402639368241170' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- resource parent identity collision: 1529402639368241170
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- resource id collision: 1529402639368241171
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241171' AND NOT (id = '1529402639368241171' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- resource parent identity collision: 1529402639368241171
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- resource id collision: 1529402639368241172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241172' AND NOT (id = '1529402639368241172' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- resource parent identity collision: 1529402639368241172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- resource id collision: 1529402639368241173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241173' AND NOT (id = '1529402639368241173' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- resource parent identity collision: 1529402639368241173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- resource id collision: 1529402639368241174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241174' AND NOT (id = '1529402639368241174' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- resource parent identity collision: 1529402639368241174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- resource id collision: 1529402639368241175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241175' AND NOT (id = '1529402639368241175' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- resource parent identity collision: 1529402639368241175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- resource id collision: 1529402639368241176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241176' AND NOT (id = '1529402639368241176' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- resource parent identity collision: 1529402639368241176
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- resource id collision: 1529402639368241177
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241177' AND NOT (id = '1529402639368241177' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- resource parent identity collision: 1529402639368241177
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- resource id collision: 1529402639368241178
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241178' AND NOT (id = '1529402639368241178' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofa:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- resource parent identity collision: 1529402639368241178
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- permission id collision: 1529402639305326594
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326594' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355073')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- permission natural-key collision: 1529402639305326594
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355073' AND id <> '1529402639305326594') THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- permission resource identity collision: 1529402639305326594
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355073' AND NOT (id = '1529402639284355073' AND parent_id = '1346775491550474240' AND name = 'sofa' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- permission id collision: 1529402639372435681
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435681' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241170')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- permission natural-key collision: 1529402639372435681
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241170' AND id <> '1529402639372435681') THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- permission resource identity collision: 1529402639372435681
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241170' AND NOT (id = '1529402639368241170' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- permission id collision: 1529402639372435682
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435682' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241171')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- permission natural-key collision: 1529402639372435682
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241171' AND id <> '1529402639372435682') THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- permission resource identity collision: 1529402639372435682
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241171' AND NOT (id = '1529402639368241171' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- permission id collision: 1529402639372435683
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435683' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241172')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- permission natural-key collision: 1529402639372435683
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241172' AND id <> '1529402639372435683') THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- permission resource identity collision: 1529402639372435683
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241172' AND NOT (id = '1529402639368241172' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- permission id collision: 1529402639372435684
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435684' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241173')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- permission natural-key collision: 1529402639372435684
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241173' AND id <> '1529402639372435684') THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- permission resource identity collision: 1529402639372435684
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241173' AND NOT (id = '1529402639368241173' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- permission id collision: 1529402639372435685
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435685' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241174')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission natural-key collision: 1529402639372435685
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241174' AND id <> '1529402639372435685') THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission resource identity collision: 1529402639372435685
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241174' AND NOT (id = '1529402639368241174' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission id collision: 1529402639372435686
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435686' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241175')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission natural-key collision: 1529402639372435686
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241175' AND id <> '1529402639372435686') THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission resource identity collision: 1529402639372435686
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241175' AND NOT (id = '1529402639368241175' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission id collision: 1529402639372435687
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435687' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241176')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission natural-key collision: 1529402639372435687
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241176' AND id <> '1529402639372435687') THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission resource identity collision: 1529402639372435687
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241176' AND NOT (id = '1529402639368241176' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission id collision: 1529402639372435688
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435688' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241177')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission natural-key collision: 1529402639372435688
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241177' AND id <> '1529402639372435688') THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission resource identity collision: 1529402639372435688
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241177' AND NOT (id = '1529402639368241177' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofaRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission id collision: 1529402639372435689
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435689' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241178')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission natural-key collision: 1529402639372435689
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241178' AND id <> '1529402639372435689') THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission resource identity collision: 1529402639372435689
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241178' AND NOT (id = '1529402639368241178' AND parent_id = '1529402639284355073' AND name = '' AND perms = 'plugin:sofa:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822147
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822147' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '11')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822147
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '11' AND id <> '1801816010882822147') THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;
