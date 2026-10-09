#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

PLUGIN="${1:?Usage: $0 <plugin-slug> <case-module-path>}"
CASE_MODULE="${2:?Usage: $0 <plugin-slug> <case-module-path>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT:-31095}"
SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-31195}"
E2E_ADMIN_BASE_URL="http://localhost:${SHENYU_ADMIN_PORT}"
E2E_GATEWAY_BASE_URL="http://localhost:${SHENYU_BOOTSTRAP_PORT}"
E2E_MAVEN_ARGS=(
  -DskipTests=false
  -Dshenyu.e2e.admin.baseUrl="${E2E_ADMIN_BASE_URL}"
  -Dshenyu.e2e.gateway.baseUrl="${E2E_GATEWAY_BASE_URL}"
  -Dshenyu.e2e.service.shenyu-e2e-admin.baseUrl="${E2E_ADMIN_BASE_URL}"
  -Dshenyu.e2e.service.shenyu-e2e-gateway.baseUrl="${E2E_GATEWAY_BASE_URL}"
  "-DargLine=-Dshenyu.e2e.admin.baseUrl=${E2E_ADMIN_BASE_URL} -Dshenyu.e2e.gateway.baseUrl=${E2E_GATEWAY_BASE_URL} -Dshenyu.e2e.service.shenyu-e2e-admin.baseUrl=${E2E_ADMIN_BASE_URL} -Dshenyu.e2e.service.shenyu-e2e-gateway.baseUrl=${E2E_GATEWAY_BASE_URL}"
  -Dapi.version="${API_VERSION:-1.44}"
)

if [[ ! -f "${CASE_MODULE}/pom.xml" ]]; then
  echo "Original E2E case module is missing pom.xml: ${CASE_MODULE}" >&2
  exit 1
fi

if [[ "${BUILD_STORE_JARS:-false}" == "true" ]]; then
  "${SCRIPT_DIR}/build-store-plugin-jars.sh" "${PLUGIN}"
fi
"${SCRIPT_DIR}/assert-store-fixtures.sh" "${PLUGIN}"
mvn -B -ntp -Pe2e -pl shenyu-e2e/shenyu-plugin-store-e2e-common -am install -DskipTests -Dapi.version="${API_VERSION:-1.44}"

if [[ "${RUN_ORIGINAL_COMPOSE:-true}" == "true" ]]; then
  "${SCRIPT_DIR}/run-core-compose.sh" "${PLUGIN}" -- mvn -B -ntp -f "${CASE_MODULE}/pom.xml" test "${E2E_MAVEN_ARGS[@]}"
else
  mvn -B -ntp -f "${CASE_MODULE}/pom.xml" test "${E2E_MAVEN_ARGS[@]}"
fi
