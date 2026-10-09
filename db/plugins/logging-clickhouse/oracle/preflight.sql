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

-- Preflight checks for logging-clickhouse (loggingClickHouse).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '38' AND name <> 'loggingClickHouse') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingClickHouse' AND id <> '38') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1518229897214468223
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468223' AND NOT (plugin_id = '38' AND field = 'host' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468223
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'host' AND type = 3 AND id <> '1518229897214468223') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1518229897214468224
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468224' AND NOT (plugin_id = '38' AND field = 'port' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468224
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'port' AND type = 3 AND id <> '1518229897214468224') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1518229897214468225
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468225' AND NOT (plugin_id = '38' AND field = 'database' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468225
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'database' AND type = 2 AND id <> '1518229897214468225') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1518229897214468226
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468226' AND NOT (plugin_id = '38' AND field = 'username' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468226
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'username' AND type = 2 AND id <> '1518229897214468226') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1518229897214468227
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468227' AND NOT (plugin_id = '38' AND field = 'password' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468227
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'password' AND type = 2 AND id <> '1518229897214468227') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1518229897214468252
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468252' AND NOT (plugin_id = '38' AND field = 'keyword' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468252
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'keyword' AND type = 2 AND id <> '1518229897214468252') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1518229897214468253
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468253' AND NOT (plugin_id = '38' AND field = 'maskType' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468253
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'maskType' AND type = 2 AND id <> '1518229897214468253') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1518229897214468254
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468254' AND NOT (plugin_id = '38' AND field = 'maskStatus' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468254
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'maskStatus' AND type = 2 AND id <> '1518229897214468254') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1518229897214468257
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468257' AND NOT (plugin_id = '38' AND field = 'database' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468257
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'database' AND type = 3 AND id <> '1518229897214468257') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1518229897214468258
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468258' AND NOT (plugin_id = '38' AND field = 'username' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468258
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'username' AND type = 3 AND id <> '1518229897214468258') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 1518229897214468259
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468259' AND NOT (plugin_id = '38' AND field = 'password' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468259
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'password' AND type = 3 AND id <> '1518229897214468259') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 1518229897214468261
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1518229897214468261' AND NOT (plugin_id = '38' AND field = 'engine' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 1518229897214468261
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'engine' AND type = 3 AND id <> '1518229897214468261') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 1529402613204172862
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172862' AND NOT (plugin_id = '38' AND field = 'clusterName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172862
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'clusterName' AND type = 3 AND id <> '1529402613204172862') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 1529402613204172777
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172777' AND NOT (plugin_id = '38' AND field = 'ttl' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172777
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'ttl' AND type = 3 AND id <> '1529402613204172777') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1722804548510507018
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507018' AND NOT (plugin_id = '38' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507018
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507018') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1722804548510507019
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507019' AND NOT (plugin_id = '38' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507019
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507019') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- resource id collision: 1534585531108565043
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- resource id collision: 1534585531108565044
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565044' AND NOT (id = '1534585531108565044' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- resource parent identity collision: 1534585531108565044
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- resource id collision: 1534585531108565045
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565045' AND NOT (id = '1534585531108565045' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- resource parent identity collision: 1534585531108565045
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- resource id collision: 1534585531108565046
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565046' AND NOT (id = '1534585531108565046' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- resource parent identity collision: 1534585531108565046
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- resource id collision: 1534585531108565047
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565047' AND NOT (id = '1534585531108565047' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- resource parent identity collision: 1534585531108565047
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- resource id collision: 1534585531108565048
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565048' AND NOT (id = '1534585531108565048' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- resource parent identity collision: 1534585531108565048
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- resource id collision: 1534585531108565049
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565049' AND NOT (id = '1534585531108565049' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- resource parent identity collision: 1534585531108565049
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- resource id collision: 1534585531108565050
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565050' AND NOT (id = '1534585531108565050' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- resource parent identity collision: 1534585531108565050
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- resource id collision: 1534585531108565051
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565051' AND NOT (id = '1534585531108565051' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- resource parent identity collision: 1534585531108565051
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- resource id collision: 1534585531108565052
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565052' AND NOT (id = '1534585531108565052' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouse:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- resource parent identity collision: 1534585531108565052
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- permission id collision: 1534585531389583411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583411' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565043')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- permission natural-key collision: 1534585531389583411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565043' AND id <> '1534585531389583411') THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- permission resource identity collision: 1534585531389583411
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- permission id collision: 1534585531389583412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583412' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565044')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission natural-key collision: 1534585531389583412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565044' AND id <> '1534585531389583412') THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission resource identity collision: 1534585531389583412
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565044' AND NOT (id = '1534585531108565044' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission id collision: 1534585531389583413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583413' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565045')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission natural-key collision: 1534585531389583413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565045' AND id <> '1534585531389583413') THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission resource identity collision: 1534585531389583413
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565045' AND NOT (id = '1534585531108565045' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission id collision: 1534585531389583414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583414' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565046')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission natural-key collision: 1534585531389583414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565046' AND id <> '1534585531389583414') THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission resource identity collision: 1534585531389583414
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565046' AND NOT (id = '1534585531108565046' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission id collision: 1534585531389583415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583415' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565047')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission natural-key collision: 1534585531389583415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565047' AND id <> '1534585531389583415') THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- permission resource identity collision: 1534585531389583415
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565047' AND NOT (id = '1534585531108565047' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- permission id collision: 1534585531389583416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583416' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565048')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- permission natural-key collision: 1534585531389583416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565048' AND id <> '1534585531389583416') THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- permission resource identity collision: 1534585531389583416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565048' AND NOT (id = '1534585531108565048' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- permission id collision: 1534585531389583417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583417' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565049')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- permission natural-key collision: 1534585531389583417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565049' AND id <> '1534585531389583417') THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- permission resource identity collision: 1534585531389583417
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565049' AND NOT (id = '1534585531108565049' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- permission id collision: 1534585531389583418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583418' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565050')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- permission natural-key collision: 1534585531389583418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565050' AND id <> '1534585531389583418') THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- permission resource identity collision: 1534585531389583418
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565050' AND NOT (id = '1534585531108565050' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- permission id collision: 1534585531389583419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583419' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565051')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- permission natural-key collision: 1534585531389583419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565051' AND id <> '1534585531389583419') THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- permission resource identity collision: 1534585531389583419
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565051' AND NOT (id = '1534585531108565051' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- permission id collision: 1534585531389583420
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583420' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565052')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- permission natural-key collision: 1534585531389583420
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565052' AND id <> '1534585531389583420') THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- permission resource identity collision: 1534585531389583420
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565052' AND NOT (id = '1534585531108565052' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouse:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822175' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '38')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '38' AND id <> '1801816010882822175') THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;
