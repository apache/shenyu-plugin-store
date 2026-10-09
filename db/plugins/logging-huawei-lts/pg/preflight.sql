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

-- Preflight checks for logging-huawei-lts (loggingHuaweiLts).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/pg/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '43' AND "name" <> 'loggingHuaweiLts') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'loggingHuaweiLts' AND "id" <> '43') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1570591265492312065
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312065' AND NOT ("plugin_id" = '43' AND "field" = 'projectId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1570591265492312065
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'projectId' AND "type" = 3 AND "id" <> '1570591265492312065') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1570591265492312066
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312066' AND NOT ("plugin_id" = '43' AND "field" = 'logGroupId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1570591265492312066
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'logGroupId' AND "type" = 3 AND "id" <> '1570591265492312066') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1570591265492312067
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312067' AND NOT ("plugin_id" = '43' AND "field" = 'logStreamId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1570591265492312067
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'logStreamId' AND "type" = 3 AND "id" <> '1570591265492312067') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1570591265492312068
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312068' AND NOT ("plugin_id" = '43' AND "field" = 'accessKeyId' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1570591265492312068
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'accessKeyId' AND "type" = 3 AND "id" <> '1570591265492312068') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1570591265492312069
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312069' AND NOT ("plugin_id" = '43' AND "field" = 'accessKeySecret' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1570591265492312069
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'accessKeySecret' AND "type" = 3 AND "id" <> '1570591265492312069') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1570591265492312070
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312070' AND NOT ("plugin_id" = '43' AND "field" = 'regionName' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1570591265492312070
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'regionName' AND "type" = 3 AND "id" <> '1570591265492312070') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1570591265492312071
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312071' AND NOT ("plugin_id" = '43' AND "field" = 'totalSizeInBytes' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1570591265492312071
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'totalSizeInBytes' AND "type" = 3 AND "id" <> '1570591265492312071') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1570591265492312072
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312072' AND NOT ("plugin_id" = '43' AND "field" = 'maxBlockMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1570591265492312072
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'maxBlockMs' AND "type" = 3 AND "id" <> '1570591265492312072') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1570591265492312073
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312073' AND NOT ("plugin_id" = '43' AND "field" = 'ioThreadCount' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1570591265492312073
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'ioThreadCount' AND "type" = 3 AND "id" <> '1570591265492312073') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1570591265492312074
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312074' AND NOT ("plugin_id" = '43' AND "field" = 'batchSizeThresholdInBytes' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1570591265492312074
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'batchSizeThresholdInBytes' AND "type" = 3 AND "id" <> '1570591265492312074') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- plugin_handle id collision: 1570591265492312075
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312075' AND NOT ("plugin_id" = '43' AND "field" = 'batchCountThreshold' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- plugin_handle natural-key collision: 1570591265492312075
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'batchCountThreshold' AND "type" = 3 AND "id" <> '1570591265492312075') THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- plugin_handle id collision: 1570591265492312076
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312076' AND NOT ("plugin_id" = '43' AND "field" = 'lingerMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- plugin_handle natural-key collision: 1570591265492312076
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'lingerMs' AND "type" = 3 AND "id" <> '1570591265492312076') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- plugin_handle id collision: 1570591265492312077
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312077' AND NOT ("plugin_id" = '43' AND "field" = 'retries' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- plugin_handle natural-key collision: 1570591265492312077
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'retries' AND "type" = 3 AND "id" <> '1570591265492312077') THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- plugin_handle id collision: 1570591265492312078
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312078' AND NOT ("plugin_id" = '43' AND "field" = 'baseRetryBackoffMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- plugin_handle natural-key collision: 1570591265492312078
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'baseRetryBackoffMs' AND "type" = 3 AND "id" <> '1570591265492312078') THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- plugin_handle id collision: 1570591265492312079
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312079' AND NOT ("plugin_id" = '43' AND "field" = 'maxRetryBackoffMs' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- plugin_handle natural-key collision: 1570591265492312079
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'maxRetryBackoffMs' AND "type" = 3 AND "id" <> '1570591265492312079') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- plugin_handle id collision: 1570591265492312080
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312080' AND NOT ("plugin_id" = '43' AND "field" = 'enableLocalTest' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- plugin_handle natural-key collision: 1570591265492312080
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'enableLocalTest' AND "type" = 3 AND "id" <> '1570591265492312080') THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- plugin_handle id collision: 1570591265492312081
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312081' AND NOT ("plugin_id" = '43' AND "field" = 'setGiveUpExtraLongSingleLog' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- plugin_handle natural-key collision: 1570591265492312081
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'setGiveUpExtraLongSingleLog' AND "type" = 3 AND "id" <> '1570591265492312081') THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- plugin_handle id collision: 1570591265492312082
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312082' AND NOT ("plugin_id" = '43' AND "field" = 'keyword' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- plugin_handle natural-key collision: 1570591265492312082
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'keyword' AND "type" = 2 AND "id" <> '1570591265492312082') THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- plugin_handle id collision: 1570591265492312083
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312083' AND NOT ("plugin_id" = '43' AND "field" = 'maskType' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- plugin_handle natural-key collision: 1570591265492312083
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'maskType' AND "type" = 2 AND "id" <> '1570591265492312083') THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- plugin_handle id collision: 1570591265492312084
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1570591265492312084' AND NOT ("plugin_id" = '43' AND "field" = 'maskStatus' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- plugin_handle natural-key collision: 1570591265492312084
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'maskStatus' AND "type" = 2 AND "id" <> '1570591265492312084') THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- plugin_handle id collision: 1722804548510507011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507011' AND NOT ("plugin_id" = '43' AND "field" = 'sampleRate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- plugin_handle natural-key collision: 1722804548510507011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'sampleRate' AND "type" = 3 AND "id" <> '1722804548510507011') THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- plugin_handle id collision: 1722804548510507012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507012' AND NOT ("plugin_id" = '43' AND "field" = 'sampleRate' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- plugin_handle natural-key collision: 1722804548510507012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '43' AND "field" = 'sampleRate' AND "type" = 1 AND "id" <> '1722804548510507012') THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- resource id collision: 1572525965625266177
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- resource id collision: 1572525965625266178
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266178' AND NOT ("id" = '1572525965625266178' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- resource parent identity collision: 1572525965625266178
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- resource id collision: 1572525965625266179
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266179' AND NOT ("id" = '1572525965625266179' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- resource parent identity collision: 1572525965625266179
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- resource id collision: 1572525965625266180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266180' AND NOT ("id" = '1572525965625266180' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- resource parent identity collision: 1572525965625266180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- resource id collision: 1572525965625266181
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266181' AND NOT ("id" = '1572525965625266181' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- resource parent identity collision: 1572525965625266181
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- resource id collision: 1572525965625266182
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266182' AND NOT ("id" = '1572525965625266182' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- resource parent identity collision: 1572525965625266182
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- resource id collision: 1572525965625266183
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266183' AND NOT ("id" = '1572525965625266183' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- resource parent identity collision: 1572525965625266183
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- resource id collision: 1572525965625266184
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266184' AND NOT ("id" = '1572525965625266184' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- resource parent identity collision: 1572525965625266184
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- resource id collision: 1572525965625266185
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266185' AND NOT ("id" = '1572525965625266185' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- resource parent identity collision: 1572525965625266185
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- resource id collision: 1572525965625266186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266186' AND NOT ("id" = '1572525965625266186' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- resource parent identity collision: 1572525965625266186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission id collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820609' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266177')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission natural-key collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266177' AND "id" <> '1572525965658820609') THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission resource identity collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266177' AND NOT ("id" = '1572525965625266177' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingHuaweiLts' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission id collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820610' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266178')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission natural-key collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266178' AND "id" <> '1572525965658820610') THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission resource identity collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266178' AND NOT ("id" = '1572525965625266178' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- permission id collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820611' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266179')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- permission natural-key collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266179' AND "id" <> '1572525965658820611') THEN 0 ELSE 1 END AS shenyu_preflight_check_73;

