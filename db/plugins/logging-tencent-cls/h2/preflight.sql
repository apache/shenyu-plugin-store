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

-- Preflight checks for logging-tencent-cls (loggingTencentCls).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:shenyu-admin/src/main/resources/sql-script/h2/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '36' AND name <> 'loggingTencentCls') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingTencentCls' AND id <> '36') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1529402613204172916
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172916' AND NOT (plugin_id = '36' AND field = 'secretId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172916
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'secretId' AND type = 3 AND id <> '1529402613204172916') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1529402613204172917
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172917' AND NOT (plugin_id = '36' AND field = 'secretKey' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172917
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'secretKey' AND type = 3 AND id <> '1529402613204172917') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1529402613204172918
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172918' AND NOT (plugin_id = '36' AND field = 'endpoint' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172918
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'endpoint' AND type = 3 AND id <> '1529402613204172918') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1529402613204172919
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172919' AND NOT (plugin_id = '36' AND field = 'topic' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172919
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'topic' AND type = 3 AND id <> '1529402613204172919') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1529402613204172920
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172920' AND NOT (plugin_id = '36' AND field = 'sendThreadCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172920
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sendThreadCount' AND type = 3 AND id <> '1529402613204172920') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1529402613204172921
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172921' AND NOT (plugin_id = '36' AND field = 'totalSizeInBytes' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172921
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'totalSizeInBytes' AND type = 3 AND id <> '1529402613204172921') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1529402613204172922
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172922' AND NOT (plugin_id = '36' AND field = 'maxSendThreadCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172922
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxSendThreadCount' AND type = 3 AND id <> '1529402613204172922') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1529402613204172923
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172923' AND NOT (plugin_id = '36' AND field = 'maxBlockSec' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172923
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBlockSec' AND type = 3 AND id <> '1529402613204172923') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1529402613204172924
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172924' AND NOT (plugin_id = '36' AND field = 'maxBatchSize' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172924
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBatchSize' AND type = 3 AND id <> '1529402613204172924') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1529402613204172925
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172925' AND NOT (plugin_id = '36' AND field = 'maxBatchCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172925
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxBatchCount' AND type = 3 AND id <> '1529402613204172925') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 369402613204172922
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '369402613204172922' AND NOT (plugin_id = '36' AND field = 'lingerMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 369402613204172922
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'lingerMs' AND type = 3 AND id <> '369402613204172922') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 1529402613204172926
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172926' AND NOT (plugin_id = '36' AND field = 'retries' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172926
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'retries' AND type = 3 AND id <> '1529402613204172926') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 1529402613204172927
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172927' AND NOT (plugin_id = '36' AND field = 'maxReservedAttempts' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172927
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxReservedAttempts' AND type = 3 AND id <> '1529402613204172927') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 1529402613204172929
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172929' AND NOT (plugin_id = '36' AND field = 'baseRetryBackoffMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172929
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'baseRetryBackoffMs' AND type = 3 AND id <> '1529402613204172929') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1529402613204172930
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172930' AND NOT (plugin_id = '36' AND field = 'maxRetryBackoffMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172930
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maxRetryBackoffMs' AND type = 3 AND id <> '1529402613204172930') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1529402613204172951
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172951' AND NOT (plugin_id = '36' AND field = 'keyword' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172951
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172951') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- plugin_handle id collision: 1529402613204172952
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172952' AND NOT (plugin_id = '36' AND field = 'maskType' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172952
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172952') THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- plugin_handle id collision: 1529402613204172953
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172953' AND NOT (plugin_id = '36' AND field = 'maskStatus' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172953
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172953') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- plugin_handle id collision: 1722804548510507014
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507014' AND NOT (plugin_id = '36' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507014
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507014') THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- plugin_handle id collision: 1722804548510507015
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507015' AND NOT (plugin_id = '36' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507015
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '36' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507015') THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- resource id collision: 1534585531108565003
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- resource id collision: 1534585531108565004
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565004' AND NOT (id = '1534585531108565004' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- resource parent identity collision: 1534585531108565004
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- resource id collision: 1534585531108565005
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565005' AND NOT (id = '1534585531108565005' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- resource parent identity collision: 1534585531108565005
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- resource id collision: 1534585531108565006
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565006' AND NOT (id = '1534585531108565006' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- resource parent identity collision: 1534585531108565006
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- resource id collision: 1534585531108565007
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565007' AND NOT (id = '1534585531108565007' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- resource parent identity collision: 1534585531108565007
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- resource id collision: 1534585531108565008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565008' AND NOT (id = '1534585531108565008' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- resource parent identity collision: 1534585531108565008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- resource id collision: 1534585531108565009
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565009' AND NOT (id = '1534585531108565009' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- resource parent identity collision: 1534585531108565009
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- resource id collision: 1534585531108565010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565010' AND NOT (id = '1534585531108565010' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- resource parent identity collision: 1534585531108565010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- resource id collision: 1534585531108565011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565011' AND NOT (id = '1534585531108565011' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- resource parent identity collision: 1534585531108565011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- resource id collision: 1534585531108565012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565012' AND NOT (id = '1534585531108565012' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentCls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- resource parent identity collision: 1534585531108565012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- permission id collision: 1534585531389583371
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583371' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565003')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- permission natural-key collision: 1534585531389583371
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565003' AND id <> '1534585531389583371') THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- permission resource identity collision: 1534585531389583371
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565003' AND NOT (id = '1534585531108565003' AND parent_id = '1346775491550474240' AND name = 'loggingTencentCls' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- permission id collision: 1534585531389583372
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583372' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565004')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- permission natural-key collision: 1534585531389583372
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565004' AND id <> '1534585531389583372') THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- permission resource identity collision: 1534585531389583372
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565004' AND NOT (id = '1534585531108565004' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- permission id collision: 1534585531389583373
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583373' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565005')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- permission natural-key collision: 1534585531389583373
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565005' AND id <> '1534585531389583373') THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- permission resource identity collision: 1534585531389583373
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565005' AND NOT (id = '1534585531108565005' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- permission id collision: 1534585531389583374
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583374' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565006')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- permission natural-key collision: 1534585531389583374
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565006' AND id <> '1534585531389583374') THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- permission resource identity collision: 1534585531389583374
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565006' AND NOT (id = '1534585531108565006' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- permission id collision: 1534585531389583375
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583375' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565007')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- permission natural-key collision: 1534585531389583375
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565007' AND id <> '1534585531389583375') THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- permission resource identity collision: 1534585531389583375
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565007' AND NOT (id = '1534585531108565007' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- permission id collision: 1534585531389583376
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583376' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565008')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- permission natural-key collision: 1534585531389583376
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565008' AND id <> '1534585531389583376') THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- permission resource identity collision: 1534585531389583376
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565008' AND NOT (id = '1534585531108565008' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- permission id collision: 1534585531389583377
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583377' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565009')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- permission natural-key collision: 1534585531389583377
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565009' AND id <> '1534585531389583377') THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- permission resource identity collision: 1534585531389583377
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565009' AND NOT (id = '1534585531108565009' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- permission id collision: 1534585531389583378
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583378' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565010')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- permission natural-key collision: 1534585531389583378
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565010' AND id <> '1534585531389583378') THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- permission resource identity collision: 1534585531389583378
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565010' AND NOT (id = '1534585531108565010' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;

