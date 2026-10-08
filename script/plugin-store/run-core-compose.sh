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

PLUGIN="${1:?Usage: $0 <plugin-slug> [-- command...]}"
shift || true
if [[ "${1:-}" == "--" ]]; then
  shift
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
wait_for_url() {
  local url="$1"
  local name="$2"
  local deadline=$((SECONDS + 180))
  until curl -fsS "${url}" >/dev/null 2>&1; do
    if (( SECONDS > deadline )); then
      echo "Timed out waiting for ${name}: ${url}" >&2
      compose logs --tail=200 || true
      exit 1
    fi
    sleep 2
  done
}
checksum() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}
copy_e2e_cache_support_jar() {
  if [[ "${STORE_E2E_CACHE_ENDPOINT:-true}" != "true" ]]; then
    return
  fi
  local cache_source="${STORE_E2E_CACHE_SOURCE:-${REPO_DIR}}"
  if [[ ! -f "${cache_source}/shenyu-plugin/shenyu-plugin-store-test-support/src/main/java/org/apache/shenyu/plugin/store/test/support/E2eCacheController.java" ]]; then
    cache_source="${STORE_E2E_CACHE_FALLBACK_SOURCE:-/tmp/shenyu-remaining-test-support}"
  fi
  if [[ ! -f "${cache_source}/shenyu-plugin/shenyu-plugin-store-test-support/src/main/java/org/apache/shenyu/plugin/store/test/support/E2eCacheController.java" ]]; then
    echo "Missing store E2E cache endpoint sources; set STORE_E2E_CACHE_SOURCE to the test-support worktree" >&2
    exit 1
  fi
  "${cache_source}/mvnw" -B -ntp -f "${cache_source}/shenyu-plugin/pom.xml" -pl shenyu-plugin-store-test-support -am package -DskipTests -Dapi.version="${API_VERSION:-1.44}"
  local support_jar
  support_jar="$(find "${cache_source}/shenyu-plugin/shenyu-plugin-store-test-support/target" -maxdepth 1 -type f -name 'shenyu-plugin-store-test-support-*.jar' ! -name '*-sources.jar' ! -name '*-javadoc.jar' | sort | tail -n 1)"
  if [[ -z "${support_jar}" ]]; then
    echo "Missing shenyu-plugin-store-test-support jar" >&2
    exit 1
  fi
  cp "${support_jar}" "${STORE_PLUGIN_JARS_DIR}/"
}
store_manifest_plugin_name() {
  local row_manifest="${STORE_PLUGIN_SQL_DIR}/row-manifest.json"
  python3 - "${row_manifest}" "${PLUGIN}" <<'PY_PLUGIN_NAME'
import json
import sys
from pathlib import Path

manifest = Path(sys.argv[1])
if not manifest.is_file():
    print(sys.argv[2])
    raise SystemExit(0)
print(json.loads(manifest.read_text()).get("pluginName") or sys.argv[2])
PY_PLUGIN_NAME
}
probe_e2e_cache_endpoint() {
  if [[ "${STORE_E2E_CACHE_ENDPOINT:-true}" != "true" ]]; then
    return
  fi
  local plugin_name
  plugin_name="$(store_manifest_plugin_name)"
  SHENYU_GATEWAY_URL="http://localhost:${SHENYU_BOOTSTRAP_PORT}" "${SCRIPT_DIR}/probe-e2e-cache-endpoint.sh" "${plugin_name}"
}
STORE_PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-${REPO_DIR}/target/plugin-store-jars}"
STORE_PLUGIN_SQL_DIR="${STORE_PLUGIN_SQL_DIR:-${REPO_DIR}/db/plugins/${PLUGIN}}"
STORE_H2_DIR="${STORE_H2_DIR:-${REPO_DIR}/target/plugin-store-h2/${PLUGIN}}"
mkdir -p "${STORE_H2_DIR}"
STORE_PLUGIN_JARS_DIR="$(cd "${STORE_PLUGIN_JARS_DIR}" && pwd)"
STORE_PLUGIN_SQL_DIR="$(cd "${STORE_PLUGIN_SQL_DIR}" && pwd)"
STORE_H2_DIR="$(cd "${STORE_H2_DIR}" && pwd)"
export STORE_PLUGIN_JARS_DIR STORE_PLUGIN_SQL_DIR STORE_H2_DIR PLUGIN
export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-shenyu-store-${PLUGIN}-$$}"
export CHECK_CORE_IMAGE_BUNDLE="${CHECK_CORE_IMAGE_BUNDLE:-false}"
export SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT:-31095}"
export SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-31195}"
export SHENYU_ADMIN_IMAGE="${SHENYU_ADMIN_IMAGE:-shenyu-plugin-store-admin:${PLUGIN}}"
export SHENYU_BOOTSTRAP_IMAGE="${SHENYU_BOOTSTRAP_IMAGE:-shenyu-plugin-store-bootstrap:${PLUGIN}}"
export STORE_HTTP_BACKEND_IMAGE="${STORE_HTTP_BACKEND_IMAGE:-${SHENYU_BOOTSTRAP_IMAGE}}"
export STORE_HTTP_BACKEND_UPSTREAM="${STORE_HTTP_BACKEND_UPSTREAM:-http://plugin-store-backend:9080}"
export SCRIPT_DIR

