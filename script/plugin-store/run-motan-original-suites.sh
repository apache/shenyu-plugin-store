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

SUITE="${1:-all}"
case "${SUITE}" in
  all|it|e2e)
    ;;
  *)
    echo "Usage: $0 [all|it|e2e]" >&2
    exit 1
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
API_VERSION="${API_VERSION:-1.44}"
SPRING_BOOT_MAVEN_PLUGIN_VERSION="${SPRING_BOOT_MAVEN_PLUGIN_VERSION:-3.3.1}"
WORK_DIR="${STORE_MOTAN_WORK_DIR:-${REPO_DIR}/target/plugin-store-motan}"
REPORT_DIR="${STORE_MOTAN_REPORT_DIR:-${REPO_DIR}/target/plugin-store-motan/reports}"
PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-${WORK_DIR}/plugin-jars}"
ADMIN_JARS_DIR="${STORE_ADMIN_JARS_DIR:-${WORK_DIR}/admin-jars}"
PROVIDER_IMAGE="${STORE_HTTP_BACKEND_IMAGE:-shenyu-examples-motan:plugin-store}"
: "${SHENYU_CORE_SOURCE:?SHENYU_CORE_SOURCE is required; set it to the core checkout used for H2 schema and core images}"
CORE_SOURCE="${SHENYU_CORE_SOURCE}"
PORT_BASE="${STORE_MOTAN_PORT_BASE:-49300}"
IT_PORT_BASE="${STORE_MOTAN_IT_PORT_BASE:-${PORT_BASE}}"
E2E_PORT_BASE="${STORE_MOTAN_E2E_PORT_BASE:-$((PORT_BASE + 100))}"
MOTAN_CONNECT_TIMEOUT="${STORE_MOTAN_REGISTRY_CONNECT_TIMEOUT:-10000}"
BACKEND_DELAY_SECONDS="${STORE_MOTAN_BACKEND_DELAY_SECONDS:-10}"
MOTAN_COMPOSE_OVERRIDE="${STORE_MOTAN_COMPOSE_OVERRIDE:-${SCRIPT_DIR}/docker-compose.motan-backend.yml}"
IT_CASE_MODULE="${STORE_MOTAN_IT_CASE_MODULE:-shenyu-integrated-test/shenyu-integrated-test-motan}"
E2E_CASE_MODULE="${STORE_MOTAN_E2E_CASE_MODULE:-shenyu-e2e/shenyu-e2e-case/shenyu-e2e-case-motan}"
SKIP_ASSET_BUILD="${STORE_MOTAN_SKIP_ASSET_BUILD:-false}"

mkdir -p "${WORK_DIR}" "${REPORT_DIR}"

run_with_log() {
  local name="$1"
  shift
  local log="${REPORT_DIR}/${name}-$(date +%Y%m%d%H%M%S).log"
  echo "Writing ${name} log to ${log}"
  set +e
  "$@" 2>&1 | tee "${log}"
  local status=${PIPESTATUS[0]}
  set -e
  echo "${name} status: ${status}"
  echo "${name} log: ${log}"
  return "${status}"
}

build_admin_adapter_jars() {
  rm -rf "${ADMIN_JARS_DIR}"
  mkdir -p "${ADMIN_JARS_DIR}"
  ./mvnw -B -ntp -pl shenyu-admin/shenyu-admin-register-motan -am install \
    -DskipTests \
    -Dapi.version="${API_VERSION}"
  find shenyu-admin/shenyu-admin-register-motan/target -maxdepth 1 -type f -name '*.jar' \
    ! -name '*-sources.jar' \
    ! -name '*-javadoc.jar' \
    ! -name '*-tests.jar' \
    -exec cp {} "${ADMIN_JARS_DIR}/" \;
  if ! find "${ADMIN_JARS_DIR}" -maxdepth 1 -type f -name 'shenyu-admin-register-motan-*.jar' | grep -q .; then
    echo "Motan admin adapter jar was not copied into ${ADMIN_JARS_DIR}" >&2
    exit 1
  fi
}

build_provider_image() {
  ./mvnw -B -ntp -pl shenyu-spring-boot-starter-client/shenyu-spring-boot-starter-client-motan -am install \
    -DskipTests \
    -Dapi.version="${API_VERSION}" \
    -Dmaven.javadoc.skip=true \
    -Drat.skip=true \
    -Djacoco.skip=true
  ./mvnw -B -ntp -f shenyu-examples/shenyu-examples-motan/pom.xml -pl shenyu-examples-motan-service -am install \
    -DskipTests \
    -Dapi.version="${API_VERSION}" \
    -Dmaven.javadoc.skip=true \
    -Drat.skip=true \
    -Djacoco.skip=true
  ./mvnw -B -ntp -f shenyu-examples/shenyu-examples-motan/shenyu-examples-motan-service/pom.xml package org.springframework.boot:spring-boot-maven-plugin:${SPRING_BOOT_MAVEN_PLUGIN_VERSION}:repackage \
    -DskipTests \
    -Dapi.version="${API_VERSION}" \
    -Dmaven.javadoc.skip=true \
    -Drat.skip=true \
    -Djacoco.skip=true
  docker build -t "${PROVIDER_IMAGE}" shenyu-examples/shenyu-examples-motan/shenyu-examples-motan-service
}

