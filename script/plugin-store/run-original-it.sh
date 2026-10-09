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
SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-31195}"
CASE_MAVEN_PROFILE="${CASE_MAVEN_PROFILE:-}"
CASE_PROFILE_ARGS=()
if [[ -n "${CASE_MAVEN_PROFILE}" ]]; then
  CASE_PROFILE_ARGS=(-P"${CASE_MAVEN_PROFILE}")
fi
EXTRA_MAVEN_ARGS=()
if [[ -n "${CASE_MAVEN_ARGS:-}" ]]; then
  # shellcheck disable=SC2206
  EXTRA_MAVEN_ARGS=(${CASE_MAVEN_ARGS})
fi

if [[ ! -f "${CASE_MODULE}/pom.xml" ]]; then
  echo "Original IT case module is missing pom.xml: ${CASE_MODULE}" >&2
  exit 1
fi

if [[ "${BUILD_STORE_JARS:-false}" == "true" ]]; then
  "${SCRIPT_DIR}/build-store-plugin-jars.sh" "${PLUGIN}"
fi
"${SCRIPT_DIR}/assert-store-fixtures.sh" "${PLUGIN}"
mvn -B -ntp -Pintegration-tests -pl shenyu-integrated-test/shenyu-plugin-store-it-common -am install -DskipTests -Dapi.version="${API_VERSION:-1.44}"

MAVEN_CMD=(mvn -B -ntp -f "${CASE_MODULE}/pom.xml")
if [[ -n "${CASE_MAVEN_PROFILE}" ]]; then
  MAVEN_CMD+=("-P${CASE_MAVEN_PROFILE}")
fi
MAVEN_CMD+=(test -DskipTests=false -Dshenyu.gateway.url="http://localhost:${SHENYU_BOOTSTRAP_PORT}"
  -Dshenyu.store.http.upstream="${STORE_HTTP_BACKEND_UPSTREAM:-http://plugin-store-backend:9080}"
  -Dapi.version="${API_VERSION:-1.44}")
if [[ ${#EXTRA_MAVEN_ARGS[@]} -gt 0 ]]; then
  MAVEN_CMD+=("${EXTRA_MAVEN_ARGS[@]}")
fi

if [[ "${RUN_ORIGINAL_COMPOSE:-true}" == "true" ]]; then
  "${SCRIPT_DIR}/run-core-compose.sh" "${PLUGIN}" -- "${MAVEN_CMD[@]}"
else
  "${MAVEN_CMD[@]}"
fi
