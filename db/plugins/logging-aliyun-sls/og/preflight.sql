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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/og/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '34' AND "name" <> 'loggingAliyunSls') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'loggingAliyunSls' AND "id" <> '34') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902783524962
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524962' AND NOT ("plugin_id" = '34' AND "field" = 'accessId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902783524962
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'accessId' AND "type" = 3 AND "id" <> '1529403902783524962') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902783524963
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524963' AND NOT ("plugin_id" = '34' AND "field" = 'accessKey' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902783524963
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'accessKey' AND "type" = 3 AND "id" <> '1529403902783524963') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902783524964
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524964' AND NOT ("plugin_id" = '34' AND "field" = 'host' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902783524964
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'host' AND "type" = 3 AND "id" <> '1529403902783524964') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529403902783524965
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524965' AND NOT ("plugin_id" = '34' AND "field" = 'projectName' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529403902783524965
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'projectName' AND "type" = 3 AND "id" <> '1529403902783524965') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902783524966
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524966' AND NOT ("plugin_id" = '34' AND "field" = 'logStoreName' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902783524966
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'logStoreName' AND "type" = 3 AND "id" <> '1529403902783524966') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902783524967
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524967' AND NOT ("plugin_id" = '34' AND "field" = 'topic' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902783524967
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'topic' AND "type" = 3 AND "id" <> '1529403902783524967') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529403902783524968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524968' AND NOT ("plugin_id" = '34' AND "field" = 'ttlInDay' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529403902783524968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'ttlInDay' AND "type" = 3 AND "id" <> '1529403902783524968') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529403902783524969
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524969' AND NOT ("plugin_id" = '34' AND "field" = 'shardCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529403902783524969
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'shardCount' AND "type" = 3 AND "id" <> '1529403902783524969') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1529403902783524970
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524970' AND NOT ("plugin_id" = '34' AND "field" = 'sendThreadCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1529403902783524970
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'sendThreadCount' AND "type" = 3 AND "id" <> '1529403902783524970') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1529403902783524971
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524971' AND NOT ("plugin_id" = '34' AND "field" = 'ioThreadCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1529403902783524971
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'ioThreadCount' AND "type" = 3 AND "id" <> '1529403902783524971') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- plugin_handle id collision: 1529403902783524972
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524972' AND NOT ("plugin_id" = '34' AND "field" = 'sampleRate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- plugin_handle natural-key collision: 1529403902783524972
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'sampleRate' AND "type" = 3 AND "id" <> '1529403902783524972') THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- plugin_handle id collision: 1529403902783524973
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524973' AND NOT ("plugin_id" = '34' AND "field" = 'maxRequestBody' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- plugin_handle natural-key collision: 1529403902783524973
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'maxRequestBody' AND "type" = 3 AND "id" <> '1529403902783524973') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- plugin_handle id collision: 1529403902783524974
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524974' AND NOT ("plugin_id" = '34' AND "field" = 'maxResponseBody' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- plugin_handle natural-key collision: 1529403902783524974
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'maxResponseBody' AND "type" = 3 AND "id" <> '1529403902783524974') THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- plugin_handle id collision: 1529403902783524975
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524975' AND NOT ("plugin_id" = '34' AND "field" = 'bufferQueueSize' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- plugin_handle natural-key collision: 1529403902783524975
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'bufferQueueSize' AND "type" = 3 AND "id" <> '1529403902783524975') THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- plugin_handle id collision: 1529402613204172818
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172818' AND NOT ("plugin_id" = '34' AND "field" = 'keyword' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- plugin_handle natural-key collision: 1529402613204172818
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'keyword' AND "type" = 2 AND "id" <> '1529402613204172818') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- plugin_handle id collision: 1529402613204172819
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172819' AND NOT ("plugin_id" = '34' AND "field" = 'maskType' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- plugin_handle natural-key collision: 1529402613204172819
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'maskType' AND "type" = 2 AND "id" <> '1529402613204172819') THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- plugin_handle id collision: 1529402613204172820
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172820' AND NOT ("plugin_id" = '34' AND "field" = 'maskStatus' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- plugin_handle natural-key collision: 1529402613204172820
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'maskStatus' AND "type" = 2 AND "id" <> '1529402613204172820') THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- plugin_handle id collision: 1722804548510507015
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507015' AND NOT ("plugin_id" = '34' AND "field" = 'sampleRate' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- plugin_handle natural-key collision: 1722804548510507015
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '34' AND "field" = 'sampleRate' AND "type" = 1 AND "id" <> '1722804548510507015') THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- resource id collision: 1534585531108564993
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- resource id collision: 1534585531108564994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564994' AND NOT ("id" = '1534585531108564994' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- resource parent identity collision: 1534585531108564994
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- resource id collision: 1534585531108564995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564995' AND NOT ("id" = '1534585531108564995' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- resource parent identity collision: 1534585531108564995
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- resource id collision: 1534585531108564996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564996' AND NOT ("id" = '1534585531108564996' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- resource parent identity collision: 1534585531108564996
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- resource id collision: 1534585531108564997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564997' AND NOT ("id" = '1534585531108564997' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- resource parent identity collision: 1534585531108564997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- resource id collision: 1534585531108564998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564998' AND NOT ("id" = '1534585531108564998' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- resource parent identity collision: 1534585531108564998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- resource id collision: 1534585531108564999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564999' AND NOT ("id" = '1534585531108564999' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- resource parent identity collision: 1534585531108564999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- resource id collision: 1534585531108565000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565000' AND NOT ("id" = '1534585531108565000' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- resource parent identity collision: 1534585531108565000
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- resource id collision: 1534585531108565001
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565001' AND NOT ("id" = '1534585531108565001' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- resource parent identity collision: 1534585531108565001
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- resource id collision: 1534585531108565002
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565002' AND NOT ("id" = '1534585531108565002' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- resource parent identity collision: 1534585531108565002
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission id collision: 1529403932886044770
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044770' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564993')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission natural-key collision: 1529403932886044770
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564993' AND "id" <> '1529403932886044770') THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission resource identity collision: 1529403932886044770
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564993' AND NOT ("id" = '1534585531108564993' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingAliyunSls' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission id collision: 1529403932886044771
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044771' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564994')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission natural-key collision: 1529403932886044771
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564994' AND "id" <> '1529403932886044771') THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission resource identity collision: 1529403932886044771
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564994' AND NOT ("id" = '1534585531108564994' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission id collision: 1529403932886044772
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044772' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564995')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission natural-key collision: 1529403932886044772
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564995' AND "id" <> '1529403932886044772') THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission resource identity collision: 1529403932886044772
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564995' AND NOT ("id" = '1534585531108564995' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission id collision: 1529403932886044773
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044773' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564996')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission natural-key collision: 1529403932886044773
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564996' AND "id" <> '1529403932886044773') THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission resource identity collision: 1529403932886044773
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564996' AND NOT ("id" = '1534585531108564996' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission id collision: 1529403932886044774
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044774' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564997')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission natural-key collision: 1529403932886044774
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564997' AND "id" <> '1529403932886044774') THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- permission resource identity collision: 1529403932886044774
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564997' AND NOT ("id" = '1534585531108564997' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- permission id collision: 1529403932886044775
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044775' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564998')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73;

