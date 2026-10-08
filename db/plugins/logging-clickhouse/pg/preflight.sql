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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/pg/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '38' AND "name" <> 'loggingClickHouse') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'loggingClickHouse' AND "id" <> '38') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902783524997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524997' AND NOT ("plugin_id" = '38' AND "field" = 'host' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902783524997
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'host' AND "type" = 3 AND "id" <> '1529403902783524997') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902783524998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524998' AND NOT ("plugin_id" = '38' AND "field" = 'port' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902783524998
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'port' AND "type" = 3 AND "id" <> '1529403902783524998') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902783524999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524999' AND NOT ("plugin_id" = '38' AND "field" = 'database' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902783524999
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'database' AND "type" = 2 AND "id" <> '1529403902783524999') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529402613204172800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172800' AND NOT ("plugin_id" = '38' AND "field" = 'username' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529402613204172800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'username' AND "type" = 2 AND "id" <> '1529402613204172800') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529402613204172801
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172801' AND NOT ("plugin_id" = '38' AND "field" = 'password' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529402613204172801
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'password' AND "type" = 2 AND "id" <> '1529402613204172801') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529402613204172827
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172827' AND NOT ("plugin_id" = '38' AND "field" = 'keyword' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529402613204172827
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'keyword' AND "type" = 2 AND "id" <> '1529402613204172827') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529402613204172829
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172829' AND NOT ("plugin_id" = '38' AND "field" = 'maskType' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529402613204172829
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'maskType' AND "type" = 2 AND "id" <> '1529402613204172829') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529402613204172832
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172832' AND NOT ("plugin_id" = '38' AND "field" = 'database' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529402613204172832
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'database' AND "type" = 3 AND "id" <> '1529402613204172832') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1529402613204172833
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172833' AND NOT ("plugin_id" = '38' AND "field" = 'username' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1529402613204172833
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'username' AND "type" = 3 AND "id" <> '1529402613204172833') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1529402613204172834
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172834' AND NOT ("plugin_id" = '38' AND "field" = 'password' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1529402613204172834
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'password' AND "type" = 3 AND "id" <> '1529402613204172834') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- plugin_handle id collision: 1529402613204172835
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172835' AND NOT ("plugin_id" = '38' AND "field" = 'engine' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- plugin_handle natural-key collision: 1529402613204172835
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'engine' AND "type" = 3 AND "id" <> '1529402613204172835') THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- plugin_handle id collision: 1529402613204172836
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172836' AND NOT ("plugin_id" = '38' AND "field" = 'clusterName' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- plugin_handle natural-key collision: 1529402613204172836
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'clusterName' AND "type" = 3 AND "id" <> '1529402613204172836') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- plugin_handle id collision: 1529402613204172737
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172737' AND NOT ("plugin_id" = '38' AND "field" = 'ttl' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- plugin_handle natural-key collision: 1529402613204172737
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'ttl' AND "type" = 3 AND "id" <> '1529402613204172737') THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- plugin_handle id collision: 1722804548510507017
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507017' AND NOT ("plugin_id" = '38' AND "field" = 'sampleRate' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- plugin_handle natural-key collision: 1722804548510507017
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'sampleRate' AND "type" = 1 AND "id" <> '1722804548510507017') THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- plugin_handle id collision: 1722804548510507018
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507018' AND NOT ("plugin_id" = '38' AND "field" = 'sampleRate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- plugin_handle natural-key collision: 1722804548510507018
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '38' AND "field" = 'sampleRate' AND "type" = 3 AND "id" <> '1722804548510507018') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- resource id collision: 1534585531108565043
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- resource id collision: 1534585531108565044
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565044' AND NOT ("id" = '1534585531108565044' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- resource parent identity collision: 1534585531108565044
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- resource id collision: 1534585531108565045
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565045' AND NOT ("id" = '1534585531108565045' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- resource parent identity collision: 1534585531108565045
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- resource id collision: 1534585531108565046
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565046' AND NOT ("id" = '1534585531108565046' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- resource parent identity collision: 1534585531108565046
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- resource id collision: 1534585531108565047
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565047' AND NOT ("id" = '1534585531108565047' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- resource parent identity collision: 1534585531108565047
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- resource id collision: 1534585531108565048
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565048' AND NOT ("id" = '1534585531108565048' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- resource parent identity collision: 1534585531108565048
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- resource id collision: 1534585531108565049
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565049' AND NOT ("id" = '1534585531108565049' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- resource parent identity collision: 1534585531108565049
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- resource id collision: 1534585531108565050
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565050' AND NOT ("id" = '1534585531108565050' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- resource parent identity collision: 1534585531108565050
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- resource id collision: 1534585531108565051
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565051' AND NOT ("id" = '1534585531108565051' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- resource parent identity collision: 1534585531108565051
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- resource id collision: 1534585531108565052
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565052' AND NOT ("id" = '1534585531108565052' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouse:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- resource parent identity collision: 1534585531108565052
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- permission id collision: 1529403932886044820
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044820' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565043')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- permission natural-key collision: 1529403932886044820
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565043' AND "id" <> '1529403932886044820') THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission resource identity collision: 1529403932886044820
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565043' AND NOT ("id" = '1534585531108565043' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingClickHouse' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission id collision: 1529403932886044821
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044821' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565044')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission natural-key collision: 1529403932886044821
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565044' AND "id" <> '1529403932886044821') THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission resource identity collision: 1529403932886044821
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565044' AND NOT ("id" = '1534585531108565044' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission id collision: 1529403932886044822
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044822' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565045')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission natural-key collision: 1529403932886044822
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565045' AND "id" <> '1529403932886044822') THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission resource identity collision: 1529403932886044822
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565045' AND NOT ("id" = '1534585531108565045' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission id collision: 1529403932886044823
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044823' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565046')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission natural-key collision: 1529403932886044823
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565046' AND "id" <> '1529403932886044823') THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission resource identity collision: 1529403932886044823
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565046' AND NOT ("id" = '1534585531108565046' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission id collision: 1529403932886044824
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044824' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565047')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission natural-key collision: 1529403932886044824
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565047' AND "id" <> '1529403932886044824') THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission resource identity collision: 1529403932886044824
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565047' AND NOT ("id" = '1534585531108565047' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission id collision: 1529403932886044825
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044825' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565048')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission natural-key collision: 1529403932886044825
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565048' AND "id" <> '1529403932886044825') THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission resource identity collision: 1529403932886044825
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565048' AND NOT ("id" = '1534585531108565048' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission id collision: 1529403932886044826
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044826' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565049')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission natural-key collision: 1529403932886044826
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565049' AND "id" <> '1529403932886044826') THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- permission resource identity collision: 1529403932886044826
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565049' AND NOT ("id" = '1534585531108565049' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- permission id collision: 1529403932886044827
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044827' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565050')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73;

