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

-- Preflight checks for logging-rabbitmq (loggingRabbitMQ).
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:shenyu-admin/src/main/resources/sql-script/h2/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

-- canonical plugin id is occupied by another name
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE id = '45' AND name <> 'loggingRabbitMQ') THEN 0 ELSE 1 END AS shenyu_preflight_check_1 FROM DUAL;

-- canonical plugin name exists under another id
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingRabbitMQ' AND id <> '45') THEN 0 ELSE 1 END AS shenyu_preflight_check_2 FROM DUAL;

-- plugin_handle id collision: 1721435546642157568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721435546642157568' AND NOT (plugin_id = '45' AND field = 'host' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_3 FROM DUAL;

-- plugin_handle natural-key collision: 1721435546642157568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'host' AND type = 3 AND id <> '1721435546642157568') THEN 0 ELSE 1 END AS shenyu_preflight_check_4 FROM DUAL;

-- plugin_handle id collision: 1721435708743618560
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721435708743618560' AND NOT (plugin_id = '45' AND field = 'port' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_5 FROM DUAL;

-- plugin_handle natural-key collision: 1721435708743618560
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'port' AND type = 3 AND id <> '1721435708743618560') THEN 0 ELSE 1 END AS shenyu_preflight_check_6 FROM DUAL;

-- plugin_handle id collision: 1721436368046264320
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436368046264320' AND NOT (plugin_id = '45' AND field = 'password' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_7 FROM DUAL;

-- plugin_handle natural-key collision: 1721436368046264320
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'password' AND type = 3 AND id <> '1721436368046264320') THEN 0 ELSE 1 END AS shenyu_preflight_check_8 FROM DUAL;

-- plugin_handle id collision: 1721436500343001088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436500343001088' AND NOT (plugin_id = '45' AND field = 'username' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_9 FROM DUAL;

-- plugin_handle natural-key collision: 1721436500343001088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'username' AND type = 3 AND id <> '1721436500343001088') THEN 0 ELSE 1 END AS shenyu_preflight_check_10 FROM DUAL;

-- plugin_handle id collision: 1721436639635836928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436639635836928' AND NOT (plugin_id = '45' AND field = 'exchangeName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_11 FROM DUAL;

-- plugin_handle natural-key collision: 1721436639635836928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeName' AND type = 3 AND id <> '1721436639635836928') THEN 0 ELSE 1 END AS shenyu_preflight_check_12 FROM DUAL;

-- plugin_handle id collision: 1721436745583955968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436745583955968' AND NOT (plugin_id = '45' AND field = 'queueName' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_13 FROM DUAL;

-- plugin_handle natural-key collision: 1721436745583955968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'queueName' AND type = 3 AND id <> '1721436745583955968') THEN 0 ELSE 1 END AS shenyu_preflight_check_14 FROM DUAL;

-- plugin_handle id collision: 1721509996347617280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721509996347617280' AND NOT (plugin_id = '45' AND field = 'routingKey' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_15 FROM DUAL;

-- plugin_handle natural-key collision: 1721509996347617280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'routingKey' AND type = 3 AND id <> '1721509996347617280') THEN 0 ELSE 1 END AS shenyu_preflight_check_16 FROM DUAL;

-- plugin_handle id collision: 1721725585461706752
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721725585461706752' AND NOT (plugin_id = '45' AND field = 'virtualHost' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_17 FROM DUAL;

-- plugin_handle natural-key collision: 1721725585461706752
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'virtualHost' AND type = 3 AND id <> '1721725585461706752') THEN 0 ELSE 1 END AS shenyu_preflight_check_18 FROM DUAL;

-- plugin_handle id collision: 1721725662875975680
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721725662875975680' AND NOT (plugin_id = '45' AND field = 'exchangeType' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_19 FROM DUAL;

-- plugin_handle natural-key collision: 1721725662875975680
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeType' AND type = 3 AND id <> '1721725662875975680') THEN 0 ELSE 1 END AS shenyu_preflight_check_20 FROM DUAL;

-- plugin_handle id collision: 1722804180904927232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804180904927232' AND NOT (plugin_id = '45' AND field = 'durable' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_21 FROM DUAL;

-- plugin_handle natural-key collision: 1722804180904927232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'durable' AND type = 3 AND id <> '1722804180904927232') THEN 0 ELSE 1 END AS shenyu_preflight_check_22 FROM DUAL;

-- plugin_handle id collision: 1722804370575548416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804370575548416' AND NOT (plugin_id = '45' AND field = 'exclusive' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_23 FROM DUAL;

-- plugin_handle natural-key collision: 1722804370575548416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exclusive' AND type = 3 AND id <> '1722804370575548416') THEN 0 ELSE 1 END AS shenyu_preflight_check_24 FROM DUAL;

