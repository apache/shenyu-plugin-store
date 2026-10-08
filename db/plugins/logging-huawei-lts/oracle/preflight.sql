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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/oracle/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '43' AND name <> 'loggingHuaweiLts') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingHuaweiLts' AND id <> '43') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1529402613204172863
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172863' AND NOT (plugin_id = '43' AND field = 'projectId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172863
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'projectId' AND type = 3 AND id <> '1529402613204172863') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1529402613204172864
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172864' AND NOT (plugin_id = '43' AND field = 'logGroupId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172864
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'logGroupId' AND type = 3 AND id <> '1529402613204172864') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1529402613204172865
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172865' AND NOT (plugin_id = '43' AND field = 'logStreamId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172865
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'logStreamId' AND type = 3 AND id <> '1529402613204172865') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1529402613204172866
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172866' AND NOT (plugin_id = '43' AND field = 'accessKeyId' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172866
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'accessKeyId' AND type = 3 AND id <> '1529402613204172866') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1529402613204172867
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172867' AND NOT (plugin_id = '43' AND field = 'accessKeySecret' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172867
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'accessKeySecret' AND type = 3 AND id <> '1529402613204172867') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1529402613204172868
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172868' AND NOT (plugin_id = '43' AND field = 'regionName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172868
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'regionName' AND type = 3 AND id <> '1529402613204172868') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1529402613204172869
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172869' AND NOT (plugin_id = '43' AND field = 'totalSizeInBytes' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172869
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'totalSizeInBytes' AND type = 3 AND id <> '1529402613204172869') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1529402613204172870
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172870' AND NOT (plugin_id = '43' AND field = 'maxBlockMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172870
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maxBlockMs' AND type = 3 AND id <> '1529402613204172870') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1529402613204172871
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172871' AND NOT (plugin_id = '43' AND field = 'ioThreadCount' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172871
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'ioThreadCount' AND type = 3 AND id <> '1529402613204172871') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1529402613204172872
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172872' AND NOT (plugin_id = '43' AND field = 'batchSizeThresholdInBytes' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172872
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'batchSizeThresholdInBytes' AND type = 3 AND id <> '1529402613204172872') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 1529402613204172873
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172873' AND NOT (plugin_id = '43' AND field = 'batchCountThreshold' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172873
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'batchCountThreshold' AND type = 3 AND id <> '1529402613204172873') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 1529402613204172874
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172874' AND NOT (plugin_id = '43' AND field = 'lingerMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172874
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'lingerMs' AND type = 3 AND id <> '1529402613204172874') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 1529402613204172875
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172875' AND NOT (plugin_id = '43' AND field = 'retries' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172875
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'retries' AND type = 3 AND id <> '1529402613204172875') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 1529402613204172876
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172876' AND NOT (plugin_id = '43' AND field = 'baseRetryBackoffMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172876
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'baseRetryBackoffMs' AND type = 3 AND id <> '1529402613204172876') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1529402613204172877
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172877' AND NOT (plugin_id = '43' AND field = 'maxRetryBackoffMs' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172877
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maxRetryBackoffMs' AND type = 3 AND id <> '1529402613204172877') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1529402613204172878
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172878' AND NOT (plugin_id = '43' AND field = 'enableLocalTest' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172878
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'enableLocalTest' AND type = 3 AND id <> '1529402613204172878') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- plugin_handle id collision: 1529402613204172879
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172879' AND NOT (plugin_id = '43' AND field = 'setGiveUpExtraLongSingleLog' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172879
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'setGiveUpExtraLongSingleLog' AND type = 3 AND id <> '1529402613204172879') THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- plugin_handle id collision: 1529402613204172880
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172880' AND NOT (plugin_id = '43' AND field = 'maskStatus' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172880
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172880') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- plugin_handle id collision: 1529402613204172881
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172881' AND NOT (plugin_id = '43' AND field = 'keyword' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172881
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172881') THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- plugin_handle id collision: 1529402613204172882
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172882' AND NOT (plugin_id = '43' AND field = 'maskType' AND type = 2)) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- plugin_handle natural-key collision: 1529402613204172882
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172882') THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- plugin_handle id collision: 1722804548510507012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507012' AND NOT (plugin_id = '43' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507012
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507012') THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- plugin_handle id collision: 1722804548510507013
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507013' AND NOT (plugin_id = '43' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507013
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '43' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507013') THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- resource id collision: 1676471945048780800
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- resource id collision: 1676471945124278272
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278272' AND NOT (id = '1676471945124278272' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- resource parent identity collision: 1676471945124278272
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- resource id collision: 1676471945124278273
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278273' AND NOT (id = '1676471945124278273' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- resource parent identity collision: 1676471945124278273
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- resource id collision: 1676471945124278274
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278274' AND NOT (id = '1676471945124278274' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- resource parent identity collision: 1676471945124278274
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- resource id collision: 1676471945124278275
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278275' AND NOT (id = '1676471945124278275' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- resource parent identity collision: 1676471945124278275
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- resource id collision: 1676471945124278276
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278276' AND NOT (id = '1676471945124278276' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- resource parent identity collision: 1676471945124278276
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- resource id collision: 1676471945124278277
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278277' AND NOT (id = '1676471945124278277' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- resource parent identity collision: 1676471945124278277
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- resource id collision: 1676471945124278278
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278278' AND NOT (id = '1676471945124278278' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- resource parent identity collision: 1676471945124278278
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- resource id collision: 1676471945124278279
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278279' AND NOT (id = '1676471945124278279' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- resource parent identity collision: 1676471945124278279
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- resource id collision: 1676471945124278280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278280' AND NOT (id = '1676471945124278280' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- resource parent identity collision: 1676471945124278280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- resource id collision: 1792749362361954343
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- resource id collision: 1792749362445840438
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840438' AND NOT (id = '1792749362445840438' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- resource parent identity collision: 1792749362445840438
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- resource id collision: 1792749362445840439
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840439' AND NOT (id = '1792749362445840439' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- resource parent identity collision: 1792749362445840439
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- resource id collision: 1792749362445840440
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840440' AND NOT (id = '1792749362445840440' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- resource parent identity collision: 1792749362445840440
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- resource id collision: 1792749362445840441
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840441' AND NOT (id = '1792749362445840441' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- resource parent identity collision: 1792749362445840441
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- resource id collision: 1792749362445840442
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840442' AND NOT (id = '1792749362445840442' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- resource parent identity collision: 1792749362445840442
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- resource id collision: 1792749362445840443
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840443' AND NOT (id = '1792749362445840443' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- resource parent identity collision: 1792749362445840443
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- resource id collision: 1792749362445840444
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840444' AND NOT (id = '1792749362445840444' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- resource parent identity collision: 1792749362445840444
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- resource id collision: 1792749362445840445
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840445' AND NOT (id = '1792749362445840445' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- resource parent identity collision: 1792749362445840445
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- resource id collision: 1792749362445840446
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840446' AND NOT (id = '1792749362445840446' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- resource parent identity collision: 1792749362445840446
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- permission id collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820609' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945048780800')) THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;

