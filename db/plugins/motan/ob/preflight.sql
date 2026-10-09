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

-- Preflight checks for motan (motan).
-- Source: apache/shenyu c8961528b72a2a7f81f0d1cd7525af1659a670bc:db/init/ob/schema.sql
-- Run this script before install.sql. Any returned error means the install is unsupported
-- until the conflicting row is reconciled manually.

DELIMITER $$
DROP PROCEDURE IF EXISTS shenyu_preflight_motan$$
CREATE PROCEDURE shenyu_preflight_motan()
BEGIN
  IF EXISTS (SELECT 1 FROM plugin WHERE id = '17' AND name <> 'motan') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin id is occupied by another name';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin WHERE name = 'motan' AND id <> '17') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'canonical plugin name exists under another id';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172834' AND NOT (plugin_id = '17' AND field = 'registerProtocol' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172834';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerProtocol' AND type = 3 AND id <> '1529402613204172834') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172834';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172835' AND NOT (plugin_id = '17' AND field = 'corethreads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172835';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'corethreads' AND type = 3 AND id <> '1529402613204172835') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172835';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172836' AND NOT (plugin_id = '17' AND field = 'threads' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172836';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'threads' AND type = 3 AND id <> '1529402613204172836') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172836';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172837' AND NOT (plugin_id = '17' AND field = 'queues' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172837';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'queues' AND type = 3 AND id <> '1529402613204172837') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172837';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1529402613204172838' AND NOT (plugin_id = '17' AND field = 'threadpool' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1529402613204172838';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'threadpool' AND type = 3 AND id <> '1529402613204172838') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1529402613204172838';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1829402613204172834' AND NOT (plugin_id = '17' AND field = 'registerProtocol' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1829402613204172834';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerProtocol' AND type = 1 AND id <> '1829402613204172834') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1829402613204172834';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1878997557628272641' AND NOT (plugin_id = '17' AND field = 'registerAddress' AND type = 1)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1878997557628272641';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerAddress' AND type = 1 AND id <> '1878997557628272641') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1878997557628272641';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE id = '1678997557628272641' AND NOT (plugin_id = '17' AND field = 'registerAddress' AND type = 3)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle id collision: 1678997557628272641';
  END IF;
  IF EXISTS (SELECT 1 FROM plugin_handle WHERE plugin_id = '17' AND field = 'registerAddress' AND type = 3 AND id <> '1678997557628272641') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'plugin_handle natural-key collision: 1678997557628272641';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639284355079';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435474' AND NOT (id = '1529402639372435474' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435474';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435474';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435475' AND NOT (id = '1529402639372435475' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435475';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435475';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435476' AND NOT (id = '1529402639372435476' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435476';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435476';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435477' AND NOT (id = '1529402639372435477' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435477';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435477';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435478' AND NOT (id = '1529402639372435478' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435478';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435478';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435479' AND NOT (id = '1529402639372435479' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435479';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435479';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435480' AND NOT (id = '1529402639372435480' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435480';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435480';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435481' AND NOT (id = '1529402639372435481' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435481';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435481';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435482' AND NOT (id = '1529402639372435482' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motan:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource id collision: 1529402639372435482';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'resource parent identity collision: 1529402639372435482';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639305326600' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639284355079')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639305326600';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639284355079' AND id <> '1529402639305326600') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639305326600';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639284355079' AND NOT (id = '1529402639284355079' AND parent_id = '1346775491550474240' AND name = 'motan' AND perms = '')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639305326600';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435735' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435474')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435735';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435474' AND id <> '1529402639372435735') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435735';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435474' AND NOT (id = '1529402639372435474' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435735';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435736' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435475')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435736';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435475' AND id <> '1529402639372435736') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435736';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435475' AND NOT (id = '1529402639372435475' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435736';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435737' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435476')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435737';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435476' AND id <> '1529402639372435737') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435737';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435476' AND NOT (id = '1529402639372435476' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435737';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435738' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435477')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435738';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435477' AND id <> '1529402639372435738') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435738';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435477' AND NOT (id = '1529402639372435477' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanSelector:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435738';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435739' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435478')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435739';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435478' AND id <> '1529402639372435739') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435739';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435478' AND NOT (id = '1529402639372435478' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:add')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435739';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435740' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435479')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435740';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435479' AND id <> '1529402639372435740') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435740';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435479' AND NOT (id = '1529402639372435479' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:query')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435740';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435741' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435480')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435741';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435480' AND id <> '1529402639372435741') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435741';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435480' AND NOT (id = '1529402639372435480' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:edit')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435741';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435742' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435481')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435742';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435481' AND id <> '1529402639372435742') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435742';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435481' AND NOT (id = '1529402639372435481' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motanRule:delete')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435742';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE id = '1529402639372435743' AND NOT (object_id = '1346358560427216896' AND resource_id = '1529402639372435482')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission id collision: 1529402639372435743';
  END IF;
  IF EXISTS (SELECT 1 FROM permission WHERE object_id = '1346358560427216896' AND resource_id = '1529402639372435482' AND id <> '1529402639372435743') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission natural-key collision: 1529402639372435743';
  END IF;
  IF EXISTS (SELECT 1 FROM resource WHERE id = '1529402639372435482' AND NOT (id = '1529402639372435482' AND parent_id = '1529402639284355079' AND name = '' AND perms = 'plugin:motan:modify')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'permission resource identity collision: 1529402639372435743';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE id = '1801816010882822153' AND NOT (namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '17')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel id collision: 1801816010882822153';
  END IF;
  IF EXISTS (SELECT 1 FROM namespace_plugin_rel WHERE namespace_id = '649330b6-c2d7-4edc-be8e-8a54df9eb385' AND plugin_id = '17' AND id <> '1801816010882822153') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'namespace_plugin_rel natural-key collision: 1801816010882822153';
  END IF;
END$$
DELIMITER ;
CALL shenyu_preflight_motan();
DROP PROCEDURE IF EXISTS shenyu_preflight_motan;