-- plugin_handle id collision: 1722804461256400896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804461256400896' AND NOT (plugin_id = '45' AND field = 'autoDelete' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_25 FROM DUAL;

-- plugin_handle natural-key collision: 1722804461256400896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'autoDelete' AND type = 3 AND id <> '1722804461256400896') THEN 0 ELSE 1 END AS shenyu_preflight_check_26 FROM DUAL;

-- plugin_handle id collision: 1722804548510507008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507008' AND NOT (plugin_id = '45' AND field = 'args' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_27 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'args' AND type = 3 AND id <> '1722804548510507008') THEN 0 ELSE 1 END AS shenyu_preflight_check_28 FROM DUAL;

-- plugin_handle id collision: 1821435546642157568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821435546642157568' AND NOT (plugin_id = '45' AND field = 'host' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_29 FROM DUAL;

-- plugin_handle natural-key collision: 1821435546642157568
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'host' AND type = 1 AND id <> '1821435546642157568') THEN 0 ELSE 1 END AS shenyu_preflight_check_30 FROM DUAL;

-- plugin_handle id collision: 1821435708743618560
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821435708743618560' AND NOT (plugin_id = '45' AND field = 'port' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_31 FROM DUAL;

-- plugin_handle natural-key collision: 1821435708743618560
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'port' AND type = 1 AND id <> '1821435708743618560') THEN 0 ELSE 1 END AS shenyu_preflight_check_32 FROM DUAL;

-- plugin_handle id collision: 1821436368046264320
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436368046264320' AND NOT (plugin_id = '45' AND field = 'password' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_33 FROM DUAL;

-- plugin_handle natural-key collision: 1821436368046264320
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'password' AND type = 1 AND id <> '1821436368046264320') THEN 0 ELSE 1 END AS shenyu_preflight_check_34 FROM DUAL;

-- plugin_handle id collision: 1821436500343001088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436500343001088' AND NOT (plugin_id = '45' AND field = 'username' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_35 FROM DUAL;

-- plugin_handle natural-key collision: 1821436500343001088
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'username' AND type = 1 AND id <> '1821436500343001088') THEN 0 ELSE 1 END AS shenyu_preflight_check_36 FROM DUAL;

-- plugin_handle id collision: 1821436639635836928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436639635836928' AND NOT (plugin_id = '45' AND field = 'exchangeName' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_37 FROM DUAL;

-- plugin_handle natural-key collision: 1821436639635836928
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeName' AND type = 1 AND id <> '1821436639635836928') THEN 0 ELSE 1 END AS shenyu_preflight_check_38 FROM DUAL;

-- plugin_handle id collision: 1821436745583955968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436745583955968' AND NOT (plugin_id = '45' AND field = 'queueName' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_39 FROM DUAL;

-- plugin_handle natural-key collision: 1821436745583955968
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'queueName' AND type = 1 AND id <> '1821436745583955968') THEN 0 ELSE 1 END AS shenyu_preflight_check_40 FROM DUAL;

-- plugin_handle id collision: 1821509996347617280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821509996347617280' AND NOT (plugin_id = '45' AND field = 'routingKey' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_41 FROM DUAL;

-- plugin_handle natural-key collision: 1821509996347617280
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'routingKey' AND type = 1 AND id <> '1821509996347617280') THEN 0 ELSE 1 END AS shenyu_preflight_check_42 FROM DUAL;

-- plugin_handle id collision: 1821725585461706752
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821725585461706752' AND NOT (plugin_id = '45' AND field = 'virtualHost' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_43 FROM DUAL;

-- plugin_handle natural-key collision: 1821725585461706752
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'virtualHost' AND type = 1 AND id <> '1821725585461706752') THEN 0 ELSE 1 END AS shenyu_preflight_check_44 FROM DUAL;

-- plugin_handle id collision: 1821725662875975680
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821725662875975680' AND NOT (plugin_id = '45' AND field = 'exchangeType' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_45 FROM DUAL;

-- plugin_handle natural-key collision: 1821725662875975680
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeType' AND type = 1 AND id <> '1821725662875975680') THEN 0 ELSE 1 END AS shenyu_preflight_check_46 FROM DUAL;

-- plugin_handle id collision: 1822804180904927232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804180904927232' AND NOT (plugin_id = '45' AND field = 'durable' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_47 FROM DUAL;

-- plugin_handle natural-key collision: 1822804180904927232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'durable' AND type = 1 AND id <> '1822804180904927232') THEN 0 ELSE 1 END AS shenyu_preflight_check_48 FROM DUAL;

-- plugin_handle id collision: 1822804370575548416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804370575548416' AND NOT (plugin_id = '45' AND field = 'exclusive' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_49 FROM DUAL;

