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

-- Preflight checks for tars (tars).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '13' AND name <> 'tars') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'tars' AND id <> '13') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1518229897210273846
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273846' AND NOT (plugin_id = '13' AND field = 'upstreamHost' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273846
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'upstreamHost' AND type = 1 AND id <> '1518229897210273846') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1518229897210273847
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273847' AND NOT (plugin_id = '13' AND field = 'protocol' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273847
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'protocol' AND type = 1 AND id <> '1518229897210273847') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1518229897210273848
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273848' AND NOT (plugin_id = '13' AND field = 'upstreamUrl' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273848
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'upstreamUrl' AND type = 1 AND id <> '1518229897210273848') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1518229897210273849
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273849' AND NOT (plugin_id = '13' AND field = 'weight' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273849
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'weight' AND type = 1 AND id <> '1518229897210273849') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1518229897210273850
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273850' AND NOT (plugin_id = '13' AND field = 'timestamp' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273850
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'timestamp' AND type = 1 AND id <> '1518229897210273850') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1518229897210273851
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273851' AND NOT (plugin_id = '13' AND field = 'warmup' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273851
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'warmup' AND type = 1 AND id <> '1518229897210273851') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1518229897210273852
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273852' AND NOT (plugin_id = '13' AND field = 'status' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273852
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'status' AND type = 1 AND id <> '1518229897210273852') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1518229897210273853
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273853' AND NOT (plugin_id = '13' AND field = 'loadBalance' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273853
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'loadBalance' AND type = 2 AND id <> '1518229897210273853') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1518229897210273854
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273854' AND NOT (plugin_id = '13' AND field = 'retry' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273854
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'retry' AND type = 2 AND id <> '1518229897210273854') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1518229897210273855
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273855' AND NOT (plugin_id = '13' AND field = 'timeout' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273855
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'timeout' AND type = 2 AND id <> '1518229897210273855') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 1518229897210273856
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273856' AND NOT (plugin_id = '13' AND field = 'multiSelectorHandle' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273856
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'multiSelectorHandle' AND type = 3 AND id <> '1518229897210273856') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 1518229897210273857
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273857' AND NOT (plugin_id = '13' AND field = 'multiRuleHandle' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273857
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'multiRuleHandle' AND type = 3 AND id <> '1518229897210273857') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 1518229897210273858
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273858' AND NOT (plugin_id = '13' AND field = 'corethreads' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273858
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'corethreads' AND type = 3 AND id <> '1518229897210273858') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 1518229897210273859
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273859' AND NOT (plugin_id = '13' AND field = 'threads' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273859
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'threads' AND type = 3 AND id <> '1518229897210273859') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1518229897210273860
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273860' AND NOT (plugin_id = '13' AND field = 'queues' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273860
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'queues' AND type = 3 AND id <> '1518229897210273860') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1518229897210273861
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897210273861' AND NOT (plugin_id = '13' AND field = 'threadpool' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897210273861
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '13' AND field = 'threadpool' AND type = 3 AND id <> '1518229897210273861') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- resource id collision: 1529402639284355075
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- resource id collision: 1529402639368241188
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241188' AND NOT (id = '1529402639368241188' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- resource parent identity collision: 1529402639368241188
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- resource id collision: 1529402639368241189
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241189' AND NOT (id = '1529402639368241189' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- resource parent identity collision: 1529402639368241189
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- resource id collision: 1529402639368241190
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241190' AND NOT (id = '1529402639368241190' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- resource parent identity collision: 1529402639368241190
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- resource id collision: 1529402639368241191
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241191' AND NOT (id = '1529402639368241191' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- resource parent identity collision: 1529402639368241191
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- resource id collision: 1529402639368241192
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241192' AND NOT (id = '1529402639368241192' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- resource parent identity collision: 1529402639368241192
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- resource id collision: 1529402639368241193
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241193' AND NOT (id = '1529402639368241193' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- resource parent identity collision: 1529402639368241193
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- resource id collision: 1529402639368241194
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241194' AND NOT (id = '1529402639368241194' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- resource parent identity collision: 1529402639368241194
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- resource id collision: 1529402639368241195
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241195' AND NOT (id = '1529402639368241195' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- resource parent identity collision: 1529402639368241195
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- resource id collision: 1529402639368241196
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241196' AND NOT (id = '1529402639368241196' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tars:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- resource parent identity collision: 1529402639368241196
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission id collision: 1529402639305326596
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326596' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355075')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission natural-key collision: 1529402639305326596
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355075' AND id <> '1529402639305326596') THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission resource identity collision: 1529402639305326596
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355075' AND NOT (id = '1529402639284355075' AND parent_id = '1346775491550474240' AND name = 'tars' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission id collision: 1529402639372435699
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435699' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241188')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission natural-key collision: 1529402639372435699
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241188' AND id <> '1529402639372435699') THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission resource identity collision: 1529402639372435699
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241188' AND NOT (id = '1529402639368241188' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission id collision: 1529402639372435700
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435700' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241189')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission natural-key collision: 1529402639372435700
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241189' AND id <> '1529402639372435700') THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission resource identity collision: 1529402639372435700
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241189' AND NOT (id = '1529402639368241189' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission id collision: 1529402639372435701
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435701' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241190')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission natural-key collision: 1529402639372435701
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241190' AND id <> '1529402639372435701') THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission resource identity collision: 1529402639372435701
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241190' AND NOT (id = '1529402639368241190' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission id collision: 1529402639372435702
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435702' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241191')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission natural-key collision: 1529402639372435702
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241191' AND id <> '1529402639372435702') THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- permission resource identity collision: 1529402639372435702
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241191' AND NOT (id = '1529402639368241191' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- permission id collision: 1529402639372435703
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435703' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241192')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- permission natural-key collision: 1529402639372435703
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241192' AND id <> '1529402639372435703') THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- permission resource identity collision: 1529402639372435703
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241192' AND NOT (id = '1529402639368241192' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- permission id collision: 1529402639372435704
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435704' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241193')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- permission natural-key collision: 1529402639372435704
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241193' AND id <> '1529402639372435704') THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- permission resource identity collision: 1529402639372435704
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241193' AND NOT (id = '1529402639368241193' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- permission id collision: 1529402639372435705
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435705' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241194')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- permission natural-key collision: 1529402639372435705
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241194' AND id <> '1529402639372435705') THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- permission resource identity collision: 1529402639372435705
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241194' AND NOT (id = '1529402639368241194' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- permission id collision: 1529402639372435706
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435706' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241195')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- permission natural-key collision: 1529402639372435706
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241195' AND id <> '1529402639372435706') THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- permission resource identity collision: 1529402639372435706
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241195' AND NOT (id = '1529402639368241195' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tarsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- permission id collision: 1529402639372435707
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435707' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639368241196')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- permission natural-key collision: 1529402639372435707
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639368241196' AND id <> '1529402639372435707') THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- permission resource identity collision: 1529402639372435707
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1529402639368241196' AND NOT (id = '1529402639368241196' AND parent_id = '1529402639284355075' AND name = '' AND perms = 'plugin:tars:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822149
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822149' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '13')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822149
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '13' AND id <> '1801816010882822149') THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;
