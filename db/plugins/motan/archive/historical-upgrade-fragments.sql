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

-- Archive-only historical SQL fragments for motan.
-- These fragments document source upgrade history and are not executed by install.sql.
-- Do not run this file as an automatic upgrade. Use the active dialect install.sql files for store-owned seed installation.
-- Motan removal/delete upgrade statements below are retained as provenance only and are intentionally disabled.

-- Fragment 1
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-mysql.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'motan'

-- Fragment 2
-- sourceVersion: 2.4.1-upgrade-2.4.2
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.1-upgrade-2.4.2-pg.sql
-- UPDATE plugin SET role = 'Proxy' WHERE name = 'motan'

-- Fragment 3
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT IGNORE INTO plugin_handle (`id`, `plugin_id`, `field`, `label`, `data_type`, `type`, `sort`, `ext_obj`) VALUES ('1510270286164094976', '17', 'corethreads', 'corethreads', 1, 3, 0, '{"required":"0","defaultValue":"0","placeholder":"corethreads","rule":""}')

-- Fragment 4
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT IGNORE INTO plugin_handle (`id`, `plugin_id`, `field`, `label`, `data_type`, `type`, `sort`, `ext_obj`) VALUES ('1510270476329644032', '17', 'threads', 'threads', 1, 3, 0, '{"required":"0","defaultValue":"2147483647","placeholder":"threads","rule":""}')

-- Fragment 5
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT IGNORE INTO plugin_handle (`id`, `plugin_id`, `field`, `label`, `data_type`, `type`, `sort`, `ext_obj`) VALUES ('1510270555383885824', '17', 'queues', 'queues', 1, 3, 0, '{"required":"0","defaultValue":"0","placeholder":"queues","rule":""}')

-- Fragment 6
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- INSERT IGNORE INTO plugin_handle (`id`, `plugin_id`, `field`, `label`, `data_type`, `type`, `sort`, `ext_obj`) VALUES ('1515116191850078208', '17', 'threadpool', 'threadpool', 3, 3, 0, '{"required":"0","defaultValue":"cached","placeholder":"threadpool","rule":""}')

-- Fragment 7
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- UPDATE plugin SET config='{"register":"127.0.0.1:2181","corethreads":0,"threads":2147483647,"queues":0}' WHERE `name` = 'motan';

-- Fragment 8
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- insert plugin_handle data for motan

-- Fragment 9
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- UPDATE plugin SET config='{"register":"zookeeper://localhost:2181","corethreads":0,"threads":2147483647,"queues":0,"threadpool":"cached"}' WHERE `name` = 'motan';

-- Fragment 10
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-mysql.sql
-- -- UPDATE plugin SET config='{"register":"127.0.0.1:2181","threadpool":"shared"}' WHERE "name" = 'motan';

-- Fragment 11
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO plugin_handle ("id", "plugin_id", "field", "label", "data_type", "type", "sort", "ext_obj") VALUES ('1510270286164094976', '17', 'corethreads', 'corethreads', 1, 3, 0, '{"required":"0","defaultValue":"0","placeholder":"corethreads","rule":""}')

-- Fragment 12
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO plugin_handle ("id", "plugin_id", "field", "label", "data_type", "type", "sort", "ext_obj") VALUES ('1510270476329644032', '17', 'threads', 'threads', 1, 3, 0, '{"required":"0","defaultValue":"2147483647","placeholder":"threads","rule":""}')

-- Fragment 13
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO plugin_handle ("id", "plugin_id", "field", "label", "data_type", "type", "sort", "ext_obj") VALUES ('1510270555383885824', '17', 'queues', 'queues', 1, 3, 0, '{"required":"0","defaultValue":"0","placeholder":"queues","rule":""}')

-- Fragment 14
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- INSERT INTO plugin_handle ("id", "plugin_id", "field", "label", "data_type", "type", "sort", "ext_obj") VALUES ('1515116191850078208', '17', 'threadpool', 'threadpool', 3, 3, 0, '{"required":"0","defaultValue":"cached","placeholder":"threadpool","rule":""}')

-- Fragment 15
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- UPDATE plugin SET config='{"register":"127.0.0.1:2181","corethreads":0,"threads":2147483647,"queues":0}' WHERE "name" = 'motan';

-- Fragment 16
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- insert plugin_handle data for motan

-- Fragment 17
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- UPDATE plugin SET config='{"register":"zookeeper://localhost:2181","corethreads":0,"threads":2147483647,"queues":0,"threadpool":"cached"}' WHERE "name" = 'motan';

-- Fragment 18
-- sourceVersion: 2.4.3-upgrade-2.5.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.4.3-upgrade-2.5.0-pg.sql
-- -- UPDATE plugin SET config='{"register":"127.0.0.1:2181","threadpool":"shared"}' WHERE "name" = 'motan';