-- permission natural-key collision: 1529403932886044775
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564998' AND "id" <> '1529403932886044775') THEN 0 ELSE 1 END AS shenyu_preflight_check_74;

-- permission resource identity collision: 1529403932886044775
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564998' AND NOT ("id" = '1534585531108564998' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75;

-- permission id collision: 1529403932886044776
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044776' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564999')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76;

-- permission natural-key collision: 1529403932886044776
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108564999' AND "id" <> '1529403932886044776') THEN 0 ELSE 1 END AS shenyu_preflight_check_77;

-- permission resource identity collision: 1529403932886044776
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108564999' AND NOT ("id" = '1534585531108564999' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78;

-- permission id collision: 1529403932886044777
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044777' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565000')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79;

-- permission natural-key collision: 1529403932886044777
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565000' AND "id" <> '1529403932886044777') THEN 0 ELSE 1 END AS shenyu_preflight_check_80;

-- permission resource identity collision: 1529403932886044777
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565000' AND NOT ("id" = '1534585531108565000' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81;

-- permission id collision: 1529403932886044778
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044778' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565001')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82;

-- permission natural-key collision: 1529403932886044778
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565001' AND "id" <> '1529403932886044778') THEN 0 ELSE 1 END AS shenyu_preflight_check_83;

-- permission resource identity collision: 1529403932886044778
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565001' AND NOT ("id" = '1534585531108565001' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSlsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84;

-- permission id collision: 1529403932886044779
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044779' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565002')) THEN 0 ELSE 1 END AS shenyu_preflight_check_85;

-- permission natural-key collision: 1529403932886044779
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565002' AND "id" <> '1529403932886044779') THEN 0 ELSE 1 END AS shenyu_preflight_check_86;

-- permission resource identity collision: 1529403932886044779
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565002' AND NOT ("id" = '1534585531108565002' AND "parent_id" = '1534585531108564993' AND "name" = '' AND "perms" = 'plugin:loggingAliyunSls:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_87;

-- namespace_plugin_rel id collision: 1801816010882822172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822172' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '34')) THEN 0 ELSE 1 END AS shenyu_preflight_check_88;

-- namespace_plugin_rel natural-key collision: 1801816010882822172
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '34' AND "id" <> '1801816010882822172') THEN 0 ELSE 1 END AS shenyu_preflight_check_89;
