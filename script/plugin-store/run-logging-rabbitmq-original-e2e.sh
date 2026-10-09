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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PLUGIN="logging-rabbitmq"
CASE_MODULE="shenyu-e2e/shenyu-e2e-case/shenyu-e2e-case-logging-rabbitmq"
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-shenyu-store-rabbitmq-e2e-clean}"
COMPOSE_FILE_EXTRA="${COMPOSE_FILE_EXTRA:-${SCRIPT_DIR}/docker-compose.rabbitmq-e2e.yml}"
SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT:-31095}"
SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-31195}"
RABBITMQ_PORT="${RABBITMQ_PORT:-5672}"
RABBITMQ_MANAGEMENT_PORT="${RABBITMQ_MANAGEMENT_PORT:-15672}"
export COMPOSE_PROJECT_NAME COMPOSE_FILE_EXTRA SHENYU_ADMIN_PORT SHENYU_BOOTSTRAP_PORT RABBITMQ_PORT RABBITMQ_MANAGEMENT_PORT
export STORE_PLUGIN_CLASS="${STORE_PLUGIN_CLASS:-org.apache.shenyu.plugin.logging.rabbitmq.LoggingRabbitmqPlugin}"
export KEEP_COMPOSE=true SEED_HTTP_DIVIDE_ROUTE=false

cleanup() {
  if [[ "${KEEP_RABBITMQ_E2E_COMPOSE:-false}" != "true" ]]; then
    docker compose -p "${COMPOSE_PROJECT_NAME}" \
      -f "${SCRIPT_DIR}/docker-compose.original-suite.yml" \
      -f "${COMPOSE_FILE_EXTRA}" down -v >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

cd "${REPO_DIR}"
cleanup

"${SCRIPT_DIR}/run-core-compose.sh" "${PLUGIN}"

deadline=$((SECONDS + 120))
until docker compose -p "${COMPOSE_PROJECT_NAME}" -f "${SCRIPT_DIR}/docker-compose.original-suite.yml" -f "${COMPOSE_FILE_EXTRA}" exec -T shenyu-rabbitmq rabbitmq-diagnostics -q ping >/dev/null 2>&1; do
  if (( SECONDS > deadline )); then
    echo "Timed out waiting for RabbitMQ broker" >&2
    docker compose -p "${COMPOSE_PROJECT_NAME}" -f "${SCRIPT_DIR}/docker-compose.original-suite.yml" -f "${COMPOSE_FILE_EXTRA}" logs --tail=200 shenyu-rabbitmq >&2 || true
    exit 1
  fi
  sleep 2
done

SHENYU_ADMIN_URL="http://localhost:${SHENYU_ADMIN_PORT}" \
SHENYU_GATEWAY_URL="http://localhost:${SHENYU_BOOTSTRAP_PORT}" \
STORE_HTTP_BACKEND_UPSTREAM="plugin-store-backend:9080" \
"${SCRIPT_DIR}/seed-rabbitmq-e2e-admin.py"

docker compose -p "${COMPOSE_PROJECT_NAME}" -f "${SCRIPT_DIR}/docker-compose.original-suite.yml" -f "${COMPOSE_FILE_EXTRA}" exec -T shenyu-rabbitmq rabbitmqctl purge_queue queue.logging.plugin >/dev/null 2>&1 || true

RUN_ORIGINAL_COMPOSE=false \
SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT}" \
SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT}" \
"${SCRIPT_DIR}/run-original-e2e.sh" "${PLUGIN}" "${CASE_MODULE}"
