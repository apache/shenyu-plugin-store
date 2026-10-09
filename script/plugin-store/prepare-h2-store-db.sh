#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

PLUGIN="${1:?Usage: $0 <plugin-slug>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
CORE_SOURCE="${SHENYU_CORE_SOURCE:-/tmp/shenyu-remaining-source}"
STORE_PLUGIN_SQL_DIR="${STORE_PLUGIN_SQL_DIR:-db/plugins/${PLUGIN}}"
STORE_H2_DIR="${STORE_H2_DIR:-target/plugin-store-h2/${PLUGIN}}"
H2_VERSION="${H2_VERSION:-2.2.224}"
H2_JAR="${HOME}/.m2/repository/com/h2database/h2/${H2_VERSION}/h2-${H2_VERSION}.jar"
DB_FILE="${STORE_H2_DIR}/shenyu"
FIXTURE_DIR="${STORE_H2_DIR}/strict-sql-fixture"

case "${PLUGIN}" in
  hystrix)
    DEFAULT_PLUGIN_ID="9"
    ;;
  logging-rabbitmq|loggingRabbitMQ|rabbitmq)
    DEFAULT_PLUGIN_ID="45"
    ;;
  *)
    DEFAULT_PLUGIN_ID=""
    ;;
esac
STORE_PLUGIN_ID="${STORE_PLUGIN_ID:-${DEFAULT_PLUGIN_ID}}"

if [[ ! -d "${STORE_PLUGIN_SQL_DIR}" ]]; then
  echo "Missing store SQL directory: ${STORE_PLUGIN_SQL_DIR}" >&2
  exit 1
fi
if [[ ! -f "${STORE_PLUGIN_SQL_DIR}/h2/install.sql" ]]; then
  echo "Missing store H2 install.sql: ${STORE_PLUGIN_SQL_DIR}/h2/install.sql" >&2
  exit 1
fi
if [[ ! -f "${STORE_PLUGIN_SQL_DIR}/h2/preflight.sql" ]]; then
  echo "Missing store H2 preflight.sql: ${STORE_PLUGIN_SQL_DIR}/h2/preflight.sql" >&2
  exit 1
fi
if [[ ! -f "${STORE_PLUGIN_SQL_DIR}/row-manifest.json" ]]; then
  echo "Missing shipped row-manifest.json: ${STORE_PLUGIN_SQL_DIR}/row-manifest.json" >&2
  exit 1
fi
if [[ -n "${STORE_PLUGIN_ID}" ]]; then
  MANIFEST_PLUGIN_ID="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["pluginId"])' "${STORE_PLUGIN_SQL_DIR}/row-manifest.json")"
  if [[ "${MANIFEST_PLUGIN_ID}" != "${STORE_PLUGIN_ID}" ]]; then
    echo "STORE_PLUGIN_ID=${STORE_PLUGIN_ID} does not match shipped row-manifest pluginId=${MANIFEST_PLUGIN_ID}" >&2
    exit 1
  fi
fi
if [[ ! -f "${H2_JAR}" ]]; then
  mvn -B -ntp -f "${REPO_ROOT}/pom.xml" dependency:get -Dartifact="com.h2database:h2:${H2_VERSION}" -Dtransitive=false
fi

rm -rf "${STORE_H2_DIR}"
mkdir -p "${STORE_H2_DIR}"
STORE_H2_DIR="$(cd "${STORE_H2_DIR}" && pwd)"
DB_FILE="${STORE_H2_DIR}/shenyu"
FIXTURE_DIR="${STORE_H2_DIR}/strict-sql-fixture"

python3 "${SCRIPT_DIR}/build-h2-store-sql-fixture.py" "${PLUGIN}" \
  --core-source "${CORE_SOURCE}" \
  --store-sql-dir "${STORE_PLUGIN_SQL_DIR}" \
  --output-dir "${FIXTURE_DIR}" \
  --h2-jar "${H2_JAR}" \
  --h2-password sa \
  --require-row-manifest \
  --execute \
  --verify-conflicts \
  --verify-custom-config \
  --prepare-db-file "${DB_FILE}"

CONF_EXT_DIR="${STORE_H2_DIR}/conf-ext"
mkdir -p "${CONF_EXT_DIR}"
cat > "${CONF_EXT_DIR}/application-h2.yml" <<EOF
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

shenyu:
  database:
    dialect: h2
    init_enable: false
  jwt:
    secretKey: shenyu-plugin-store-harness-secret-key-for-local-tests

spring:
  datasource:
    url: jdbc:h2:file:/opt/shenyu-data/shenyu;DB_CLOSE_DELAY=-1;MODE=MySQL;DATABASE_TO_UPPER=false;CASE_INSENSITIVE_IDENTIFIERS=TRUE;
    username: sa
    password: sa
    driver-class-name: org.h2.Driver
  mail:
    host: smtp.qq.com
    username: shenyu@apache.com
    password: your-password
    port: 465
    default-encoding: UTF-8
    properties:
      mail:
        smtp:
          socketFactoryClass: javax.net.ssl.SSLSocketFactory
          ssl:
            enable: true
EOF

echo "Prepared H2 database at ${STORE_H2_DIR}; mount ${STORE_H2_DIR} to /opt/shenyu-data"