-- permission natural-key collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945048780800' AND id <> '1572525965658820609') THEN 0 ELSE 1 END AS shenyu_preflight_check_86 FROM DUAL;

-- permission resource identity collision: 1572525965658820609
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945048780800' AND NOT (id = '1676471945048780800' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_87 FROM DUAL;

-- permission id collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820610' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278272')) THEN 0 ELSE 1 END AS shenyu_preflight_check_88 FROM DUAL;

-- permission natural-key collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278272' AND id <> '1572525965658820610') THEN 0 ELSE 1 END AS shenyu_preflight_check_89 FROM DUAL;

-- permission resource identity collision: 1572525965658820610
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278272' AND NOT (id = '1676471945124278272' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_90 FROM DUAL;

-- permission id collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820611' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278273')) THEN 0 ELSE 1 END AS shenyu_preflight_check_91 FROM DUAL;

-- permission natural-key collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278273' AND id <> '1572525965658820611') THEN 0 ELSE 1 END AS shenyu_preflight_check_92 FROM DUAL;

-- permission resource identity collision: 1572525965658820611
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278273' AND NOT (id = '1676471945124278273' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_93 FROM DUAL;

-- permission id collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820612' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278274')) THEN 0 ELSE 1 END AS shenyu_preflight_check_94 FROM DUAL;

