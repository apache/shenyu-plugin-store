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
      docker compose "${COMPOSE_ARGS[@]}" logs --tail=200 || true
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
  "${REPO_DIR}/mvnw" -B -ntp -pl shenyu-plugin/shenyu-plugin-store-test-support -am package -DskipTests -Dapi.version="${API_VERSION:-1.44}"
  local support_jar
  support_jar="$(find "${REPO_DIR}/shenyu-plugin/shenyu-plugin-store-test-support/target" -maxdepth 1 -type f -name 'shenyu-plugin-store-test-support-*.jar' ! -name '*-sources.jar' ! -name '*-javadoc.jar' | sort | tail -n 1)"
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
COMPOSE_ARGS=(-p "${COMPOSE_PROJECT_NAME}" -f "${COMPOSE_FILE}")
if [[ -n "${COMPOSE_OVERRIDE_FILE:-}" ]]; then
  IFS=':' read -r -a COMPOSE_OVERRIDE_FILES <<< "${COMPOSE_OVERRIDE_FILE}"
  for compose_override in "${COMPOSE_OVERRIDE_FILES[@]}"; do
    COMPOSE_ARGS+=(-f "${compose_override}")
  done
fi

if [[ "${KEEP_COMPOSE:-false}" != "true" ]]; then
  trap 'docker compose "${COMPOSE_ARGS[@]}" down -v' EXIT
fi

docker compose "${COMPOSE_ARGS[@]}" up -d
wait_for_url "http://localhost:${SHENYU_ADMIN_PORT}/actuator/health" "shenyu-admin"
wait_for_url "http://localhost:${SHENYU_BOOTSTRAP_PORT}/actuator/health" "shenyu-bootstrap"
if [[ -n "${STORE_HTTP_BACKEND_HEALTH_URL:-}" ]]; then
  wait_for_url "${STORE_HTTP_BACKEND_HEALTH_URL}" "plugin-store-backend"
fi

for jar in "${STORE_PLUGIN_JARS_DIR}"/*.jar; do
  jar_name="$(basename "${jar}")"
  expected_sha="$(checksum "${jar}")"
  actual_sha="$(docker compose "${COMPOSE_ARGS[@]}" exec -T shenyu-bootstrap sha256sum "/opt/shenyu-bootstrap/ext-lib/${jar_name}" | awk '{print $1}')"
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
  docker compose "${COMPOSE_ARGS[@]}" ps
fi