-- permission resource identity collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266179' AND NOT ("id" = '1572525965625266179' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74;

-- permission id collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820612' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266180')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75;

-- permission natural-key collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266180' AND "id" <> '1572525965658820612') THEN 0 ELSE 1 END AS shenyu_preflight_check_76;

-- permission resource identity collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266180' AND NOT ("id" = '1572525965625266180' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77;

-- permission id collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820613' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266181')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78;

-- permission natural-key collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266181' AND "id" <> '1572525965658820613') THEN 0 ELSE 1 END AS shenyu_preflight_check_79;

-- permission resource identity collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266181' AND NOT ("id" = '1572525965625266181' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80;

-- permission id collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820614' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266182')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81;

-- permission natural-key collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266182' AND "id" <> '1572525965658820614') THEN 0 ELSE 1 END AS shenyu_preflight_check_82;

-- permission resource identity collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266182' AND NOT ("id" = '1572525965625266182' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83;

-- permission id collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820615' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266183')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84;

-- permission natural-key collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266183' AND "id" <> '1572525965658820615') THEN 0 ELSE 1 END AS shenyu_preflight_check_85;

-- permission resource identity collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266183' AND NOT ("id" = '1572525965625266183' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_86;

-- permission id collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820616' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266184')) THEN 0 ELSE 1 END AS shenyu_preflight_check_87;

-- permission natural-key collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266184' AND "id" <> '1572525965658820616') THEN 0 ELSE 1 END AS shenyu_preflight_check_88;

-- permission resource identity collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266184' AND NOT ("id" = '1572525965625266184' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_89;

-- permission id collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820617' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266185')) THEN 0 ELSE 1 END AS shenyu_preflight_check_90;

-- permission natural-key collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266185' AND "id" <> '1572525965658820617') THEN 0 ELSE 1 END AS shenyu_preflight_check_91;

-- permission resource identity collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266185' AND NOT ("id" = '1572525965625266185' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_92;

-- permission id collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1572525965658820618' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266186')) THEN 0 ELSE 1 END AS shenyu_preflight_check_93;

-- permission natural-key collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1572525965625266186' AND "id" <> '1572525965658820618') THEN 0 ELSE 1 END AS shenyu_preflight_check_94;

-- permission resource identity collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1572525965625266186' AND NOT ("id" = '1572525965625266186' AND "parent_id" = '1572525965625266177' AND "name" = '' AND "perms" = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_95;

-- namespace_plugin_rel id collision: 1801816010882822180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822180' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '43')) THEN 0 ELSE 1 END AS shenyu_preflight_check_96;

-- namespace_plugin_rel natural-key collision: 1801816010882822180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '43' AND "id" <> '1801816010882822180') THEN 0 ELSE 1 END AS shenyu_preflight_check_97;
