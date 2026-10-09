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

-- Preflight checks for tars (tars).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/pg/create-table.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "id" = '13' AND "name" <> 'tars') THEN 0 ELSE 1 END AS shenyu_preflight_check_1;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE "name" = 'tars' AND "id" <> '13') THEN 0 ELSE 1 END AS shenyu_preflight_check_2;

-- plugin_handle id collision: 1529403902779330568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330568' AND NOT ("plugin_id" = '13' AND "field" = 'upstreamHost' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3;

-- plugin_handle natural-key collision: 1529403902779330568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'upstreamHost' AND "type" = 1 AND "id" <> '1529403902779330568') THEN 0 ELSE 1 END AS shenyu_preflight_check_4;

-- plugin_handle id collision: 1529403902779330569
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330569' AND NOT ("plugin_id" = '13' AND "field" = 'protocol' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5;

-- plugin_handle natural-key collision: 1529403902779330569
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'protocol' AND "type" = 1 AND "id" <> '1529403902779330569') THEN 0 ELSE 1 END AS shenyu_preflight_check_6;

-- plugin_handle id collision: 1529403902779330570
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330570' AND NOT ("plugin_id" = '13' AND "field" = 'upstreamUrl' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7;

-- plugin_handle natural-key collision: 1529403902779330570
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'upstreamUrl' AND "type" = 1 AND "id" <> '1529403902779330570') THEN 0 ELSE 1 END AS shenyu_preflight_check_8;

-- plugin_handle id collision: 1529403902779330571
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330571' AND NOT ("plugin_id" = '13' AND "field" = 'weight' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9;

-- plugin_handle natural-key collision: 1529403902779330571
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'weight' AND "type" = 1 AND "id" <> '1529403902779330571') THEN 0 ELSE 1 END AS shenyu_preflight_check_10;

-- plugin_handle id collision: 1529403902779330572
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330572' AND NOT ("plugin_id" = '13' AND "field" = 'timestamp' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11;

-- plugin_handle natural-key collision: 1529403902779330572
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'timestamp' AND "type" = 1 AND "id" <> '1529403902779330572') THEN 0 ELSE 1 END AS shenyu_preflight_check_12;

-- plugin_handle id collision: 1529403902779330573
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330573' AND NOT ("plugin_id" = '13' AND "field" = 'warmup' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13;

-- plugin_handle natural-key collision: 1529403902779330573
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'warmup' AND "type" = 1 AND "id" <> '1529403902779330573') THEN 0 ELSE 1 END AS shenyu_preflight_check_14;

-- plugin_handle id collision: 1529403902779330574
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330574' AND NOT ("plugin_id" = '13' AND "field" = 'status' AND "type" = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15;

-- plugin_handle natural-key collision: 1529403902779330574
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'status' AND "type" = 1 AND "id" <> '1529403902779330574') THEN 0 ELSE 1 END AS shenyu_preflight_check_16;

-- plugin_handle id collision: 1529403902779330575
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330575' AND NOT ("plugin_id" = '13' AND "field" = 'loadBalance' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17;

-- plugin_handle natural-key collision: 1529403902779330575
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'loadBalance' AND "type" = 2 AND "id" <> '1529403902779330575') THEN 0 ELSE 1 END AS shenyu_preflight_check_18;

-- plugin_handle id collision: 1529403902779330576
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330576' AND NOT ("plugin_id" = '13' AND "field" = 'retry' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19;

-- plugin_handle natural-key collision: 1529403902779330576
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'retry' AND "type" = 2 AND "id" <> '1529403902779330576') THEN 0 ELSE 1 END AS shenyu_preflight_check_20;

-- plugin_handle id collision: 1529403902779330577
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330577' AND NOT ("plugin_id" = '13' AND "field" = 'timeout' AND "type" = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21;

-- plugin_handle natural-key collision: 1529403902779330577
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'timeout' AND "type" = 2 AND "id" <> '1529403902779330577') THEN 0 ELSE 1 END AS shenyu_preflight_check_22;

-- plugin_handle id collision: 1529403902779330578
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330578' AND NOT ("plugin_id" = '13' AND "field" = 'multiSelectorHandle' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23;

