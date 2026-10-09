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

-- Preflight checks for hystrix (hystrix).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/og/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '9' AND "name" <> 'hystrix') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'hystrix' AND "id" <> '9') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- resource id collision: 1529403932781187095
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- resource id collision: 1529403932881850467
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850467' AND NOT ("id" = '1529403932881850467' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- resource parent identity collision: 1529403932881850467
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- resource id collision: 1529403932881850468
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850468' AND NOT ("id" = '1529403932881850468' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- resource parent identity collision: 1529403932881850468
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- resource id collision: 1529403932881850469
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850469' AND NOT ("id" = '1529403932881850469' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- resource parent identity collision: 1529403932881850469
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- resource id collision: 1529403932881850470
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850470' AND NOT ("id" = '1529403932881850470' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- resource parent identity collision: 1529403932881850470
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- resource id collision: 1529403932881850471
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850471' AND NOT ("id" = '1529403932881850471' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- resource parent identity collision: 1529403932881850471
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- resource id collision: 1529403932881850472
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850472' AND NOT ("id" = '1529403932881850472' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- resource parent identity collision: 1529403932881850472
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- resource id collision: 1529403932881850473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850473' AND NOT ("id" = '1529403932881850473' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- resource parent identity collision: 1529403932881850473
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- resource id collision: 1529403932881850474
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850474' AND NOT ("id" = '1529403932881850474' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- resource parent identity collision: 1529403932881850474
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- resource id collision: 1529403932881850475
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850475' AND NOT ("id" = '1529403932881850475' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrix:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- resource parent identity collision: 1529403932881850475
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- permission id collision: 1529403932797964312
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932797964312' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187095')) THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- permission natural-key collision: 1529403932797964312
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187095' AND "id" <> '1529403932797964312') THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- permission resource identity collision: 1529403932797964312
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187095' AND NOT ("id" = '1529403932781187095' AND "parent_id" = '1346775491550474240' AND "name" = 'hystrix' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- permission id collision: 1529403932886044722
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044722' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850467')) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- permission natural-key collision: 1529403932886044722
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850467' AND "id" <> '1529403932886044722') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- permission resource identity collision: 1529403932886044722
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850467' AND NOT ("id" = '1529403932881850467' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- permission id collision: 1529403932886044723
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044723' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850468')) THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- permission natural-key collision: 1529403932886044723
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850468' AND "id" <> '1529403932886044723') THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- permission resource identity collision: 1529403932886044723
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850468' AND NOT ("id" = '1529403932881850468' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- permission id collision: 1529403932886044724
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044724' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850469')) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- permission natural-key collision: 1529403932886044724
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850469' AND "id" <> '1529403932886044724') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- permission resource identity collision: 1529403932886044724
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850469' AND NOT ("id" = '1529403932881850469' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- permission id collision: 1529403932886044725
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044725' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850470')) THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- permission natural-key collision: 1529403932886044725
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850470' AND "id" <> '1529403932886044725') THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- permission resource identity collision: 1529403932886044725
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850470' AND NOT ("id" = '1529403932881850470' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- permission id collision: 1529403932886044726
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044726' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850471')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- permission natural-key collision: 1529403932886044726
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850471' AND "id" <> '1529403932886044726') THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- permission resource identity collision: 1529403932886044726
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850471' AND NOT ("id" = '1529403932881850471' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- permission id collision: 1529403932886044727
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044727' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850472')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- permission natural-key collision: 1529403932886044727
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850472' AND "id" <> '1529403932886044727') THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- permission resource identity collision: 1529403932886044727
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850472' AND NOT ("id" = '1529403932881850472' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- permission id collision: 1529403932886044728
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044728' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850473')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- permission natural-key collision: 1529403932886044728
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850473' AND "id" <> '1529403932886044728') THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- permission resource identity collision: 1529403932886044728
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850473' AND NOT ("id" = '1529403932881850473' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- permission id collision: 1529403932886044729
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044729' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850474')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- permission natural-key collision: 1529403932886044729
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850474' AND "id" <> '1529403932886044729') THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- permission resource identity collision: 1529403932886044729
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850474' AND NOT ("id" = '1529403932881850474' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrixRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- permission id collision: 1529403932886044730
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932886044730' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850475')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- permission natural-key collision: 1529403932886044730
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932881850475' AND "id" <> '1529403932886044730') THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- permission resource identity collision: 1529403932886044730
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932881850475' AND NOT ("id" = '1529403932881850475' AND "parent_id" = '1529403932781187095' AND "name" = '' AND "perms" = 'plugin:hystrix:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- namespace_plugin_rel id collision: 1801816010882822186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822186' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '9')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- namespace_plugin_rel natural-key collision: 1801816010882822186
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '9' AND "id" <> '1801816010882822186') THEN 0 ELSE 1 END AS shenyu_preflight_check_53;
