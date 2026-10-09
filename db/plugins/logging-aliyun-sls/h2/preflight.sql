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

-- Preflight checks for logging-aliyun-sls (loggingAliyunSls).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:shenyu-admin/src/main/resources/sql-script/h2/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '34' AND name <> 'loggingAliyunSls') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingAliyunSls' AND id <> '34') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 349402613204172896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172896' AND NOT (plugin_id = '34' AND field = 'accessId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'accessId' AND type = 3 AND id <> '349402613204172896') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 349402613204172897
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172897' AND NOT (plugin_id = '34' AND field = 'accessKey' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172897
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'accessKey' AND type = 3 AND id <> '349402613204172897') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1529402613204172898
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172898' AND NOT (plugin_id = '34' AND field = 'host' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172898
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'host' AND type = 3 AND id <> '1529402613204172898') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1529402613204172899
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172899' AND NOT (plugin_id = '34' AND field = 'projectName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172899
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'projectName' AND type = 3 AND id <> '1529402613204172899') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1529402613204172900
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172900' AND NOT (plugin_id = '34' AND field = 'logStoreName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172900
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'logStoreName' AND type = 3 AND id <> '1529402613204172900') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1529402613204172901
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172901' AND NOT (plugin_id = '34' AND field = 'topic' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172901
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'topic' AND type = 3 AND id <> '1529402613204172901') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1529402613204172902
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172902' AND NOT (plugin_id = '34' AND field = 'ttlInDay' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172902
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'ttlInDay' AND type = 3 AND id <> '1529402613204172902') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1529402613204172903
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172903' AND NOT (plugin_id = '34' AND field = 'shardCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172903
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'shardCount' AND type = 3 AND id <> '1529402613204172903') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1529402613204172904
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172904' AND NOT (plugin_id = '34' AND field = 'sendThreadCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172904
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sendThreadCount' AND type = 3 AND id <> '1529402613204172904') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1529402613204172905
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172905' AND NOT (plugin_id = '34' AND field = 'ioThreadCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172905
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'ioThreadCount' AND type = 3 AND id <> '1529402613204172905') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 349402613204172906
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172906' AND NOT (plugin_id = '34' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172906
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sampleRate' AND type = 3 AND id <> '349402613204172906') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 349402613204172907
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172907' AND NOT (plugin_id = '34' AND field = 'maxRequestBody' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172907
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maxRequestBody' AND type = 3 AND id <> '349402613204172907') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 349402613204172908
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172908' AND NOT (plugin_id = '34' AND field = 'maxResponseBody' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172908
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maxResponseBody' AND type = 3 AND id <> '349402613204172908') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 349402613204172909
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '349402613204172909' AND NOT (plugin_id = '34' AND field = 'bufferQueueSize' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 349402613204172909
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'bufferQueueSize' AND type = 3 AND id <> '349402613204172909') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1529402613204172945
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172945' AND NOT (plugin_id = '34' AND field = 'keyword' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172945
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172945') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1529402613204172946
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172946' AND NOT (plugin_id = '34' AND field = 'maskType' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172946
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172946') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- plugin_handle id collision: 1529402613204172947
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172947' AND NOT (plugin_id = '34' AND field = 'maskStatus' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172947
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172947') THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- plugin_handle id collision: 1722804548510507016
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507016' AND NOT (plugin_id = '34' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507016
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '34' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507016') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- resource id collision: 1534585531108564993
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- resource id collision: 1534585531108564994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564994' AND NOT (id = '1534585531108564994' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- resource parent identity collision: 1534585531108564994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- resource id collision: 1534585531108564995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564995' AND NOT (id = '1534585531108564995' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- resource parent identity collision: 1534585531108564995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- resource id collision: 1534585531108564996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564996' AND NOT (id = '1534585531108564996' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- resource parent identity collision: 1534585531108564996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- resource id collision: 1534585531108564997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564997' AND NOT (id = '1534585531108564997' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- resource parent identity collision: 1534585531108564997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- resource id collision: 1534585531108564998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564998' AND NOT (id = '1534585531108564998' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- resource parent identity collision: 1534585531108564998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- resource id collision: 1534585531108564999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564999' AND NOT (id = '1534585531108564999' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- resource parent identity collision: 1534585531108564999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- resource id collision: 1534585531108565000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565000' AND NOT (id = '1534585531108565000' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- resource parent identity collision: 1534585531108565000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- resource id collision: 1534585531108565001
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565001' AND NOT (id = '1534585531108565001' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- resource parent identity collision: 1534585531108565001
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- resource id collision: 1534585531108565002
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565002' AND NOT (id = '1534585531108565002' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- resource parent identity collision: 1534585531108565002
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- permission id collision: 1534585531389583361
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583361' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564993')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- permission natural-key collision: 1534585531389583361
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564993' AND id <> '1534585531389583361') THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- permission resource identity collision: 1534585531389583361
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564993' AND NOT (id = '1534585531108564993' AND parent_id = '1346775491550474240' AND name = 'loggingAliyunSls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- permission id collision: 1534585531389583362
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583362' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564994')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission natural-key collision: 1534585531389583362
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564994' AND id <> '1534585531389583362') THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission resource identity collision: 1534585531389583362
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564994' AND NOT (id = '1534585531108564994' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission id collision: 1534585531389583363
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583363' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564995')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission natural-key collision: 1534585531389583363
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564995' AND id <> '1534585531389583363') THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission resource identity collision: 1534585531389583363
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564995' AND NOT (id = '1534585531108564995' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission id collision: 1534585531389583364
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583364' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564996')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- permission natural-key collision: 1534585531389583364
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564996' AND id <> '1534585531389583364') THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- permission resource identity collision: 1534585531389583364
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564996' AND NOT (id = '1534585531108564996' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- permission id collision: 1534585531389583365
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583365' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564997')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- permission natural-key collision: 1534585531389583365
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564997' AND id <> '1534585531389583365') THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- permission resource identity collision: 1534585531389583365
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564997' AND NOT (id = '1534585531108564997' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- permission id collision: 1534585531389583366
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583366' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564998')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- permission natural-key collision: 1534585531389583366
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564998' AND id <> '1534585531389583366') THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- permission resource identity collision: 1534585531389583366
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564998' AND NOT (id = '1534585531108564998' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- permission id collision: 1534585531389583367
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583367' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108564999')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- permission natural-key collision: 1534585531389583367
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108564999' AND id <> '1534585531389583367') THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- permission resource identity collision: 1534585531389583367
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108564999' AND NOT (id = '1534585531108564999' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- permission id collision: 1534585531389583368
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583368' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565000')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- permission natural-key collision: 1534585531389583368
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565000' AND id <> '1534585531389583368') THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- permission resource identity collision: 1534585531389583368
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565000' AND NOT (id = '1534585531108565000' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- permission id collision: 1534585531389583369
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583369' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565001')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- permission natural-key collision: 1534585531389583369
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565001' AND id <> '1534585531389583369') THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- permission resource identity collision: 1534585531389583369
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565001' AND NOT (id = '1534585531108565001' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSlsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- permission id collision: 1534585531389583370
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583370' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565002')) THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;

-- permission natural-key collision: 1534585531389583370
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565002' AND id <> '1534585531389583370') THEN 0 ELSE 1 END AS shenyu_preflight_check_86 FROM DUAL;

-- permission resource identity collision: 1534585531389583370
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565002' AND NOT (id = '1534585531108565002' AND parent_id = '1534585531108564993' AND name = '' AND perms = 'plugin:loggingAliyunSls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_87 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822172' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '34')) THEN 0 ELSE 1 END AS shenyu_preflight_check_88 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '34' AND id <> '1801816010882822172') THEN 0 ELSE 1 END AS shenyu_preflight_check_89 FROM DUAL;