-- plugin_handle natural-key collision: 1822804370575548416
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exclusive' AND type = 1 AND id <> '1822804370575548416') THEN 0 ELSE 1 END AS shenyu_preflight_check_50 FROM DUAL;

-- plugin_handle id collision: 1822804461256400896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804461256400896' AND NOT (plugin_id = '45' AND field = 'autoDelete' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_51 FROM DUAL;

-- plugin_handle natural-key collision: 1822804461256400896
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'autoDelete' AND type = 1 AND id <> '1822804461256400896') THEN 0 ELSE 1 END AS shenyu_preflight_check_52 FROM DUAL;

-- plugin_handle id collision: 1822804548510507008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804548510507008' AND NOT (plugin_id = '45' AND field = 'args' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_53 FROM DUAL;

-- plugin_handle natural-key collision: 1822804548510507008
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'args' AND type = 1 AND id <> '1822804548510507008') THEN 0 ELSE 1 END AS shenyu_preflight_check_54 FROM DUAL;

-- plugin_handle id collision: 1722804548510507010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507010' AND NOT (plugin_id = '45' AND field = 'sampleRate' AND type = 3)) THEN 0 ELSE 1 END AS shenyu_preflight_check_55 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507010
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507010') THEN 0 ELSE 1 END AS shenyu_preflight_check_56 FROM DUAL;

-- plugin_handle id collision: 1722804548510507011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507011' AND NOT (plugin_id = '45' AND field = 'sampleRate' AND type = 1)) THEN 0 ELSE 1 END AS shenyu_preflight_check_57 FROM DUAL;

-- plugin_handle natural-key collision: 1722804548510507011
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507011') THEN 0 ELSE 1 END AS shenyu_preflight_check_58 FROM DUAL;

-- resource id collision: 1792749362361954345
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_59 FROM DUAL;

-- resource id collision: 1792749362445840456
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840456' AND NOT (id = '1792749362445840456' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_60 FROM DUAL;

-- resource parent identity collision: 1792749362445840456
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_61 FROM DUAL;

-- resource id collision: 1792749362445840457
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840457' AND NOT (id = '1792749362445840457' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_62 FROM DUAL;

-- resource parent identity collision: 1792749362445840457
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_63 FROM DUAL;

-- resource id collision: 1792749362445840458
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840458' AND NOT (id = '1792749362445840458' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_64 FROM DUAL;

-- resource parent identity collision: 1792749362445840458
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_65 FROM DUAL;

-- resource id collision: 1792749362445840459
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840459' AND NOT (id = '1792749362445840459' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_66 FROM DUAL;

-- resource parent identity collision: 1792749362445840459
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_67 FROM DUAL;

-- resource id collision: 1792749362445840460
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840460' AND NOT (id = '1792749362445840460' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_68 FROM DUAL;

-- resource parent identity collision: 1792749362445840460
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_69 FROM DUAL;

-- resource id collision: 1792749362445840461
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840461' AND NOT (id = '1792749362445840461' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_70 FROM DUAL;

-- resource parent identity collision: 1792749362445840461
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_71 FROM DUAL;

-- resource id collision: 1792749362445840462
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840462' AND NOT (id = '1792749362445840462' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_72 FROM DUAL;

-- resource parent identity collision: 1792749362445840462
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_73 FROM DUAL;

-- resource id collision: 1792749362445840463
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840463' AND NOT (id = '1792749362445840463' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_74 FROM DUAL;

-- resource parent identity collision: 1792749362445840463
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_75 FROM DUAL;

-- resource id collision: 1792749362445840464
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840464' AND NOT (id = '1792749362445840464' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQ:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_76 FROM DUAL;

-- resource parent identity collision: 1792749362445840464
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_77 FROM DUAL;

-- permission id collision: 1792779493541343232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343232' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954345')) THEN 0 ELSE 1 END AS shenyu_preflight_check_78 FROM DUAL;

-- permission natural-key collision: 1792779493541343232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954345' AND id <> '1792779493541343232') THEN 0 ELSE 1 END AS shenyu_preflight_check_79 FROM DUAL;

-- permission resource identity collision: 1792779493541343232
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN 0 ELSE 1 END AS shenyu_preflight_check_80 FROM DUAL;

-- permission id collision: 1792779493541343233
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343233' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840456')) THEN 0 ELSE 1 END AS shenyu_preflight_check_81 FROM DUAL;

-- permission natural-key collision: 1792779493541343233
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840456' AND id <> '1792779493541343233') THEN 0 ELSE 1 END AS shenyu_preflight_check_82 FROM DUAL;

-- permission resource identity collision: 1792779493541343233
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840456' AND NOT (id = '1792749362445840456' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_83 FROM DUAL;

