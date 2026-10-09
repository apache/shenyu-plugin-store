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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_clickhouse$$
CREATE PROCEDURE shenyu_preflight_logging_clickhouse()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '38' AND name <> 'loggingClickHouse') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingClickHouse' AND id <> '38') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172767' AND NOT (plugin_id = '38' AND field = 'keyword' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172767';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172767') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172767';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172768' AND NOT (plugin_id = '38' AND field = 'maskType' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172768';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172768') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172768';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172769' AND NOT (plugin_id = '38' AND field = 'maskStatus' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172769';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172769') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172769';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172770' AND NOT (plugin_id = '38' AND field = 'host' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172770';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'host' AND type = 3 AND id <> '1529402613204172770') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172770';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172771' AND NOT (plugin_id = '38' AND field = 'port' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172771';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'port' AND type = 3 AND id <> '1529402613204172771') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172771';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172772' AND NOT (plugin_id = '38' AND field = 'database' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172772';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'database' AND type = 3 AND id <> '1529402613204172772') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172772';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172773' AND NOT (plugin_id = '38' AND field = 'username' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172773';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'username' AND type = 3 AND id <> '1529402613204172773') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172773';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172774' AND NOT (plugin_id = '38' AND field = 'password' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172774';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'password' AND type = 3 AND id <> '1529402613204172774') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172774';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172775' AND NOT (plugin_id = '38' AND field = 'engine' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172775';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'engine' AND type = 3 AND id <> '1529402613204172775') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172775';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172776' AND NOT (plugin_id = '38' AND field = 'clusterName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172776';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'clusterName' AND type = 3 AND id <> '1529402613204172776') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172776';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172777' AND NOT (plugin_id = '38' AND field = 'ttl' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172777';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'ttl' AND type = 3 AND id <> '1529402613204172777') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172777';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507019' AND NOT (plugin_id = '38' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507019';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507019') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507019';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507020' AND NOT (plugin_id = '38' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507020';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '38' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507020') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507020';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565043';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565044' AND NOT (id = '1534585531108565044' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565044';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565044';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565045' AND NOT (id = '1534585531108565045' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565045';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565045';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565046' AND NOT (id = '1534585531108565046' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565046';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565046';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565047' AND NOT (id = '1534585531108565047' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565047';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565047';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565048' AND NOT (id = '1534585531108565048' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565048';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565048';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565049' AND NOT (id = '1534585531108565049' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565049';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565049';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565050' AND NOT (id = '1534585531108565050' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565050';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565050';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565051' AND NOT (id = '1534585531108565051' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565051';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565051';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565052' AND NOT (id = '1534585531108565052' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouse:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565052';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565052';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583411' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565043')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583411';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565043' AND id <> '1534585531389583411') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583411';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565043' AND NOT (id = '1534585531108565043' AND parent_id = '1346775491550474240' AND name = 'loggingClickHouse' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583411';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583412' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565044')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583412';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565044' AND id <> '1534585531389583412') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583412';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565044' AND NOT (id = '1534585531108565044' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583412';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583413' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565045')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583413';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565045' AND id <> '1534585531389583413') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583413';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565045' AND NOT (id = '1534585531108565045' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583413';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583414' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565046')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583414';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565046' AND id <> '1534585531389583414') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583414';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565046' AND NOT (id = '1534585531108565046' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583414';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583415' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565047')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583415';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565047' AND id <> '1534585531389583415') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583415';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565047' AND NOT (id = '1534585531108565047' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583415';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583416' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565048')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583416';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565048' AND id <> '1534585531389583416') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583416';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565048' AND NOT (id = '1534585531108565048' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583416';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583417' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565049')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583417';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565049' AND id <> '1534585531389583417') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583417';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565049' AND NOT (id = '1534585531108565049' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583417';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583418' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565050')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583418';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565050' AND id <> '1534585531389583418') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583418';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565050' AND NOT (id = '1534585531108565050' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583418';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583419' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565051')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583419';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565051' AND id <> '1534585531389583419') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583419';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565051' AND NOT (id = '1534585531108565051' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouseRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583419';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583420' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565052')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583420';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565052' AND id <> '1534585531389583420') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583420';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565052' AND NOT (id = '1534585531108565052' AND parent_id = '1534585531108565043' AND name = '' AND perms = 'plugin:loggingClickHouse:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583420';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822175' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '38')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822175';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '38' AND id <> '1801816010882822175') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822175';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_clickhouse();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_clickhouse;