build_runtime_assets() {
  STORE_PLUGIN_JARS_DIR="${PLUGIN_JARS_DIR}" \
    STORE_PLUGIN_SOURCE="${REPO_DIR}" \
    API_VERSION="${API_VERSION}" \
    "${SCRIPT_DIR}/build-store-plugin-jars.sh" motan
  build_admin_adapter_jars
  build_provider_image
}

run_original_it() {
  local base="$1"
  env \
    API_VERSION="${API_VERSION}" \
    SHENYU_CORE_SOURCE="${CORE_SOURCE}" \
    STORE_PLUGIN_ID=17 \
    STORE_PLUGIN_CLASS=org.apache.shenyu.plugin.motan.MotanPlugin \
    STORE_PLUGIN_JARS_DIR="${PLUGIN_JARS_DIR}" \
    STORE_ADMIN_JARS_DIR="${ADMIN_JARS_DIR}" \
    STORE_HTTP_BACKEND_IMAGE="${PROVIDER_IMAGE}" \
    STORE_HTTP_BACKEND_HEALTH_URL="http://localhost:$((base + 3))/actuator/health" \
    STORE_MOTAN_REGISTRY_ADDRESS=shenyu-zk:2181 \
    STORE_MOTAN_REGISTRY_CONNECT_TIMEOUT="${MOTAN_CONNECT_TIMEOUT}" \
    STORE_ZK_PORT="$((base + 2))" \
    STORE_BACKEND_HTTP_PORT="$((base + 3))" \
    STORE_BACKEND_MOTAN_PORT="$((base + 4))" \
    SHENYU_ADMIN_PORT="${base}" \
    SHENYU_BOOTSTRAP_PORT="$((base + 1))" \
    COMPOSE_PROJECT_NAME="shenyu-store-motan-it-$$" \
    BUILD_STORE_JARS=false \
    SEED_HTTP_DIVIDE_ROUTE=false \
    STORE_MOTAN_BACKEND_DELAY_SECONDS="${BACKEND_DELAY_SECONDS}" \
    COMPOSE_OVERRIDE_FILE="${MOTAN_COMPOSE_OVERRIDE}" \
    "${SCRIPT_DIR}/run-original-it.sh" motan "${IT_CASE_MODULE}"
}

run_original_e2e() {
  local base="$1"
  env \
    API_VERSION="${API_VERSION}" \
    SHENYU_CORE_SOURCE="${CORE_SOURCE}" \
    STORE_PLUGIN_ID=17 \
    STORE_PLUGIN_CLASS=org.apache.shenyu.plugin.motan.MotanPlugin \
    STORE_PLUGIN_JARS_DIR="${PLUGIN_JARS_DIR}" \
    STORE_ADMIN_JARS_DIR="${ADMIN_JARS_DIR}" \
    STORE_HTTP_BACKEND_IMAGE="${PROVIDER_IMAGE}" \
    STORE_HTTP_BACKEND_HEALTH_URL="http://localhost:$((base + 3))/actuator/health" \
    STORE_MOTAN_REGISTRY_ADDRESS=shenyu-zk:2181 \
    STORE_MOTAN_REGISTRY_CONNECT_TIMEOUT="${MOTAN_CONNECT_TIMEOUT}" \
    STORE_ZK_PORT="$((base + 2))" \
    STORE_BACKEND_HTTP_PORT="$((base + 3))" \
    STORE_BACKEND_MOTAN_PORT="$((base + 4))" \
    SHENYU_ADMIN_PORT="${base}" \
    SHENYU_BOOTSTRAP_PORT="$((base + 1))" \
    COMPOSE_PROJECT_NAME="shenyu-store-motan-e2e-$$" \
    BUILD_STORE_JARS=false \
    SEED_HTTP_DIVIDE_ROUTE=false \
    STORE_MOTAN_BACKEND_DELAY_SECONDS="${BACKEND_DELAY_SECONDS}" \
    COMPOSE_OVERRIDE_FILE="${MOTAN_COMPOSE_OVERRIDE}" \
    "${SCRIPT_DIR}/run-original-e2e.sh" motan "${E2E_CASE_MODULE}"
}

cd "${REPO_DIR}"
if [[ "${SKIP_ASSET_BUILD}" != "true" ]]; then
  build_runtime_assets
fi

case "${SUITE}" in
  all)
    run_with_log motan-original-it run_original_it "${IT_PORT_BASE}"
    run_with_log motan-original-e2e run_original_e2e "${E2E_PORT_BASE}"
    ;;
  it)
    run_with_log motan-original-it run_original_it "${IT_PORT_BASE}"
    ;;
  e2e)
    run_with_log motan-original-e2e run_original_e2e "${E2E_PORT_BASE}"
    ;;
esac
