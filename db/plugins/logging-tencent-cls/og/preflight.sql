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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/og/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '36' AND "name" <> 'loggingTencentCls') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'loggingTencentCls' AND "id" <> '36') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902783524982
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524982' AND NOT ("plugin_id" = '36' AND "field" = 'secretId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902783524982
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'secretId' AND "type" = 3 AND "id" <> '1529403902783524982') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902783524983
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524983' AND NOT ("plugin_id" = '36' AND "field" = 'secretKey' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902783524983
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'secretKey' AND "type" = 3 AND "id" <> '1529403902783524983') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902783524984
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524984' AND NOT ("plugin_id" = '36' AND "field" = 'endpoint' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902783524984
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'endpoint' AND "type" = 3 AND "id" <> '1529403902783524984') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529403902783524985
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524985' AND NOT ("plugin_id" = '36' AND "field" = 'topic' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529403902783524985
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'topic' AND "type" = 3 AND "id" <> '1529403902783524985') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902783524986
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524986' AND NOT ("plugin_id" = '36' AND "field" = 'sendThreadCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902783524986
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'sendThreadCount' AND "type" = 3 AND "id" <> '1529403902783524986') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902783524987
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524987' AND NOT ("plugin_id" = '36' AND "field" = 'totalSizeInBytes' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902783524987
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'totalSizeInBytes' AND "type" = 3 AND "id" <> '1529403902783524987') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529403902783524988
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524988' AND NOT ("plugin_id" = '36' AND "field" = 'maxSendThreadCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529403902783524988
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxSendThreadCount' AND "type" = 3 AND "id" <> '1529403902783524988') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529403902783524989
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524989' AND NOT ("plugin_id" = '36' AND "field" = 'maxBlockSec' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529403902783524989
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxBlockSec' AND "type" = 3 AND "id" <> '1529403902783524989') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1529403902783524990
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524990' AND NOT ("plugin_id" = '36' AND "field" = 'maxBatchSize' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1529403902783524990
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxBatchSize' AND "type" = 3 AND "id" <> '1529403902783524990') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1529403902783524991
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524991' AND NOT ("plugin_id" = '36' AND "field" = 'maxBatchCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1529403902783524991
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxBatchCount' AND "type" = 3 AND "id" <> '1529403902783524991') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- plugin_handle id collision: 1529403902783524992
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524992' AND NOT ("plugin_id" = '36' AND "field" = 'lingerMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- plugin_handle natural-key collision: 1529403902783524992
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'lingerMs' AND "type" = 3 AND "id" <> '1529403902783524992') THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- plugin_handle id collision: 1529403902783524993
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524993' AND NOT ("plugin_id" = '36' AND "field" = 'retries' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- plugin_handle natural-key collision: 1529403902783524993
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'retries' AND "type" = 3 AND "id" <> '1529403902783524993') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- plugin_handle id collision: 1529403902783524994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524994' AND NOT ("plugin_id" = '36' AND "field" = 'maxReservedAttempts' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- plugin_handle natural-key collision: 1529403902783524994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxReservedAttempts' AND "type" = 3 AND "id" <> '1529403902783524994') THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- plugin_handle id collision: 1529403902783524995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524995' AND NOT ("plugin_id" = '36' AND "field" = 'baseRetryBackoffMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- plugin_handle natural-key collision: 1529403902783524995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'baseRetryBackoffMs' AND "type" = 3 AND "id" <> '1529403902783524995') THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- plugin_handle id collision: 1529403902783524996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524996' AND NOT ("plugin_id" = '36' AND "field" = 'maxRetryBackoffMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- plugin_handle natural-key collision: 1529403902783524996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maxRetryBackoffMs' AND "type" = 3 AND "id" <> '1529403902783524996') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- plugin_handle id collision: 1529402613204172824
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172824' AND NOT ("plugin_id" = '36' AND "field" = 'keyword' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- plugin_handle natural-key collision: 1529402613204172824
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'keyword' AND "type" = 2 AND "id" <> '1529402613204172824') THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- plugin_handle id collision: 1529402613204172825
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172825' AND NOT ("plugin_id" = '36' AND "field" = 'maskType' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- plugin_handle natural-key collision: 1529402613204172825
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maskType' AND "type" = 2 AND "id" <> '1529402613204172825') THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- plugin_handle id collision: 1529402613204172826
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172826' AND NOT ("plugin_id" = '36' AND "field" = 'maskStatus' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- plugin_handle natural-key collision: 1529402613204172826
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'maskStatus' AND "type" = 2 AND "id" <> '1529402613204172826') THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- plugin_handle id collision: 1722804548510507013
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507013' AND NOT ("plugin_id" = '36' AND "field" = 'sampleRate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- plugin_handle natural-key collision: 1722804548510507013
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'sampleRate' AND "type" = 3 AND "id" <> '1722804548510507013') THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- plugin_handle id collision: 1722804548510507014
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507014' AND NOT ("plugin_id" = '36' AND "field" = 'sampleRate' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- plugin_handle natural-key collision: 1722804548510507014
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '36' AND "field" = 'sampleRate' AND "type" = 1 AND "id" <> '1722804548510507014') THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- resource id collision: 1534585531108565003
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- resource id collision: 1534585531108565004
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565004' AND NOT ("id" = '1534585531108565004' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- resource parent identity collision: 1534585531108565004
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- resource id collision: 1534585531108565005
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565005' AND NOT ("id" = '1534585531108565005' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- resource parent identity collision: 1534585531108565005
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- resource id collision: 1534585531108565006
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565006' AND NOT ("id" = '1534585531108565006' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- resource parent identity collision: 1534585531108565006
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- resource id collision: 1534585531108565007
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565007' AND NOT ("id" = '1534585531108565007' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- resource parent identity collision: 1534585531108565007
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- resource id collision: 1534585531108565008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565008' AND NOT ("id" = '1534585531108565008' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- resource parent identity collision: 1534585531108565008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- resource id collision: 1534585531108565009
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565009' AND NOT ("id" = '1534585531108565009' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- resource parent identity collision: 1534585531108565009
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- resource id collision: 1534585531108565010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565010' AND NOT ("id" = '1534585531108565010' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- resource parent identity collision: 1534585531108565010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- resource id collision: 1534585531108565011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565011' AND NOT ("id" = '1534585531108565011' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- resource parent identity collision: 1534585531108565011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- resource id collision: 1534585531108565012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565012' AND NOT ("id" = '1534585531108565012' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentCls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- resource parent identity collision: 1534585531108565012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission id collision: 1529403932886044780
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044780' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565003')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission natural-key collision: 1529403932886044780
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565003' AND "id" <> '1529403932886044780') THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission resource identity collision: 1529403932886044780
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565003' AND NOT ("id" = '1534585531108565003' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingTencentCls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission id collision: 1529403932886044781
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044781' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565004')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission natural-key collision: 1529403932886044781
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565004' AND "id" <> '1529403932886044781') THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission resource identity collision: 1529403932886044781
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565004' AND NOT ("id" = '1534585531108565004' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission id collision: 1529403932886044782
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044782' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565005')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission natural-key collision: 1529403932886044782
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565005' AND "id" <> '1529403932886044782') THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission resource identity collision: 1529403932886044782
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565005' AND NOT ("id" = '1534585531108565005' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission id collision: 1529403932886044783
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044783' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565006')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- permission natural-key collision: 1529403932886044783
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565006' AND "id" <> '1529403932886044783') THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- permission resource identity collision: 1529403932886044783
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565006' AND NOT ("id" = '1534585531108565006' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73;