-- permission natural-key collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278274' AND id <> '1572525965658820612') THEN 0 ELSE 1 END AS shenyu_preflight_check_95 FROM DUAL;

-- permission resource identity collision: 1572525965658820612
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278274' AND NOT (id = '1676471945124278274' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_96 FROM DUAL;

-- permission id collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820613' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278275')) THEN 0 ELSE 1 END AS shenyu_preflight_check_97 FROM DUAL;

-- permission natural-key collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278275' AND id <> '1572525965658820613') THEN 0 ELSE 1 END AS shenyu_preflight_check_98 FROM DUAL;

-- permission resource identity collision: 1572525965658820613
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278275' AND NOT (id = '1676471945124278275' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_99 FROM DUAL;

-- permission id collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820614' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278276')) THEN 0 ELSE 1 END AS shenyu_preflight_check_100 FROM DUAL;

-- permission natural-key collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278276' AND id <> '1572525965658820614') THEN 0 ELSE 1 END AS shenyu_preflight_check_101 FROM DUAL;

-- permission resource identity collision: 1572525965658820614
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278276' AND NOT (id = '1676471945124278276' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_102 FROM DUAL;

-- permission id collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820615' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278277')) THEN 0 ELSE 1 END AS shenyu_preflight_check_103 FROM DUAL;

-- permission natural-key collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278277' AND id <> '1572525965658820615') THEN 0 ELSE 1 END AS shenyu_preflight_check_104 FROM DUAL;

-- permission resource identity collision: 1572525965658820615
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278277' AND NOT (id = '1676471945124278277' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_105 FROM DUAL;

-- permission id collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820616' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278278')) THEN 0 ELSE 1 END AS shenyu_preflight_check_106 FROM DUAL;

-- permission natural-key collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278278' AND id <> '1572525965658820616') THEN 0 ELSE 1 END AS shenyu_preflight_check_107 FROM DUAL;

-- permission resource identity collision: 1572525965658820616
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278278' AND NOT (id = '1676471945124278278' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_108 FROM DUAL;

-- permission id collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820617' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278279')) THEN 0 ELSE 1 END AS shenyu_preflight_check_109 FROM DUAL;

-- permission natural-key collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278279' AND id <> '1572525965658820617') THEN 0 ELSE 1 END AS shenyu_preflight_check_110 FROM DUAL;

-- permission resource identity collision: 1572525965658820617
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278279' AND NOT (id = '1676471945124278279' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_111 FROM DUAL;

-- permission id collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1572525965658820618' AND NOT (object_id = '1346358560427216896' AND resource_id = '1676471945124278280')) THEN 0 ELSE 1 END AS shenyu_preflight_check_112 FROM DUAL;

-- permission natural-key collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1676471945124278280' AND id <> '1572525965658820618') THEN 0 ELSE 1 END AS shenyu_preflight_check_113 FROM DUAL;

-- permission resource identity collision: 1572525965658820618
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1676471945124278280' AND NOT (id = '1676471945124278280' AND parent_id = '1676471945048780800' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_114 FROM DUAL;

-- permission id collision: 1792779493537148958
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148958' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954343')) THEN 0 ELSE 1 END AS shenyu_preflight_check_115 FROM DUAL;

-- permission natural-key collision: 1792779493537148958
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954343' AND id <> '1792779493537148958') THEN 0 ELSE 1 END AS shenyu_preflight_check_116 FROM DUAL;

-- permission resource identity collision: 1792779493537148958
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954343' AND NOT (id = '1792749362361954343' AND parent_id = '1346775491550474240' AND name = 'loggingHuaweiLts' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_117 FROM DUAL;

-- permission id collision: 1792779493537148959
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148959' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840438')) THEN 0 ELSE 1 END AS shenyu_preflight_check_118 FROM DUAL;

-- permission natural-key collision: 1792779493537148959
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840438' AND id <> '1792779493537148959') THEN 0 ELSE 1 END AS shenyu_preflight_check_119 FROM DUAL;

-- permission resource identity collision: 1792779493537148959
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840438' AND NOT (id = '1792749362445840438' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_120 FROM DUAL;

