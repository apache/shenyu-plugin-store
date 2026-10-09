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

-- Archive-only historical SQL fragments for logging-rabbitmq.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.

-- Fragment 1
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin` VALUES ('45', 'loggingRabbitMQ', '{\"host\":\"127.0.0.1\",\"port\":5672,\"password\":\"admin\",\"username\":\"admin\",\"exchangeName\":\"exchange.logging.plugin\",\"queueName\":\"queue.logging.plugin\",\"routingKey\":\"topic.logging\",\"virtualHost\":\"/\",\"exchangeType\":\"direct\",\"durable\":\"true\",\"exclusive\":\"false\",\"autoDelete\":\"false\"}', 'Logging', 171, 0, '2023-11-06 15:49:56.454', '2023-11-10 10:40:58.447', NULL)

-- Fragment 2
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721435546642157568', '45', 'host', 'host', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"127.0.0.1\",\"rule\":\"\"}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 3
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721435708743618560', '45', 'port', 'port', 1, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"15672\",\"rule\":\"\"}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 4
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721436368046264320', '45', 'password', 'password', 2, 3, 0, '{\"required\":\"0\",\"defaultValue\":\"admin\",\"rule\":\"\"}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 5
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721436500343001088', '45', 'username', 'username', 2, 3, 0, '{\"required\":\"0\",\"defaultValue\":\"admin\",\"rule\":\"\"}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 6
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721436639635836928', '45', 'exchangeName', 'exchangeName', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 7
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721436745583955968', '45', 'queueName', 'queueName', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 8
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721509996347617280', '45', 'routingKey', 'routingKey', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 9
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721725585461706752', '45', 'virtualHost', 'virtualHost', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"/\",\"rule\":\"\"}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 10
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1721725662875975680', '45', 'exchangeType', 'exchangeType', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"direct\",\"rule\":\"\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 11
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804180904927232', '45', 'durable', 'durable', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"true\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 12
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804370575548416', '45', 'exclusive', 'exclusive', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 13
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804461256400896', '45', 'autoDelete', 'autoDelete', 2, 3, 0, '{\"required\":\"1\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 14
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507008', '45', 'args', 'args', 2, 3, 0, '{\"required\":\"0\",\"defaultValue\":"",\"placeholder\":"",\"rule\":\"\"}', '2023-1\1-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 15
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507011', '45', 'sampleRate', 'sampleRate', 2, 3, 4, '{\"required\":\"0\",\"defaultValue\":\"1\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 16
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1722804548510507012', '45', 'sampleRate', 'sampleRate', 2, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"optional,0,0.01~1\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 17
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin" VALUES ('45', 'loggingRabbitMQ', '{"host":"127.0.0.1","port":5672,"password":"admin","username":"admin","exchangeName":"exchange.logging.plugin","queueName":"queue.logging.plugin","routingKey":"topic.logging","virtualHost":"/","exchangeType":"direct","durable":"true","exclusive":"false","autoDelete":"false"}', 'Logging', 171, 0, '2023-11-06 15:49:56.454', '2023-11-10 10:40:58.447', NULL)

-- Fragment 18
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721435546642157568', '45', 'host', 'host', 2, 3, 0, '{"required":"1","defaultValue":"127.0.0.1","rule":""}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 19
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721435708743618560', '45', 'port', 'port', 1, 3, 0, '{"required":"1","defaultValue":"15672","rule":""}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 20
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436368046264320', '45', 'password', 'password', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 21
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436500343001088', '45', 'username', 'username', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 22
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436639635836928', '45', 'exchangeName', 'exchangeName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 23
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436745583955968', '45', 'queueName', 'queueName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 24
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721509996347617280', '45', 'routingKey', 'routingKey', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 25
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721725585461706752', '45', 'virtualHost', 'virtualHost', 2, 3, 0, '{"required":"1","defaultValue":"/","rule":""}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 26
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721725662875975680', '45', 'exchangeType', 'exchangeType', 2, 3, 0, '{"required":"1","defaultValue":"direct","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 27
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804180904927232', '45', 'durable', 'durable', 2, 3, 0, '{"required":"1","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 28
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804370575548416', '45', 'exclusive', 'exclusive', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 29
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804461256400896', '45', 'autoDelete', 'autoDelete', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 30
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507008', '45', 'args', 'args', 2, 3, 0, '{"required":"0","defaultValue":"","placeholder":"args json","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 31
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507009', '45', 'sampleRate', 'sampleRate', 2, 3, 4, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 32
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507010', '45', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 33
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- INSERT /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin(id)) */ INTO plugin (id, name, role, sort, config, enabled) VALUES ('45', 'loggingRabbitmq', 'Logging', 171, '{"host":"127.0.0.1","port":5672,"password":"admin","username":"admin","exchangeName":"exchange.logging.plugin","queueName":"queue.logging.plugin","routingKey":"topic.logging","virtualHost":"/","exchangeType":"direct","durable":"true","exclusive":"false","autoDelete":"false"}', '0')

-- Fragment 34
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721435546642157568', '45', 'host', 'host', 2, 3, 0, '{"required":"1","defaultValue":"127.0.0.1","rule":""}')

-- Fragment 35
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721435708743618560', '45', 'port', 'port', 1, 3, 0, '{"required":"1","defaultValue":"15672","rule":""}')

-- Fragment 36
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721436368046264320', '45', 'password', 'password', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}')

-- Fragment 37
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721436500343001088', '45', 'username', 'username', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}')

-- Fragment 38
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721436639635836928', '45', 'exchangeName', 'exchangeName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}')

-- Fragment 39
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721436745583955968', '45', 'queueName', 'queueName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}')

-- Fragment 40
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721509996347617280', '45', 'routingKey', 'routingKey', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}')

-- Fragment 41
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721725585461706752', '45', 'virtualHost', 'virtualHost', 2, 3, 0, '{"required":"1","defaultValue":"/","rule":""}')

-- Fragment 42
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1721725662875975680', '45', 'exchangeType', 'exchangeType', 2, 3, 0, '{"required":"1","defaultValue":"direct","rule":""}')

-- Fragment 43
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804180904927232', '45', 'durable', 'durable', 2, 3, 0, '{"required":"1","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 44
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804370575548416', '45', 'exclusive', 'exclusive', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 45
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804461256400896', '45', 'autoDelete', 'autoDelete', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 46
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507008', '45', 'args', 'args', 2, 3, 0, '{"required":"0","defaultValue":"","placeholder":"","rule":"/^\\s*(\\{.*\\}|\\[.*\\])\\s*$/"}')

-- Fragment 47
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507010', '45', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}')

-- Fragment 48
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ) values ('1722804548510507011', '45', 'sampleRate', 'sampleRate', 2, 3, 4, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}')

-- Fragment 49
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin" VALUES ('45', 'loggingRabbitMQ', '{"host":"127.0.0.1","port":5672,"password":"admin","username":"admin","exchangeName":"exchange.logging.plugin","queueName":"queue.logging.plugin","routingKey":"topic.logging","virtualHost":"/","exchangeType":"direct","durable":"true","exclusive":"false","autoDelete":"false"}', 'Logging', 171, 0, '2023-11-06 15:49:56.454', '2023-11-10 10:40:58.447', NULL)

-- Fragment 50
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721435546642157568', '45', 'host', 'host', 2, 3, 0, '{"required":"1","defaultValue":"127.0.0.1","rule":""}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 51
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721435708743618560', '45', 'port', 'port', 1, 3, 0, '{"required":"1","defaultValue":"15672","rule":""}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 52
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436368046264320', '45', 'password', 'password', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 53
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436500343001088', '45', 'username', 'username', 2, 3, 0, '{"required":"0","defaultValue":"admin","rule":""}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 54
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436639635836928', '45', 'exchangeName', 'exchangeName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 55
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721436745583955968', '45', 'queueName', 'queueName', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 56
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721509996347617280', '45', 'routingKey', 'routingKey', 2, 3, 0, '{"required":"1","defaultValue":"","rule":""}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 57
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721725585461706752', '45', 'virtualHost', 'virtualHost', 2, 3, 0, '{"required":"1","defaultValue":"/","rule":""}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 58
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1721725662875975680', '45', 'exchangeType', 'exchangeType', 2, 3, 0, '{"required":"1","defaultValue":"direct","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 59
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804180904927232', '45', 'durable', 'durable', 2, 3, 0, '{"required":"1","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 60
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804370575548416', '45', 'exclusive', 'exclusive', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 61
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804461256400896', '45', 'autoDelete', 'autoDelete', 2, 3, 0, '{"required":"1","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 62
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507008', '45', 'args', 'args', 2, 3, 0, '{"required":"0","defaultValue":"","placeholder":"args json","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 63
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507009', '45', 'sampleRate', 'sampleRate', 2, 3, 4, '{"required":"0","defaultValue":"1","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 64
-- sourceVersion: 2.6.0-upgrade-2.6.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.6.0-upgrade-2.6.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1722804548510507010', '45', 'sampleRate', 'sampleRate', 2, 1, 2, '{"required":"0","defaultValue":"","placeholder":"optional,0,0.01~1"}', '2022-07-04 22:00:00', '2022-07-04 22:00:00')

-- Fragment 65
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821435546642157568', '45', 'host', 'host', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 66
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821435708743618560', '45', 'port', 'port', 1, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 67
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436368046264320', '45', 'password', 'password', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 68
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436500343001088', '45', 'username', 'username', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 69
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436639635836928', '45', 'exchangeName', 'exchangeName', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 70
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436745583955968', '45', 'queueName', 'queueName', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 71
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821509996347617280', '45', 'routingKey', 'routingKey', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 72
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821725585461706752', '45', 'virtualHost', 'virtualHost', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"/\",\"rule\":\"\"}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 73
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1821725662875975680', '45', 'exchangeType', 'exchangeType', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"direct\",\"rule\":\"\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 74
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804180904927232', '45', 'durable', 'durable', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"true\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 75
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804370575548416', '45', 'exclusive', 'exclusive', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 76
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804461256400896', '45', 'autoDelete', 'autoDelete', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 77
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804548510507008', '45', 'args', 'args', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":"",\"placeholder\":"",\"rule\":\"\"}', '2023-1\1-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 78
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821435546642157568', '45', 'host', 'host', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 79
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821435708743618560', '45', 'port', 'port', 1, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 80
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436368046264320', '45', 'password', 'password', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 81
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436500343001088', '45', 'username', 'username', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 82
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436639635836928', '45', 'exchangeName', 'exchangeName', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 83
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821436745583955968', '45', 'queueName', 'queueName', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 84
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821509996347617280', '45', 'routingKey', 'routingKey', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"rule\":\"\"}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 85
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821725585461706752', '45', 'virtualHost', 'virtualHost', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"/\",\"rule\":\"\"}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 86
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1821725662875975680', '45', 'exchangeType', 'exchangeType', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"direct\",\"rule\":\"\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 87
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804180904927232', '45', 'durable', 'durable', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"true\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 88
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804370575548416', '45', 'exclusive', 'exclusive', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 89
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804461256400896', '45', 'autoDelete', 'autoDelete', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"false\",\"placeholder\":\"true / false\",\"rule\":\"/^(true|false)$/\"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 90
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1822804548510507008', '45', 'args', 'args', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":"",\"placeholder\":"",\"rule\":\"\"}', '2023-1\1-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 91
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821435546642157568', '45', 'host', 'host', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 92
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821435708743618560', '45', 'port', 'port', 1, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 93
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436368046264320', '45', 'password', 'password', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 94
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436500343001088', '45', 'username', 'username', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 95
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436639635836928', '45', 'exchangeName', 'exchangeName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 96
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436745583955968', '45', 'queueName', 'queueName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 97
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821509996347617280', '45', 'routingKey', 'routingKey', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 98
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821725585461706752', '45', 'virtualHost', 'virtualHost', 2, 1, 0, '{"required":"0","defaultValue":"/","rule":""}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 99
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821725662875975680', '45', 'exchangeType', 'exchangeType', 2, 1, 0, '{"required":"0","defaultValue":"direct","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 100
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804180904927232', '45', 'durable', 'durable', 2, 1, 0, '{"required":"0","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 101
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804370575548416', '45', 'exclusive', 'exclusive', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 102
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804461256400896', '45', 'autoDelete', 'autoDelete', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 103
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804548510507008', '45', 'args', 'args', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"args json","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 104
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821435546642157568', '45', 'host', 'host', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 105
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821435708743618560', '45', 'port', 'port', 1, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 106
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821436368046264320', '45', 'password', 'password', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 107
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821436500343001088', '45', 'username', 'username', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 108
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821436639635836928', '45', 'exchangeName', 'exchangeName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 109
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821436745583955968', '45', 'queueName', 'queueName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 110
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821509996347617280', '45', 'routingKey', 'routingKey', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}')

-- Fragment 111
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821725585461706752', '45', 'virtualHost', 'virtualHost', 2, 1, 0, '{"required":"0","defaultValue":"/","rule":""}')

-- Fragment 112
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1821725662875975680', '45', 'exchangeType', 'exchangeType', 2, 1, 0, '{"required":"0","defaultValue":"direct","rule":""}')

-- Fragment 113
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1822804180904927232', '45', 'durable', 'durable', 2, 1, 0, '{"required":"0","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 114
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1822804370575548416', '45', 'exclusive', 'exclusive', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 115
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1822804461256400896', '45', 'autoDelete', 'autoDelete', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}')

-- Fragment 116
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1822804548510507008', '45', 'args', 'args', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"","rule":"/^\\s*(\\{.*\\}|\\[.*\\])\\s*$/"}')

-- Fragment 117
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821435546642157568', '45', 'host', 'host', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:53:11.704', '2023-11-07 13:31:41.010')

-- Fragment 118
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821435708743618560', '45', 'port', 'port', 1, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:53:50.352', '2023-11-07 13:31:41.016')

-- Fragment 119
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436368046264320', '45', 'password', 'password', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:56:27.541', '2023-11-07 13:31:41.021')

-- Fragment 120
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436500343001088', '45', 'username', 'username', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:56:59.084', '2023-11-07 13:31:41.025')

-- Fragment 121
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436639635836928', '45', 'exchangeName', 'exchangeName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:57:32.295', '2023-11-07 13:31:41.030')

-- Fragment 122
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821436745583955968', '45', 'queueName', 'queueName', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 15:57:57.553', '2023-11-07 13:31:41.035')

-- Fragment 123
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821509996347617280', '45', 'routingKey', 'routingKey', 2, 1, 0, '{"required":"0","defaultValue":"","rule":""}', '2023-11-06 20:49:01.897', '2023-11-07 13:31:41.039')

-- Fragment 124
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821725585461706752', '45', 'virtualHost', 'virtualHost', 2, 1, 0, '{"required":"0","defaultValue":"/","rule":""}', '2023-11-07 11:05:42.350', '2023-11-07 13:31:41.044')

-- Fragment 125
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1821725662875975680', '45', 'exchangeType', 'exchangeType', 2, 1, 0, '{"required":"0","defaultValue":"direct","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 126
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804180904927232', '45', 'durable', 'durable', 2, 1, 0, '{"required":"0","defaultValue":"true","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 127
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804370575548416', '45', 'exclusive', 'exclusive', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 128
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804461256400896', '45', 'autoDelete', 'autoDelete', 2, 1, 0, '{"required":"0","defaultValue":"false","placeholder":"true / false","rule":"/^(true|false)$/"}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')

-- Fragment 129
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1822804548510507008', '45', 'args', 'args', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"args json","rule":""}', '2023-11-07 11:06:00.803', '2023-11-07 13:31:41.048')