-- permission id collision: 1534585531389583379
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583379' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565011')) THEN 0 ELSE 1 END AS shenyu_preflight_check_86 FROM DUAL;

-- permission natural-key collision: 1534585531389583379
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565011' AND id <> '1534585531389583379') THEN 0 ELSE 1 END AS shenyu_preflight_check_87 FROM DUAL;

-- permission resource identity collision: 1534585531389583379
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565011' AND NOT (id = '1534585531108565011' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentClsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_88 FROM DUAL;

-- permission id collision: 1534585531389583380
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583380' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565012')) THEN 0 ELSE 1 END AS shenyu_preflight_check_89 FROM DUAL;

-- permission natural-key collision: 1534585531389583380
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565012' AND id <> '1534585531389583380') THEN 0 ELSE 1 END AS shenyu_preflight_check_90 FROM DUAL;

-- permission resource identity collision: 1534585531389583380
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565012' AND NOT (id = '1534585531108565012' AND parent_id = '1534585531108565003' AND name = '' AND perms = 'plugin:loggingTencentCls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_91 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822174' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '36')) THEN 0 ELSE 1 END AS shenyu_preflight_check_92 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '36' AND id <> '1801816010882822174') THEN 0 ELSE 1 END AS shenyu_preflight_check_93 FROM DUAL;
