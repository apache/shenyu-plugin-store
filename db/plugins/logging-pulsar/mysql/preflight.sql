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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_pulsar$$
CREATE PROCEDURE shenyu_preflight_logging_pulsar()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '35' AND name <> 'loggingPulsar') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingPulsar' AND id <> '35') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172916' AND NOT (plugin_id = '35' AND field = 'topic' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172916';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'topic' AND type = 3 AND id <> '1529402613204172916') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172916';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172917' AND NOT (plugin_id = '35' AND field = 'serviceUrl' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172917';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'serviceUrl' AND type = 3 AND id <> '1529402613204172917') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172917';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172918' AND NOT (plugin_id = '35' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172918';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'sampleRate' AND type = 3 AND id <> '1529402613204172918') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172918';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172919' AND NOT (plugin_id = '35' AND field = 'maxResponseBody' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172919';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maxResponseBody' AND type = 3 AND id <> '1529402613204172919') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172919';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172920' AND NOT (plugin_id = '35' AND field = 'maxRequestBody' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172920';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maxRequestBody' AND type = 3 AND id <> '1529402613204172920') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172920';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172921' AND NOT (plugin_id = '35' AND field = 'compressAlg' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172921';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'compressAlg' AND type = 3 AND id <> '1529402613204172921') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172921';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172761' AND NOT (plugin_id = '35' AND field = 'keyword' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172761';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'keyword' AND type = 2 AND id <> '1529402613204172761') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172761';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172762' AND NOT (plugin_id = '35' AND field = 'maskType' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172762';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maskType' AND type = 2 AND id <> '1529402613204172762') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172762';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172763' AND NOT (plugin_id = '35' AND field = 'maskStatus' AND type = 2)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172763';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'maskStatus' AND type = 2 AND id <> '1529402613204172763') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172763';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507018' AND NOT (plugin_id = '35' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507018';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '35' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507018') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507018';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565023';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565024' AND NOT (id = '1534585531108565024' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565024';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565024';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565025' AND NOT (id = '1534585531108565025' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565025';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565025';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565026' AND NOT (id = '1534585531108565026' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565026';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565026';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565027' AND NOT (id = '1534585531108565027' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565027';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565027';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565028' AND NOT (id = '1534585531108565028' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565028';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565028';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565029' AND NOT (id = '1534585531108565029' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565029';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565029';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565030' AND NOT (id = '1534585531108565030' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565030';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565030';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565031' AND NOT (id = '1534585531108565031' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565031';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565031';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565032' AND NOT (id = '1534585531108565032' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsar:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1534585531108565032';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1534585531108565032';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583391' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565023')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583391';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565023' AND id <> '1534585531389583391') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583391';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565023' AND NOT (id = '1534585531108565023' AND parent_id = '1346775491550474240' AND name = 'loggingPulsar' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583391';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583392' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565024')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583392';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565024' AND id <> '1534585531389583392') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583392';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565024' AND NOT (id = '1534585531108565024' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583392';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583393' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565025')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583393';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565025' AND id <> '1534585531389583393') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583393';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565025' AND NOT (id = '1534585531108565025' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583393';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583394' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565026')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583394';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565026' AND id <> '1534585531389583394') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583394';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565026' AND NOT (id = '1534585531108565026' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583394';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583395' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565027')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583395';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565027' AND id <> '1534585531389583395') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583395';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565027' AND NOT (id = '1534585531108565027' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583395';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583396' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565028')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583396';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565028' AND id <> '1534585531389583396') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583396';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565028' AND NOT (id = '1534585531108565028' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583396';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583397' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565029')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583397';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565029' AND id <> '1534585531389583397') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583397';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565029' AND NOT (id = '1534585531108565029' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583397';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583398' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565030')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583398';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565030' AND id <> '1534585531389583398') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583398';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565030' AND NOT (id = '1534585531108565030' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583398';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583399' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565031')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583399';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565031' AND id <> '1534585531389583399') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583399';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565031' AND NOT (id = '1534585531108565031' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsarRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583399';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1534585531389583400' AND NOT (object_id = '1346358560427216896' AND resource_id = '1534585531108565032')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1534585531389583400';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1534585531108565032' AND id <> '1534585531389583400') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1534585531389583400';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1534585531108565032' AND NOT (id = '1534585531108565032' AND parent_id = '1534585531108565023' AND name = '' AND perms = 'plugin:loggingPulsar:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1534585531389583400';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822173' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '35')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822173';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '35' AND id <> '1801816010882822173') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822173';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_pulsar();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_pulsar;