-- plugin_handle natural-key collision: 1529403902779330578
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'multiSelectorHandle' AND "type" = 3 AND "id" <> '1529403902779330578') THEN 0 ELSE 1 END AS shenyu_preflight_check_24;

-- plugin_handle id collision: 1529403902779330579
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902779330579' AND NOT ("plugin_id" = '13' AND "field" = 'multiRuleHandle' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25;

-- plugin_handle natural-key collision: 1529403902779330579
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'multiRuleHandle' AND "type" = 3 AND "id" <> '1529403902779330579') THEN 0 ELSE 1 END AS shenyu_preflight_check_26;

-- plugin_handle id collision: 1529403902783524913
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524913' AND NOT ("plugin_id" = '13' AND "field" = 'corethreads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27;

-- plugin_handle natural-key collision: 1529403902783524913
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'corethreads' AND "type" = 3 AND "id" <> '1529403902783524913') THEN 0 ELSE 1 END AS shenyu_preflight_check_28;

-- plugin_handle id collision: 1529403902783524914
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524914' AND NOT ("plugin_id" = '13' AND "field" = 'threads' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29;

-- plugin_handle natural-key collision: 1529403902783524914
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'threads' AND "type" = 3 AND "id" <> '1529403902783524914') THEN 0 ELSE 1 END AS shenyu_preflight_check_30;

-- plugin_handle id collision: 1529403902783524915
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524915' AND NOT ("plugin_id" = '13' AND "field" = 'queues' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31;

-- plugin_handle natural-key collision: 1529403902783524915
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'queues' AND "type" = 3 AND "id" <> '1529403902783524915') THEN 0 ELSE 1 END AS shenyu_preflight_check_32;

-- plugin_handle id collision: 1529403902783524916
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "id" = '1529403902783524916' AND NOT ("plugin_id" = '13' AND "field" = 'threadpool' AND "type" = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33;

-- plugin_handle natural-key collision: 1529403902783524916
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE "plugin_id" = '13' AND "field" = 'threadpool' AND "type" = 3 AND "id" <> '1529403902783524916') THEN 0 ELSE 1 END AS shenyu_preflight_check_34;

-- resource id collision: 1529403932781187075
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_35;

-- resource id collision: 1529403932877656100
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656100' AND NOT ("id" = '1529403932877656100' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_36;

-- resource parent identity collision: 1529403932877656100
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_37;

-- resource id collision: 1529403932877656101
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656101' AND NOT ("id" = '1529403932877656101' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_38;

-- resource parent identity collision: 1529403932877656101
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_39;

-- resource id collision: 1529403932877656102
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656102' AND NOT ("id" = '1529403932877656102' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_40;

-- resource parent identity collision: 1529403932877656102
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_41;

-- resource id collision: 1529403932877656103
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656103' AND NOT ("id" = '1529403932877656103' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_42;

-- resource parent identity collision: 1529403932877656103
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_43;

-- resource id collision: 1529403932877656104
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656104' AND NOT ("id" = '1529403932877656104' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_44;

-- resource parent identity collision: 1529403932877656104
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_45;

-- resource id collision: 1529403932877656105
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656105' AND NOT ("id" = '1529403932877656105' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_46;

-- resource parent identity collision: 1529403932877656105
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47;

-- resource id collision: 1529403932877656106
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656106' AND NOT ("id" = '1529403932877656106' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48;

-- resource parent identity collision: 1529403932877656106
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49;

-- resource id collision: 1529403932877656107
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656107' AND NOT ("id" = '1529403932877656107' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50;

-- resource parent identity collision: 1529403932877656107
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51;

-- resource id collision: 1529403932877656108
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656108' AND NOT ("id" = '1529403932877656108' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tars:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52;

-- resource parent identity collision: 1529403932877656108
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53;

-- permission id collision: 1529403932797964292
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932797964292' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187075')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54;

-- permission natural-key collision: 1529403932797964292
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932781187075' AND "id" <> '1529403932797964292') THEN 0 ELSE 1 END AS shenyu_preflight_check_55;