-- permission id collision: 1792779493541343234
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343234' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840457')) THEN 0 ELSE 1 END AS shenyu_preflight_check_84 FROM DUAL;

-- permission natural-key collision: 1792779493541343234
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840457' AND id <> '1792779493541343234') THEN 0 ELSE 1 END AS shenyu_preflight_check_85 FROM DUAL;

-- permission resource identity collision: 1792779493541343234
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840457' AND NOT (id = '1792749362445840457' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_86 FROM DUAL;

-- permission id collision: 1792779493541343235
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343235' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840458')) THEN 0 ELSE 1 END AS shenyu_preflight_check_87 FROM DUAL;

-- permission natural-key collision: 1792779493541343235
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840458' AND id <> '1792779493541343235') THEN 0 ELSE 1 END AS shenyu_preflight_check_88 FROM DUAL;

-- permission resource identity collision: 1792779493541343235
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840458' AND NOT (id = '1792749362445840458' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_89 FROM DUAL;

-- permission id collision: 1792779493541343236
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343236' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840459')) THEN 0 ELSE 1 END AS shenyu_preflight_check_90 FROM DUAL;

-- permission natural-key collision: 1792779493541343236
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840459' AND id <> '1792779493541343236') THEN 0 ELSE 1 END AS shenyu_preflight_check_91 FROM DUAL;

-- permission resource identity collision: 1792779493541343236
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840459' AND NOT (id = '1792749362445840459' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_92 FROM DUAL;

-- permission id collision: 1792779493541343237
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343237' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840460')) THEN 0 ELSE 1 END AS shenyu_preflight_check_93 FROM DUAL;

-- permission natural-key collision: 1792779493541343237
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840460' AND id <> '1792779493541343237') THEN 0 ELSE 1 END AS shenyu_preflight_check_94 FROM DUAL;

-- permission resource identity collision: 1792779493541343237
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840460' AND NOT (id = '1792749362445840460' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:add')) THEN 0 ELSE 1 END AS shenyu_preflight_check_95 FROM DUAL;

-- permission id collision: 1792779493541343238
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343238' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840461')) THEN 0 ELSE 1 END AS shenyu_preflight_check_96 FROM DUAL;

-- permission natural-key collision: 1792779493541343238
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840461' AND id <> '1792779493541343238') THEN 0 ELSE 1 END AS shenyu_preflight_check_97 FROM DUAL;

-- permission resource identity collision: 1792779493541343238
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840461' AND NOT (id = '1792749362445840461' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:query')) THEN 0 ELSE 1 END AS shenyu_preflight_check_98 FROM DUAL;

-- permission id collision: 1792779493541343239
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343239' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840462')) THEN 0 ELSE 1 END AS shenyu_preflight_check_99 FROM DUAL;

-- permission natural-key collision: 1792779493541343239
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840462' AND id <> '1792779493541343239') THEN 0 ELSE 1 END AS shenyu_preflight_check_100 FROM DUAL;

-- permission resource identity collision: 1792779493541343239
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840462' AND NOT (id = '1792749362445840462' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:edit')) THEN 0 ELSE 1 END AS shenyu_preflight_check_101 FROM DUAL;

-- permission id collision: 1792779493541343240
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343240' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840463')) THEN 0 ELSE 1 END AS shenyu_preflight_check_102 FROM DUAL;

-- permission natural-key collision: 1792779493541343240
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840463' AND id <> '1792779493541343240') THEN 0 ELSE 1 END AS shenyu_preflight_check_103 FROM DUAL;

-- permission resource identity collision: 1792779493541343240
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840463' AND NOT (id = '1792749362445840463' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:delete')) THEN 0 ELSE 1 END AS shenyu_preflight_check_104 FROM DUAL;

-- permission id collision: 1792779493541343241
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343241' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840464')) THEN 0 ELSE 1 END AS shenyu_preflight_check_105 FROM DUAL;

-- permission natural-key collision: 1792779493541343241
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840464' AND id <> '1792779493541343241') THEN 0 ELSE 1 END AS shenyu_preflight_check_106 FROM DUAL;

-- permission resource identity collision: 1792779493541343241
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840464' AND NOT (id = '1792749362445840464' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQ:modify')) THEN 0 ELSE 1 END AS shenyu_preflight_check_107 FROM DUAL;

-- namespace_plugin_rel id collision: 1801816010882822182
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822182' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '45')) THEN 0 ELSE 1 END AS shenyu_preflight_check_108 FROM DUAL;

-- namespace_plugin_rel natural-key collision: 1801816010882822182
SELECT 1 / CASE WHEN EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '45' AND id <> '1801816010882822182') THEN 0 ELSE 1 END AS shenyu_preflight_check_109 FROM DUAL;
