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

-- Preflight checks for logging-pulsar (loggingPulsar).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '35' AND name <> 'loggingPulsar') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingPulsar' AND id <> '35') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1518229897214468202
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468202' AND NOT (plugin_id = '35' AND field = 'topic' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468202
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'topic' AND type = 3 AND id <> '1518229897214468202') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1518229897214468203
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468203' AND NOT (plugin_id = '35' AND field = 'serviceUrl' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468203
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'serviceUrl' AND type = 3 AND id <> '1518229897214468203') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1518229897214468204
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468204' AND NOT (plugin_id = '35' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468204
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'sampleRate' AND type = 3 AND id <> '1518229897214468204') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1518229897214468205
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468205' AND NOT (plugin_id = '35' AND field = 'maxResponseBody' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468205
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maxResponseBody' AND type = 3 AND id <> '1518229897214468205') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1518229897214468206
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468206' AND NOT (plugin_id = '35' AND field = 'maxRequestBody' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468206
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maxRequestBody' AND type = 3 AND id <> '1518229897214468206') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1518229897214468207
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468207' AND NOT (plugin_id = '35' AND field = 'compressAlg' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468207
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'compressAlg' AND type = 3 AND id <> '1518229897214468207') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1518229897214468246
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468246' AND NOT (plugin_id = '35' AND field = 'keyword' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468246
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'keyword' AND type = 2 AND id <> '1518229897214468246') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1518229897214468247
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468247' AND NOT (plugin_id = '35' AND field = 'maskType' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468247
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maskType' AND type = 2 AND id <> '1518229897214468247') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1518229897214468248
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468248' AND NOT (plugin_id = '35' AND field = 'maskStatus' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468248
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maskStatus' AND type = 2 AND id <> '1518229897214468248') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1722804548510507017
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507017' AND NOT (plugin_id = '35' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507017
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507017') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- resource id collision: 1534585531108565023
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- resource id collision: 1534585531108565024
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565024' AND NOT (id = '1534585531108565024' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- resource parent identity collision: 1534585531108565024
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- resource id collision: 1534585531108565025
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565025' AND NOT (id = '1534585531108565025' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- resource parent identity collision: 1534585531108565025
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- resource id collision: 1534585531108565026
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565026' AND NOT (id = '1534585531108565026' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- resource parent identity collision: 1534585531108565026
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- resource id collision: 1534585531108565027
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565027' AND NOT (id = '1534585531108565027' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- resource parent identity collision: 1534585531108565027
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- resource id collision: 1534585531108565028
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565028' AND NOT (id = '1534585531108565028' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- resource parent identity collision: 1534585531108565028
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- resource id collision: 1534585531108565029
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565029' AND NOT (id = '1534585531108565029' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- resource parent identity collision: 1534585531108565029
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- resource id collision: 1534585531108565030
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565030' AND NOT (id = '1534585531108565030' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- resource parent identity collision: 1534585531108565030
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- resource id collision: 1534585531108565031
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565031' AND NOT (id = '1534585531108565031' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- resource parent identity collision: 1534585531108565031
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- resource id collision: 1534585531108565032
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565032' AND NOT (id = '1534585531108565032' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsar:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- resource parent identity collision: 1534585531108565032
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- permission id collision: 1534585531389583391
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583391' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565023')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- permission natural-key collision: 1534585531389583391
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565023' AND id <> '1534585531389583391') THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- permission resource identity collision: 1534585531389583391
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- permission id collision: 1534585531389583392
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583392' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565024')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- permission natural-key collision: 1534585531389583392
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565024' AND id <> '1534585531389583392') THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- permission resource identity collision: 1534585531389583392
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565024' AND NOT (id = '1534585531108565024' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- permission id collision: 1534585531389583393
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583393' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565025')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- permission natural-key collision: 1534585531389583393
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565025' AND id <> '1534585531389583393') THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- permission resource identity collision: 1534585531389583393
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565025' AND NOT (id = '1534585531108565025' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- permission id collision: 1534585531389583394
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583394' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565026')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- permission natural-key collision: 1534585531389583394
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565026' AND id <> '1534585531389583394') THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- permission resource identity collision: 1534585531389583394
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565026' AND NOT (id = '1534585531108565026' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission id collision: 1534585531389583395
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583395' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565027')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission natural-key collision: 1534585531389583395
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565027' AND id <> '1534585531389583395') THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission resource identity collision: 1534585531389583395
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565027' AND NOT (id = '1534585531108565027' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission id collision: 1534585531389583396
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583396' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565028')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission natural-key collision: 1534585531389583396
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565028' AND id <> '1534585531389583396') THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission resource identity collision: 1534585531389583396
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565028' AND NOT (id = '1534585531108565028' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission id collision: 1534585531389583397
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583397' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565029')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission natural-key collision: 1534585531389583397
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565029' AND id <> '1534585531389583397') THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission resource identity collision: 1534585531389583397
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565029' AND NOT (id = '1534585531108565029' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission id collision: 1534585531389583398
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583398' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565030')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission natural-key collision: 1534585531389583398
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565030' AND id <> '1534585531389583398') THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission resource identity collision: 1534585531389583398
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565030' AND NOT (id = '1534585531108565030' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission id collision: 1534585531389583399
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583399' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565031')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission natural-key collision: 1534585531389583399
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565031' AND id <> '1534585531389583399') THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- permission resource identity collision: 1534585531389583399
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565031' AND NOT (id = '1534585531108565031' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- permission id collision: 1534585531389583400
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583400' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565032')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- permission natural-key collision: 1534585531389583400
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565032' AND id <> '1534585531389583400') THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- permission resource identity collision: 1534585531389583400
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565032' AND NOT (id = '1534585531108565032' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsar:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822173' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '35')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '35' AND id <> '1801816010882822173') THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;