-- permission resource identity collision: 1529403932797964292
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932781187075' AND NOT ("id" = '1529403932781187075' AND "parent_id" = '1346775491550474240' AND "name" = 'tars' AND "perms" = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56;

-- permission id collision: 1529403932881850548
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850548' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656100')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57;

-- permission natural-key collision: 1529403932881850548
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656100' AND "id" <> '1529403932881850548') THEN 0 ELSE 1 END AS shenyu_preflight_check_58;

-- permission resource identity collision: 1529403932881850548
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656100' AND NOT ("id" = '1529403932877656100' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59;

-- permission id collision: 1529403932881850549
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850549' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656101')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60;

-- permission natural-key collision: 1529403932881850549
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656101' AND "id" <> '1529403932881850549') THEN 0 ELSE 1 END AS shenyu_preflight_check_61;

-- permission resource identity collision: 1529403932881850549
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656101' AND NOT ("id" = '1529403932877656101' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62;

-- permission id collision: 1529403932881850550
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850550' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656102')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63;

-- permission natural-key collision: 1529403932881850550
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656102' AND "id" <> '1529403932881850550') THEN 0 ELSE 1 END AS shenyu_preflight_check_64;

-- permission resource identity collision: 1529403932881850550
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656102' AND NOT ("id" = '1529403932877656102' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65;

-- permission id collision: 1529403932881850551
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850551' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656103')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66;

-- permission natural-key collision: 1529403932881850551
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656103' AND "id" <> '1529403932881850551') THEN 0 ELSE 1 END AS shenyu_preflight_check_67;

-- permission resource identity collision: 1529403932881850551
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656103' AND NOT ("id" = '1529403932877656103' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68;

-- permission id collision: 1529403932881850552
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850552' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656104')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69;

-- permission natural-key collision: 1529403932881850552
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656104' AND "id" <> '1529403932881850552') THEN 0 ELSE 1 END AS shenyu_preflight_check_70;

-- permission resource identity collision: 1529403932881850552
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656104' AND NOT ("id" = '1529403932877656104' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71;

-- permission id collision: 1529403932881850553
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850553' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656105')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72;

-- permission natural-key collision: 1529403932881850553
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656105' AND "id" <> '1529403932881850553') THEN 0 ELSE 1 END AS shenyu_preflight_check_73;

-- permission resource identity collision: 1529403932881850553
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656105' AND NOT ("id" = '1529403932877656105' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74;

-- permission id collision: 1529403932881850554
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850554' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656106')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75;

-- permission natural-key collision: 1529403932881850554
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656106' AND "id" <> '1529403932881850554') THEN 0 ELSE 1 END AS shenyu_preflight_check_76;

-- permission resource identity collision: 1529403932881850554
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656106' AND NOT ("id" = '1529403932877656106' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77;

-- permission id collision: 1529403932881850555
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850555' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656107')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78;

-- permission natural-key collision: 1529403932881850555
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656107' AND "id" <> '1529403932881850555') THEN 0 ELSE 1 END AS shenyu_preflight_check_79;

-- permission resource identity collision: 1529403932881850555
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656107' AND NOT ("id" = '1529403932877656107' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tarsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80;

-- permission id collision: 1529403932881850556
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "id" = '1529403932881850556' AND NOT ("object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656108')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81;

-- permission natural-key collision: 1529403932881850556
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE "object_id" = '1346358560427216896' AND "resource_id" = '1529403932877656108' AND "id" <> '1529403932881850556') THEN 0 ELSE 1 END AS shenyu_preflight_check_82;

-- permission resource identity collision: 1529403932881850556
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE "id" = '1529403932877656108' AND NOT ("id" = '1529403932877656108' AND "parent_id" = '1529403932781187075' AND "name" = '' AND "perms" = 'plugin:tars:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83;

-- namespace_plugin_rel id collision: 1801816010882822149
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "id" = '1801816010882822149' AND NOT ("namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '13')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84;

-- namespace_plugin_rel natural-key collision: 1801816010882822149
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE "namespace_id" = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND "plugin_id" = '13' AND "id" <> '1801816010882822149') THEN 0 ELSE 1 END AS shenyu_preflight_check_85;
