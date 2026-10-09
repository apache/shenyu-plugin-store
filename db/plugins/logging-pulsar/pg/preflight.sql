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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/pg/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '35' AND "name" <> 'loggingPulsar') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'loggingPulsar' AND "id" <> '35') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902783524976
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524976' AND NOT ("plugin_id" = '35' AND "field" = 'topic' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902783524976
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'topic' AND "type" = 3 AND "id" <> '1529403902783524976') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902783524977
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524977' AND NOT ("plugin_id" = '35' AND "field" = 'serviceUrl' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902783524977
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'serviceUrl' AND "type" = 3 AND "id" <> '1529403902783524977') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902783524978
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524978' AND NOT ("plugin_id" = '35' AND "field" = 'sampleRate' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902783524978
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'sampleRate' AND "type" = 3 AND "id" <> '1529403902783524978') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529403902783524979
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524979' AND NOT ("plugin_id" = '35' AND "field" = 'maxResponseBody' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529403902783524979
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'maxResponseBody' AND "type" = 3 AND "id" <> '1529403902783524979') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902783524980
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524980' AND NOT ("plugin_id" = '35' AND "field" = 'maxRequestBody' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902783524980
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'maxRequestBody' AND "type" = 3 AND "id" <> '1529403902783524980') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902783524981
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524981' AND NOT ("plugin_id" = '35' AND "field" = 'compressAlg' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902783524981
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'compressAlg' AND "type" = 3 AND "id" <> '1529403902783524981') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529402613204172821
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172821' AND NOT ("plugin_id" = '35' AND "field" = 'keyword' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529402613204172821
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'keyword' AND "type" = 2 AND "id" <> '1529402613204172821') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529402613204172822
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172822' AND NOT ("plugin_id" = '35' AND "field" = 'maskType' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529402613204172822
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'maskType' AND "type" = 2 AND "id" <> '1529402613204172822') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1529402613204172823
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529402613204172823' AND NOT ("plugin_id" = '35' AND "field" = 'maskStatus' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1529402613204172823
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'maskStatus' AND "type" = 2 AND "id" <> '1529402613204172823') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1722804548510507016
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1722804548510507016' AND NOT ("plugin_id" = '35' AND "field" = 'sampleRate' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1722804548510507016
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '35' AND "field" = 'sampleRate' AND "type" = 1 AND "id" <> '1722804548510507016') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- resource id collision: 1534585531108565023
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- resource id collision: 1534585531108565024
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565024' AND NOT ("id" = '1534585531108565024' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- resource parent identity collision: 1534585531108565024
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- resource id collision: 1534585531108565025
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565025' AND NOT ("id" = '1534585531108565025' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- resource parent identity collision: 1534585531108565025
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- resource id collision: 1534585531108565026
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565026' AND NOT ("id" = '1534585531108565026' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- resource parent identity collision: 1534585531108565026
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- resource id collision: 1534585531108565027
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565027' AND NOT ("id" = '1534585531108565027' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- resource parent identity collision: 1534585531108565027
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- resource id collision: 1534585531108565028
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565028' AND NOT ("id" = '1534585531108565028' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- resource parent identity collision: 1534585531108565028
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- resource id collision: 1534585531108565029
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565029' AND NOT ("id" = '1534585531108565029' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- resource parent identity collision: 1534585531108565029
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- resource id collision: 1534585531108565030
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565030' AND NOT ("id" = '1534585531108565030' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- resource parent identity collision: 1534585531108565030
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- resource id collision: 1534585531108565031
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565031' AND NOT ("id" = '1534585531108565031' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- resource parent identity collision: 1534585531108565031
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- resource id collision: 1534585531108565032
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565032' AND NOT ("id" = '1534585531108565032' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsar:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- resource parent identity collision: 1534585531108565032
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- permission id collision: 1529403932886044800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044800' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565023')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- permission natural-key collision: 1529403932886044800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565023' AND "id" <> '1529403932886044800') THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- permission resource identity collision: 1529403932886044800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565023' AND NOT ("id" = '1534585531108565023' AND "parent_id" = '1346775491550474240' AND "name" = 'loggingPulsar' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- permission id collision: 1529403932886044801
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044801' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565024')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- permission natural-key collision: 1529403932886044801
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565024' AND "id" <> '1529403932886044801') THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- permission resource identity collision: 1529403932886044801
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565024' AND NOT ("id" = '1534585531108565024' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- permission id collision: 1529403932886044802
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044802' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565025')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- permission natural-key collision: 1529403932886044802
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565025' AND "id" <> '1529403932886044802') THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- permission resource identity collision: 1529403932886044802
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565025' AND NOT ("id" = '1534585531108565025' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- permission id collision: 1529403932886044803
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044803' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565026')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- permission natural-key collision: 1529403932886044803
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565026' AND "id" <> '1529403932886044803') THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- permission resource identity collision: 1529403932886044803
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565026' AND NOT ("id" = '1534585531108565026' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission id collision: 1529403932886044804
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044804' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565027')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission natural-key collision: 1529403932886044804
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565027' AND "id" <> '1529403932886044804') THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission resource identity collision: 1529403932886044804
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565027' AND NOT ("id" = '1534585531108565027' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission id collision: 1529403932886044805
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044805' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565028')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission natural-key collision: 1529403932886044805
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565028' AND "id" <> '1529403932886044805') THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission resource identity collision: 1529403932886044805
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565028' AND NOT ("id" = '1534585531108565028' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission id collision: 1529403932886044806
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044806' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565029')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission natural-key collision: 1529403932886044806
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565029' AND "id" <> '1529403932886044806') THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission resource identity collision: 1529403932886044806
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565029' AND NOT ("id" = '1534585531108565029' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission id collision: 1529403932886044807
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044807' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565030')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission natural-key collision: 1529403932886044807
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565030' AND "id" <> '1529403932886044807') THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission resource identity collision: 1529403932886044807
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565030' AND NOT ("id" = '1534585531108565030' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission id collision: 1529403932886044808
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044808' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565031')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission natural-key collision: 1529403932886044808
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565031' AND "id" <> '1529403932886044808') THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission resource identity collision: 1529403932886044808
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565031' AND NOT ("id" = '1534585531108565031' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsarRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission id collision: 1529403932886044809
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044809' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565032')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission natural-key collision: 1529403932886044809
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1534585531108565032' AND "id" <> '1529403932886044809') THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission resource identity collision: 1529403932886044809
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1534585531108565032' AND NOT ("id" = '1534585531108565032' AND "parent_id" = '1534585531108565023' AND "name" = '' AND "perms" = 'plugin:loggingPulsar:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- namespace_plugin_rel id collision: 1801816010882822173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822173' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '35')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- namespace_plugin_rel natural-key collision: 1801816010882822173
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '35' AND "id" <> '1801816010882822173') THEN 0 ELSE 1 END AS shenyu_preflight_check_73;
