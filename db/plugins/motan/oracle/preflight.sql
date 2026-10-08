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
-- Source: apache/shenyu c8961528b72a2a7f81f0d1cd7525af1659a670bc:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '17' AND name <> 'motan') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'motan' AND id <> '17') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1518229897214468142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468142' AND NOT (plugin_id = '17' AND field = 'registerProtocol' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerProtocol' AND type = 3 AND id <> '1518229897214468142') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1679002911061737473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1679002911061737473' AND NOT (plugin_id = '17' AND field = 'registerAddress' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1679002911061737473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerAddress' AND type = 3 AND id <> '1679002911061737473') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1818229897214468142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1818229897214468142' AND NOT (plugin_id = '17' AND field = 'registerProtocol' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1818229897214468142
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerProtocol' AND type = 1 AND id <> '1818229897214468142') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1879002911061737473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1879002911061737473' AND NOT (plugin_id = '17' AND field = 'registerAddress' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1879002911061737473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerAddress' AND type = 1 AND id <> '1879002911061737473') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- resource id collision: 1529402639284355079
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- resource id collision: 1529402639372435474
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435474' AND NOT (id = '1529402639372435474' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- resource parent identity collision: 1529402639372435474
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- resource id collision: 1529402639372435475
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435475' AND NOT (id = '1529402639372435475' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- resource parent identity collision: 1529402639372435475
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- resource id collision: 1529402639372435476
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435476' AND NOT (id = '1529402639372435476' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- resource parent identity collision: 1529402639372435476
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- resource id collision: 1529402639372435477
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435477' AND NOT (id = '1529402639372435477' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- resource parent identity collision: 1529402639372435477
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- resource id collision: 1529402639372435478
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435478' AND NOT (id = '1529402639372435478' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- resource parent identity collision: 1529402639372435478
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- resource id collision: 1529402639372435479
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435479' AND NOT (id = '1529402639372435479' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- resource parent identity collision: 1529402639372435479
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- resource id collision: 1529402639372435480
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435480' AND NOT (id = '1529402639372435480' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- resource parent identity collision: 1529402639372435480
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- resource id collision: 1529402639372435481
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435481' AND NOT (id = '1529402639372435481' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- resource parent identity collision: 1529402639372435481
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- resource id collision: 1529402639372435482
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435482' AND NOT (id = '1529402639372435482' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motan:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- resource parent identity collision: 1529402639372435482
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- permission id collision: 1529402639305326600
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326600' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355079')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- permission natural-key collision: 1529402639305326600
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355079' AND id <> '1529402639305326600') THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- permission resource identity collision: 1529402639305326600
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- permission id collision: 1529402639372435735
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435735' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435474')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- permission natural-key collision: 1529402639372435735
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435474' AND id <> '1529402639372435735') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- permission resource identity collision: 1529402639372435735
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435474' AND NOT (id = '1529402639372435474' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- permission id collision: 1529402639372435736
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435736' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435475')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- permission natural-key collision: 1529402639372435736
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435475' AND id <> '1529402639372435736') THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- permission resource identity collision: 1529402639372435736
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435475' AND NOT (id = '1529402639372435475' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- permission id collision: 1529402639372435737
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435737' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435476')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- permission natural-key collision: 1529402639372435737
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435476' AND id <> '1529402639372435737') THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- permission resource identity collision: 1529402639372435737
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435476' AND NOT (id = '1529402639372435476' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- permission id collision: 1529402639372435738
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435738' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435477')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- permission natural-key collision: 1529402639372435738
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435477' AND id <> '1529402639372435738') THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- permission resource identity collision: 1529402639372435738
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435477' AND NOT (id = '1529402639372435477' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- permission id collision: 1529402639372435739
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435739' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435478')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- permission natural-key collision: 1529402639372435739
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435478' AND id <> '1529402639372435739') THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- permission resource identity collision: 1529402639372435739
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435478' AND NOT (id = '1529402639372435478' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- permission id collision: 1529402639372435740
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435740' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435479')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- permission natural-key collision: 1529402639372435740
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435479' AND id <> '1529402639372435740') THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- permission resource identity collision: 1529402639372435740
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435479' AND NOT (id = '1529402639372435479' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- permission id collision: 1529402639372435741
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435741' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435480')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- permission natural-key collision: 1529402639372435741
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435480' AND id <> '1529402639372435741') THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- permission resource identity collision: 1529402639372435741
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435480' AND NOT (id = '1529402639372435480' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission id collision: 1529402639372435742
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435742' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435481')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission natural-key collision: 1529402639372435742
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435481' AND id <> '1529402639372435742') THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission resource identity collision: 1529402639372435742
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435481' AND NOT (id = '1529402639372435481' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission id collision: 1529402639372435743
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435743' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435482')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission natural-key collision: 1529402639372435743
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435482' AND id <> '1529402639372435743') THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission resource identity collision: 1529402639372435743
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435482' AND NOT (id = '1529402639372435482' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motan:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822153
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822153' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '17')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822153
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '17' AND id <> '1801816010882822153') THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;