-- Fragment 19
-- sourceVersion: 2.5.0-upgrade-2.5.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.0-upgrade-2.5.1-oracle.sql
-- -- UPDATE plugin SET config='{"register":"127.0.0.1:2181","corethreads":0,"threads":2147483647,"queues":0}' WHERE "name" = 'motan';

-- Fragment 20
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1678997557628272641', '17', 'registerAddress', 'registerAddress', 2, 3, 1, '{\"required\":\"0\",\"defaultValue\":\"127.0.0.1:8002\",\"placeholder\":\"registerAddress\",\"rule\":\"\"}', '2023-01-10 10:08:01.158', '2023-01-10 10:08:01.158')

-- Fragment 21
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-oracle.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1678997557628272641', '17', 'registerAddress', 'registerAddress', 2, 3, 1, '{"required":"0","defaultValue":"127.0.0.1:2181","placeholder":"registerAddress","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 22
-- sourceVersion: 2.5.1-upgrade-2.6.0
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.5.1-upgrade-2.6.0-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1678997557628272641', '17', 'registerAddress', 'registerAddress', 2, 3, 1, '{"required":"0","defaultValue":"127.0.0.1:2181","placeholder":"registerAddress","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 23
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172834', '17', 'registerProtocol', 'registerProtocol', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"registerProtocol\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 24
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172835', '17', 'corethreads', 'corethreads', 1, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 25
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172836', '17', 'threads', 'threads', 1, 1, 3, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 26
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172837', '17', 'queues', 'queues', 1, 1, 4, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 27
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172838', '17', 'threadpool', 'threadpool', 3, 1, 5, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 28
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- INSERT INTO `plugin_handle` VALUES ('1878997557628272641', '17', 'registerAddress', 'registerAddress', 2, 1, 1, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"registerAddress\",\"rule\":\"\"}', '2023-01-10 10:08:01.158', '2023-01-10 10:08:01.158')

-- Fragment 29
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `api_rule_relation` WHERE `rule_id` IN (
--     SELECT `id` FROM (SELECT `r`.`id`
--         FROM `rule` `r`
--         INNER JOIN `selector` `s` ON `r`.`selector_id` = `s`.`id`
--         WHERE `s`.`plugin_id` = '17') AS `motan_rule_ids`
-- )

-- Fragment 30
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `rule_condition` WHERE `rule_id` IN (
--     SELECT `id` FROM (SELECT `r`.`id`
--         FROM `rule` `r`
--         INNER JOIN `selector` `s` ON `r`.`selector_id` = `s`.`id`
--         WHERE `s`.`plugin_id` = '17') AS `motan_rule_ids`
-- )

-- Fragment 31
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `rule` WHERE `selector_id` IN (
--     SELECT `id` FROM (SELECT `id` FROM `selector` WHERE `plugin_id` = '17') AS `motan_selector_ids`
-- )

-- Fragment 32
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `selector_condition` WHERE `selector_id` IN (
--     SELECT `id` FROM (SELECT `id` FROM `selector` WHERE `plugin_id` = '17') AS `motan_selector_ids`
-- )

-- Fragment 33
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `selector` WHERE `plugin_id` = '17'

-- Fragment 34
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `meta_data` WHERE `rpc_type` = 'motan'

-- Fragment 35
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `api` WHERE `rpc_type` = 'motan'

-- Fragment 36
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `namespace_plugin_rel` WHERE `plugin_id` = '17'

-- Fragment 37
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-mysql.sql
-- DELETE FROM `plugin_handle` WHERE `plugin_id` = '17'

-- Fragment 38
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172834', '17', 'registerProtocol', 'registerProtocol', 2, 1, 0, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"registerProtocol\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 39
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172835', '17', 'corethreads', 'corethreads', 1, 1, 2, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"corethreads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 40
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172836', '17', 'threads', 'threads', 1, 1, 3, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threads\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 41
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172837', '17', 'queues', 'queues', 1, 1, 4, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"queues\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 42
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1829402613204172838', '17', 'threadpool', 'threadpool', 3, 1, 5, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"threadpool\",\"rule\":\"\"}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 43
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- INSERT INTO `plugin_handle` VALUES ('1878997557628272641', '17', 'registerAddress', 'registerAddress', 2, 1, 1, '{\"required\":\"0\",\"defaultValue\":\"\",\"placeholder\":\"registerAddress\",\"rule\":\"\"}', '2023-01-10 10:08:01.158', '2023-01-10 10:08:01.158')

-- Fragment 44
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `api_rule_relation` WHERE `rule_id` IN (
--     SELECT `id` FROM (SELECT `r`.`id`
--         FROM `rule` `r`
--         INNER JOIN `selector` `s` ON `r`.`selector_id` = `s`.`id`
--         WHERE `s`.`plugin_id` = '17') AS `motan_rule_ids`
-- )

-- Fragment 45
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `rule_condition` WHERE `rule_id` IN (
--     SELECT `id` FROM (SELECT `r`.`id`
--         FROM `rule` `r`
--         INNER JOIN `selector` `s` ON `r`.`selector_id` = `s`.`id`
--         WHERE `s`.`plugin_id` = '17') AS `motan_rule_ids`
-- )

-- Fragment 46
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `rule` WHERE `selector_id` IN (
--     SELECT `id` FROM (SELECT `id` FROM `selector` WHERE `plugin_id` = '17') AS `motan_selector_ids`
-- )

-- Fragment 47
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `selector_condition` WHERE `selector_id` IN (
--     SELECT `id` FROM (SELECT `id` FROM `selector` WHERE `plugin_id` = '17') AS `motan_selector_ids`
-- )

-- Fragment 48
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `selector` WHERE `plugin_id` = '17'

-- Fragment 49
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `meta_data` WHERE `rpc_type` = 'motan'

-- Fragment 50
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `api` WHERE `rpc_type` = 'motan'

-- Fragment 51
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `namespace_plugin_rel` WHERE `plugin_id` = '17'

-- Fragment 52
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-ob.sql
-- DELETE FROM `plugin_handle` WHERE `plugin_id` = '17'

-- Fragment 53
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829402613204172834', '17', 'registerProtocol', 'registerProtocol', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"registerProtocol","rule":""}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 54
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829402613204172835', '17', 'corethreads', 'corethreads', 1, 1, 2, '{"required":"0","defaultValue":"","placeholder":"corethreads","rule":""}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 55
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829402613204172836', '17', 'threads', 'threads', 1, 1, 3, '{"required":"0","defaultValue":"","placeholder":"threads","rule":""}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 56
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829402613204172837', '17', 'queues', 'queues', 1, 1, 4, '{"required":"0","defaultValue":"","placeholder":"queues","rule":""}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 57
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829402613204172838', '17', 'threadpool', 'threadpool', 3, 1, 5, '{"required":"0","defaultValue":"","placeholder":"threadpool","rule":""}', '2022-05-25 18:02:53', '2022-05-25 18:02:53')

-- Fragment 58
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1878997557628272641', '17', 'registerAddress', 'registerAddress', 2, 1, 1, '{"required":"0","defaultValue":"","placeholder":"registerAddress","rule":""}', '2023-01-10 10:08:01.158', '2023-01-10 10:08:01.158')

-- Fragment 59
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."api_rule_relation" WHERE "rule_id" IN (
--     SELECT "id" FROM (
--         SELECT "r"."id"
--         FROM "public"."rule" "r"
--         INNER JOIN "public"."selector" "s" ON "r"."selector_id" = "s"."id"
--         WHERE "s"."plugin_id" = '17'
--     ) AS "motan_rule_ids"
-- )

-- Fragment 60
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."rule_condition" WHERE "rule_id" IN (
--     SELECT "id" FROM (
--         SELECT "r"."id"
--         FROM "public"."rule" "r"
--         INNER JOIN "public"."selector" "s" ON "r"."selector_id" = "s"."id"
--         WHERE "s"."plugin_id" = '17'
--     ) AS "motan_rule_ids"
-- )

-- Fragment 61
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."rule" WHERE "selector_id" IN (
--     SELECT "id" FROM (SELECT "id" FROM "public"."selector" WHERE "plugin_id" = '17') AS "motan_selector_ids"
-- )

-- Fragment 62
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."selector_condition" WHERE "selector_id" IN (
--     SELECT "id" FROM (SELECT "id" FROM "public"."selector" WHERE "plugin_id" = '17') AS "motan_selector_ids"
-- )

-- Fragment 63
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."selector" WHERE "plugin_id" = '17'

-- Fragment 64
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."meta_data" WHERE "rpc_type" = 'motan'

-- Fragment 65
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."api" WHERE "rpc_type" = 'motan'

-- Fragment 66
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."namespace_plugin_rel" WHERE "plugin_id" = '17'

-- Fragment 67
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-og.sql
-- DELETE FROM "public"."plugin_handle" WHERE "plugin_id" = '17'

-- Fragment 68
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1818229897214468142', '17', 'registerProtocol', 'registerProtocol', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"registerProtocol","rule":""}')

-- Fragment 69
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX(plugin_handle(plugin_id, field, type)) */ into plugin_handle (ID, PLUGIN_ID, FIELD, LABEL, DATA_TYPE, TYPE, SORT, EXT_OBJ)
-- values ('1879002911061737473', '17', 'registerAddress', 'registerAddress', 2, 1, 1, '{"required":"0","defaultValue":"","placeholder":"registerAddress","rule":""}')

-- Fragment 70
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM api_rule_relation WHERE rule_id IN (
--     SELECT id FROM (
--         SELECT r.id
--         FROM rule r
--         INNER JOIN selector s ON r.selector_id = s.id
--         WHERE s.plugin_id = '17'
--     )
-- )

-- Fragment 71
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM rule_condition WHERE rule_id IN (
--     SELECT id FROM (
--         SELECT r.id
--         FROM rule r
--         INNER JOIN selector s ON r.selector_id = s.id
--         WHERE s.plugin_id = '17'
--     )
-- )

-- Fragment 72
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM rule WHERE selector_id IN (
--     SELECT id FROM (SELECT id FROM selector WHERE plugin_id = '17')
-- )

-- Fragment 73
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM selector_condition WHERE selector_id IN (
--     SELECT id FROM (SELECT id FROM selector WHERE plugin_id = '17')
-- )

-- Fragment 74
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM selector WHERE plugin_id = '17'

-- Fragment 75
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM meta_data WHERE rpc_type = 'motan'

-- Fragment 76
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM api WHERE rpc_type = 'motan'

-- Fragment 77
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM namespace_plugin_rel WHERE plugin_id = '17'

-- Fragment 78
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-oracle.sql
-- DELETE FROM plugin_handle WHERE plugin_id = '17'

-- Fragment 79
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829403902783524879', '17', 'registerProtocol', 'registerProtocol', 2, 1, 0, '{"required":"0","defaultValue":"","placeholder":"registerProtocol","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 80
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1878997557628272641', '17', 'registerAddress', 'registerAddress', 2, 1, 1, '{"required":"0","defaultValue":"","placeholder":"registerAddress","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 81
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829403902783524880', '17', 'corethreads', 'corethreads', 1, 1, 2, '{"required":"0","defaultValue":"","placeholder":"corethreads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 82
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829403902783524881', '17', 'threads', 'threads', 1, 1, 3, '{"required":"0","defaultValue":"","placeholder":"threads","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 83
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829403902783524882', '17', 'queues', 'queues', 1, 1, 4, '{"required":"0","defaultValue":"","placeholder":"queues","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 84
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- INSERT INTO "public"."plugin_handle" VALUES ('1829403902783524883', '17', 'threadpool', 'threadpool', 3, 1, 5, '{"required":"0","defaultValue":"","placeholder":"threadpool","rule":""}', '2022-05-25 18:08:01', '2022-05-25 18:08:01')

-- Fragment 85
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."api_rule_relation" WHERE "rule_id" IN (
--     SELECT "id" FROM (
--         SELECT "r"."id"
--         FROM "public"."rule" "r"
--         INNER JOIN "public"."selector" "s" ON "r"."selector_id" = "s"."id"
--         WHERE "s"."plugin_id" = '17'
--     ) AS "motan_rule_ids"
-- )

-- Fragment 86
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."rule_condition" WHERE "rule_id" IN (
--     SELECT "id" FROM (
--         SELECT "r"."id"
--         FROM "public"."rule" "r"
--         INNER JOIN "public"."selector" "s" ON "r"."selector_id" = "s"."id"
--         WHERE "s"."plugin_id" = '17'
--     ) AS "motan_rule_ids"
-- )

-- Fragment 87
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."rule" WHERE "selector_id" IN (
--     SELECT "id" FROM (SELECT "id" FROM "public"."selector" WHERE "plugin_id" = '17') AS "motan_selector_ids"
-- )

-- Fragment 88
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."selector_condition" WHERE "selector_id" IN (
--     SELECT "id" FROM (SELECT "id" FROM "public"."selector" WHERE "plugin_id" = '17') AS "motan_selector_ids"
-- )

-- Fragment 89
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."selector" WHERE "plugin_id" = '17'

-- Fragment 90
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."meta_data" WHERE "rpc_type" = 'motan'

-- Fragment 91
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."api" WHERE "rpc_type" = 'motan'

-- Fragment 92
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."namespace_plugin_rel" WHERE "plugin_id" = '17'

-- Fragment 93
-- sourceVersion: 2.7.0-upgrade-2.7.1
-- sourceSHA: ec198d442894fd9617947ed73c6c8fe3b206f665
-- sourceFile: db/upgrade/2.7.0-upgrade-2.7.1-pg.sql
-- DELETE FROM "public"."plugin_handle" WHERE "plugin_id" = '17'