-- permission id collision: 1529403932886044784
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044784' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565007')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74;

-- permission natural-key collision: 1529403932886044784
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565007' AND "id" <> '1529403932886044784') THEN 0 ELSE 1 END AS shenyu_preflight_check_75;

-- permission resource identity collision: 1529403932886044784
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565007' AND NOT ("id" = '1534585531108565007' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76;

-- permission id collision: 1529403932886044785
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044785' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565008')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77;

-- permission natural-key collision: 1529403932886044785
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565008' AND "id" <> '1529403932886044785') THEN 0 ELSE 1 END AS shenyu_preflight_check_78;

-- permission resource identity collision: 1529403932886044785
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565008' AND NOT ("id" = '1534585531108565008' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79;

-- permission id collision: 1529403932886044786
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044786' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565009')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80;

-- permission natural-key collision: 1529403932886044786
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565009' AND "id" <> '1529403932886044786') THEN 0 ELSE 1 END AS shenyu_preflight_check_81;

-- permission resource identity collision: 1529403932886044786
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565009' AND NOT ("id" = '1534585531108565009' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82;

-- permission id collision: 1529403932886044787
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044787' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565010')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83;

-- permission natural-key collision: 1529403932886044787
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565010' AND "id" <> '1529403932886044787') THEN 0 ELSE 1 END AS shenyu_preflight_check_84;

-- permission resource identity collision: 1529403932886044787
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565010' AND NOT ("id" = '1534585531108565010' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_85;

-- permission id collision: 1529403932886044788
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044788' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565011')) THEN 0 ELSE 1 END AS shenyu_preflight_check_86;

-- permission natural-key collision: 1529403932886044788
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565011' AND "id" <> '1529403932886044788') THEN 0 ELSE 1 END AS shenyu_preflight_check_87;

-- permission resource identity collision: 1529403932886044788
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565011' AND NOT ("id" = '1534585531108565011' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentClsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_88;

-- permission id collision: 1529403932886044789
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044789' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565012')) THEN 0 ELSE 1 END AS shenyu_preflight_check_89;

-- permission natural-key collision: 1529403932886044789
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565012' AND "id" <> '1529403932886044789') THEN 0 ELSE 1 END AS shenyu_preflight_check_90;

-- permission resource identity collision: 1529403932886044789
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565012' AND NOT ("id" = '1534585531108565012' AND "parent_id" = '1534585531108565003' AND "name" = '' AND "perms" = 'plugin:loggingTencentCls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_91;

-- namespace_plugin_rel id collision: 1801816010882822174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822174' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '36')) THEN 0 ELSE 1 END AS shenyu_preflight_check_92;

-- namespace_plugin_rel natural-key collision: 1801816010882822174
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '36' AND "id" <> '1801816010882822174') THEN 0 ELSE 1 END AS shenyu_preflight_check_93;