"${SCRIPT_DIR}/assert-store-fixtures.sh" "${PLUGIN}"
copy_e2e_cache_support_jar
if [[ "${BUILD_CORE_IMAGES:-true}" == "true" ]]; then
  "${SCRIPT_DIR}/build-slim-core-images.sh" "${PLUGIN}"
fi
"${SCRIPT_DIR}/prepare-h2-store-db.sh" "${PLUGIN}"

COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.original-suite.yml"
COMPOSE_FILES=(-f "${COMPOSE_FILE}")
if [[ -n "${COMPOSE_FILE_EXTRA:-}" ]]; then
  IFS=':' read -r -a EXTRA_COMPOSE_FILES <<< "${COMPOSE_FILE_EXTRA}"
  for extra_compose_file in "${EXTRA_COMPOSE_FILES[@]}"; do
    COMPOSE_FILES+=(-f "${extra_compose_file}")
  done
fi
compose() {
  docker compose -p "${COMPOSE_PROJECT_NAME}" "${COMPOSE_FILES[@]}" "$@"
}

if [[ "${KEEP_COMPOSE:-false}" != "true" ]]; then
  trap 'compose down -v' EXIT
fi

compose up -d
wait_for_url "http://localhost:${SHENYU_ADMIN_PORT}/actuator/health" "shenyu-admin"
wait_for_url "http://localhost:${SHENYU_BOOTSTRAP_PORT}/actuator/health" "shenyu-bootstrap"

for jar in "${STORE_PLUGIN_JARS_DIR}"/*.jar; do
  jar_name="$(basename "${jar}")"
  expected_sha="$(checksum "${jar}")"
  actual_sha="$(compose exec -T shenyu-bootstrap sha256sum "/opt/shenyu-bootstrap/ext-lib/${jar_name}" | awk '{print $1}')"
  if [[ "${expected_sha}" != "${actual_sha}" ]]; then
    echo "Mounted jar checksum mismatch for ${jar_name}" >&2
    exit 1
  fi
done

echo "Store jars are mounted in shenyu-bootstrap ext-lib for ${PLUGIN}"
echo "Prepared H2 with store SQL is mounted in shenyu-admin at /opt/shenyu-data"
"${SCRIPT_DIR}/prove-class-origin.sh" "${PLUGIN}"
if [[ "${SEED_HTTP_DIVIDE_ROUTE:-true}" == "true" ]]; then
  if [[ "${STORE_ROUTE_SEED_DELAY_SECONDS:-5}" != "0" ]]; then
    sleep "${STORE_ROUTE_SEED_DELAY_SECONDS:-5}"
  fi
  SHENYU_GATEWAY_URL="http://localhost:${SHENYU_BOOTSTRAP_PORT}" "${SCRIPT_DIR}/seed-http-divide-route.sh"
fi
probe_e2e_cache_endpoint

if [[ "$#" -gt 0 ]]; then
  "$@"
else
  compose ps
fi