-- permission natural-key collision: 1529403932886044827
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565050' AND "id" <> '1529403932886044827') THEN 0 ELSE 1 END AS shenyu_preflight_check_74;

-- permission resource identity collision: 1529403932886044827
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565050' AND NOT ("id" = '1534585531108565050' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75;

-- permission id collision: 1529403932886044828
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044828' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565051')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76;

-- permission natural-key collision: 1529403932886044828
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565051' AND "id" <> '1529403932886044828') THEN 0 ELSE 1 END AS shenyu_preflight_check_77;

-- permission resource identity collision: 1529403932886044828
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565051' AND NOT ("id" = '1534585531108565051' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouseRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78;

-- permission id collision: 1529403932886044829
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044829' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565052')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79;

-- permission natural-key collision: 1529403932886044829
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565052' AND "id" <> '1529403932886044829') THEN 0 ELSE 1 END AS shenyu_preflight_check_80;

-- permission resource identity collision: 1529403932886044829
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565052' AND NOT ("id" = '1534585531108565052' AND "parent_id" = '1534585531108565043' AND "name" = '' AND "perms" = 'plugin:loggingClickHouse:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81;

-- namespace_plugin_rel id collision: 1801816010882822175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822175' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '38')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82;

-- namespace_plugin_rel natural-key collision: 1801816010882822175
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '38' AND "id" <> '1801816010882822175') THEN 0 ELSE 1 END AS shenyu_preflight_check_83;