-- permission id collision: 1792779493537148960
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148960' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840439')) THEN 0 ELSE 1 END AS shenyu_preflight_check_121 FROM DUAL;

-- permission natural-key collision: 1792779493537148960
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840439' AND id <> '1792779493537148960') THEN 0 ELSE 1 END AS shenyu_preflight_check_122 FROM DUAL;

-- permission resource identity collision: 1792779493537148960
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840439' AND NOT (id = '1792749362445840439' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_123 FROM DUAL;

-- permission id collision: 1792779493537148961
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148961' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840440')) THEN 0 ELSE 1 END AS shenyu_preflight_check_124 FROM DUAL;

-- permission natural-key collision: 1792779493537148961
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840440' AND id <> '1792779493537148961') THEN 0 ELSE 1 END AS shenyu_preflight_check_125 FROM DUAL;

-- permission resource identity collision: 1792779493537148961
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840440' AND NOT (id = '1792749362445840440' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_126 FROM DUAL;

-- permission id collision: 1792779493537148962
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148962' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840441')) THEN 0 ELSE 1 END AS shenyu_preflight_check_127 FROM DUAL;

-- permission natural-key collision: 1792779493537148962
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840441' AND id <> '1792779493537148962') THEN 0 ELSE 1 END AS shenyu_preflight_check_128 FROM DUAL;

-- permission resource identity collision: 1792779493537148962
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840441' AND NOT (id = '1792749362445840441' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_129 FROM DUAL;

-- permission id collision: 1792779493537148963
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148963' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840442')) THEN 0 ELSE 1 END AS shenyu_preflight_check_130 FROM DUAL;

-- permission natural-key collision: 1792779493537148963
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840442' AND id <> '1792779493537148963') THEN 0 ELSE 1 END AS shenyu_preflight_check_131 FROM DUAL;

-- permission resource identity collision: 1792779493537148963
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840442' AND NOT (id = '1792749362445840442' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_132 FROM DUAL;

-- permission id collision: 1792779493537148964
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148964' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840443')) THEN 0 ELSE 1 END AS shenyu_preflight_check_133 FROM DUAL;

-- permission natural-key collision: 1792779493537148964
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840443' AND id <> '1792779493537148964') THEN 0 ELSE 1 END AS shenyu_preflight_check_134 FROM DUAL;

-- permission resource identity collision: 1792779493537148964
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840443' AND NOT (id = '1792749362445840443' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_135 FROM DUAL;

-- permission id collision: 1792779493537148965
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148965' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840444')) THEN 0 ELSE 1 END AS shenyu_preflight_check_136 FROM DUAL;

-- permission natural-key collision: 1792779493537148965
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840444' AND id <> '1792779493537148965') THEN 0 ELSE 1 END AS shenyu_preflight_check_137 FROM DUAL;

-- permission resource identity collision: 1792779493537148965
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840444' AND NOT (id = '1792749362445840444' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_138 FROM DUAL;

-- permission id collision: 1792779493537148966
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148966' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840445')) THEN 0 ELSE 1 END AS shenyu_preflight_check_139 FROM DUAL;

-- permission natural-key collision: 1792779493537148966
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840445' AND id <> '1792779493537148966') THEN 0 ELSE 1 END AS shenyu_preflight_check_140 FROM DUAL;

-- permission resource identity collision: 1792779493537148966
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840445' AND NOT (id = '1792749362445840445' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLtsRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_141 FROM DUAL;

-- permission id collision: 1792779493537148967
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493537148967' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840446')) THEN 0 ELSE 1 END AS shenyu_preflight_check_142 FROM DUAL;

-- permission natural-key collision: 1792779493537148967
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840446' AND id <> '1792779493537148967') THEN 0 ELSE 1 END AS shenyu_preflight_check_143 FROM DUAL;

-- permission resource identity collision: 1792779493537148967
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840446' AND NOT (id = '1792749362445840446' AND parent_id = '1792749362361954343' AND name = '' AND perms = 'plugin:loggingHuaweiLts:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_144 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822180' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '43')) THEN 0 ELSE 1 END AS shenyu_preflight_check_145 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822180
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '43' AND id <> '1801816010882822180') THEN 0 ELSE 1 END AS shenyu_preflight_check_146 FROM DUAL;
