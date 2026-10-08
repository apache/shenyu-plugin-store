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
-- Source: apache/shenyu ec198d442894fd9617947ed73c6c8fe3b206f665:db/init/mysql/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_rabbitmq$$
CREATE PROCEDURE shenyu_preflight_logging_rabbitmq()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '45' AND name <> 'loggingRabbitMQ') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'loggingRabbitMQ' AND id <> '45') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721435546642157568' AND NOT (plugin_id = '45' AND field = 'host' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721435546642157568';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'host' AND type = 3 AND id <> '1721435546642157568') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721435546642157568';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721435708743618560' AND NOT (plugin_id = '45' AND field = 'port' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721435708743618560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'port' AND type = 3 AND id <> '1721435708743618560') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721435708743618560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436368046264320' AND NOT (plugin_id = '45' AND field = 'password' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721436368046264320';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'password' AND type = 3 AND id <> '1721436368046264320') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721436368046264320';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436500343001088' AND NOT (plugin_id = '45' AND field = 'username' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721436500343001088';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'username' AND type = 3 AND id <> '1721436500343001088') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721436500343001088';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436639635836928' AND NOT (plugin_id = '45' AND field = 'exchangeName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721436639635836928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeName' AND type = 3 AND id <> '1721436639635836928') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721436639635836928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721436745583955968' AND NOT (plugin_id = '45' AND field = 'queueName' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721436745583955968';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'queueName' AND type = 3 AND id <> '1721436745583955968') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721436745583955968';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721509996347617280' AND NOT (plugin_id = '45' AND field = 'routingKey' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721509996347617280';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'routingKey' AND type = 3 AND id <> '1721509996347617280') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721509996347617280';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721725585461706752' AND NOT (plugin_id = '45' AND field = 'virtualHost' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721725585461706752';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'virtualHost' AND type = 3 AND id <> '1721725585461706752') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721725585461706752';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1721725662875975680' AND NOT (plugin_id = '45' AND field = 'exchangeType' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1721725662875975680';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeType' AND type = 3 AND id <> '1721725662875975680') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1721725662875975680';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804180904927232' AND NOT (plugin_id = '45' AND field = 'durable' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804180904927232';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'durable' AND type = 3 AND id <> '1722804180904927232') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804180904927232';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804370575548416' AND NOT (plugin_id = '45' AND field = 'exclusive' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804370575548416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exclusive' AND type = 3 AND id <> '1722804370575548416') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804370575548416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804461256400896' AND NOT (plugin_id = '45' AND field = 'autoDelete' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804461256400896';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'autoDelete' AND type = 3 AND id <> '1722804461256400896') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804461256400896';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507008' AND NOT (plugin_id = '45' AND field = 'args' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507008';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'args' AND type = 3 AND id <> '1722804548510507008') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507008';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821435546642157568' AND NOT (plugin_id = '45' AND field = 'host' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821435546642157568';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'host' AND type = 1 AND id <> '1821435546642157568') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821435546642157568';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821435708743618560' AND NOT (plugin_id = '45' AND field = 'port' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821435708743618560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'port' AND type = 1 AND id <> '1821435708743618560') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821435708743618560';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436368046264320' AND NOT (plugin_id = '45' AND field = 'password' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821436368046264320';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'password' AND type = 1 AND id <> '1821436368046264320') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821436368046264320';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436500343001088' AND NOT (plugin_id = '45' AND field = 'username' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821436500343001088';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'username' AND type = 1 AND id <> '1821436500343001088') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821436500343001088';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436639635836928' AND NOT (plugin_id = '45' AND field = 'exchangeName' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821436639635836928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeName' AND type = 1 AND id <> '1821436639635836928') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821436639635836928';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821436745583955968' AND NOT (plugin_id = '45' AND field = 'queueName' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821436745583955968';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'queueName' AND type = 1 AND id <> '1821436745583955968') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821436745583955968';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821509996347617280' AND NOT (plugin_id = '45' AND field = 'routingKey' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821509996347617280';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'routingKey' AND type = 1 AND id <> '1821509996347617280') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821509996347617280';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821725585461706752' AND NOT (plugin_id = '45' AND field = 'virtualHost' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821725585461706752';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'virtualHost' AND type = 1 AND id <> '1821725585461706752') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821725585461706752';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1821725662875975680' AND NOT (plugin_id = '45' AND field = 'exchangeType' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1821725662875975680';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exchangeType' AND type = 1 AND id <> '1821725662875975680') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1821725662875975680';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804180904927232' AND NOT (plugin_id = '45' AND field = 'durable' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1822804180904927232';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'durable' AND type = 1 AND id <> '1822804180904927232') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1822804180904927232';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804370575548416' AND NOT (plugin_id = '45' AND field = 'exclusive' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1822804370575548416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'exclusive' AND type = 1 AND id <> '1822804370575548416') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1822804370575548416';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804461256400896' AND NOT (plugin_id = '45' AND field = 'autoDelete' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1822804461256400896';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'autoDelete' AND type = 1 AND id <> '1822804461256400896') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1822804461256400896';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1822804548510507008' AND NOT (plugin_id = '45' AND field = 'args' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1822804548510507008';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'args' AND type = 1 AND id <> '1822804548510507008') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1822804548510507008';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507011' AND NOT (plugin_id = '45' AND field = 'sampleRate' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507011';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'sampleRate' AND type = 3 AND id <> '1722804548510507011') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507011';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1722804548510507012' AND NOT (plugin_id = '45' AND field = 'sampleRate' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1722804548510507012';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '45' AND field = 'sampleRate' AND type = 1 AND id <> '1722804548510507012') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1722804548510507012';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362361954345';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840456' AND NOT (id = '1792749362445840456' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840456';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840456';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840457' AND NOT (id = '1792749362445840457' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840457';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840457';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840458' AND NOT (id = '1792749362445840458' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840458';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840458';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840459' AND NOT (id = '1792749362445840459' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840459';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840459';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840460' AND NOT (id = '1792749362445840460' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840460';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840460';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840461' AND NOT (id = '1792749362445840461' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840461';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840461';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840462' AND NOT (id = '1792749362445840462' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840462';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840462';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840463' AND NOT (id = '1792749362445840463' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840463';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840463';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840464' AND NOT (id = '1792749362445840464' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQ:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1792749362445840464';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1792749362445840464';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343232' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362361954345')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343232';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362361954345' AND id <> '1792779493541343232') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343232';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362361954345' AND NOT (id = '1792749362361954345' AND parent_id = '1346775491550474240' AND name = 'loggingRabbitMQ' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343232';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343233' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840456')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343233';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840456' AND id <> '1792779493541343233') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343233';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840456' AND NOT (id = '1792749362445840456' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343233';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343234' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840457')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343234';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840457' AND id <> '1792779493541343234') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343234';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840457' AND NOT (id = '1792749362445840457' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343234';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343235' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840458')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343235';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840458' AND id <> '1792779493541343235') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343235';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840458' AND NOT (id = '1792749362445840458' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343235';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343236' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840459')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343236';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840459' AND id <> '1792779493541343236') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343236';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840459' AND NOT (id = '1792749362445840459' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343236';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343237' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840460')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343237';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840460' AND id <> '1792779493541343237') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343237';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840460' AND NOT (id = '1792749362445840460' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343237';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343238' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840461')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343238';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840461' AND id <> '1792779493541343238') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343238';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840461' AND NOT (id = '1792749362445840461' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343238';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343239' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840462')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343239';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840462' AND id <> '1792779493541343239') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343239';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840462' AND NOT (id = '1792749362445840462' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343239';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343240' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840463')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343240';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840463' AND id <> '1792779493541343240') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343240';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840463' AND NOT (id = '1792749362445840463' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343240';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1792779493541343241' AND NOT (object_id = '1346358560427216896' AND resource_id = '1792749362445840464')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1792779493541343241';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1792749362445840464' AND id <> '1792779493541343241') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1792779493541343241';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1792749362445840464' AND NOT (id = '1792749362445840464' AND parent_id = '1792749362361954345' AND name = '' AND perms = 'plugin:loggingRabbitMQ:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1792779493541343241';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822182' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '45')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822182';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '45' AND id <> '1801816010882822182') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822182';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_logging_rabbitmq();
DROP PROCEDURE IF EXISTS shenyu_preflight_logging_rabbitmq;
