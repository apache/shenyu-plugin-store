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
PLUGIN="${1:-logging-pulsar}"
SUITE="${2:-it}"

compose_files=()

compose() {
  docker compose -p "${COMPOSE_PROJECT_NAME}" "${compose_files[@]}" "$@"
}

ensure_store_plugin_jars() {
  export STORE_PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-${REPO_DIR}/target/plugin-store-jars}"
  local should_build="${BUILD_STORE_JARS:-}"
  if [[ "${should_build}" == "true" || ! -d "${STORE_PLUGIN_JARS_DIR}" ]] \
      || ! find "${STORE_PLUGIN_JARS_DIR}" -maxdepth 1 -type f -name "shenyu-plugin-${PLUGIN}-*.jar" | grep -q .; then
    "${SCRIPT_DIR}/build-store-plugin-jars.sh" "${PLUGIN}"
  fi
  if ! find "${STORE_PLUGIN_JARS_DIR}" -maxdepth 1 -type f -name "shenyu-plugin-${PLUGIN}-*.jar" | grep -q .; then
    echo "Missing built store plugin jars in ${STORE_PLUGIN_JARS_DIR}" >&2
    exit 1
  fi
  export BUILD_STORE_JARS=false
}

cleanup() {
  if [[ "${KEEP_BROKER_ORIGINAL_COMPOSE:-false}" != "true" && ${#compose_files[@]} -gt 0 ]]; then
    compose down -v >/dev/null 2>&1 || true
  fi
}

wait_for_rabbitmq() {
  local deadline=$((SECONDS + 180))
  until compose exec -T shenyu-rabbitmq rabbitmq-diagnostics -q ping >/dev/null 2>&1; do
    if (( SECONDS > deadline )); then
      echo "Timed out waiting for RabbitMQ broker" >&2
      compose logs --tail=200 shenyu-rabbitmq >&2 || true
      exit 1
    fi
    sleep 2
  done
}

wait_for_pulsar() {
  local deadline=$((SECONDS + 240))
  until nc -z 127.0.0.1 "${PULSAR_PORT}" >/dev/null 2>&1; do
    if (( SECONDS > deadline )); then
      echo "Timed out waiting for Pulsar broker port 127.0.0.1:${PULSAR_PORT}" >&2
      compose ps >&2 || true
      compose exec -T shenyu-pulsar bin/pulsar-admin brokers healthcheck >&2 || true
      compose logs --tail=200 shenyu-pulsar >&2 || true
      exit 1
    fi
    sleep 2
  done
}

run_rabbitmq_it() {
  RUN_ORIGINAL_COMPOSE=false \
  CASE_MAVEN_ARGS="-Dshenyu.logging.rabbitmq.host=127.0.0.1 -Dshenyu.logging.rabbitmq.port=${RABBITMQ_PORT}" \
  "${SCRIPT_DIR}/run-original-it.sh" \
    logging-rabbitmq \
    shenyu-integrated-test/shenyu-integrated-test-http-logging-rabbitmq
}

run_rabbitmq_e2e() {
  SHENYU_ADMIN_URL="http://localhost:${SHENYU_ADMIN_PORT}" \
  SHENYU_GATEWAY_URL="http://localhost:${SHENYU_BOOTSTRAP_PORT}" \
  STORE_HTTP_BACKEND_UPSTREAM="plugin-store-backend:9080" \
  "${SCRIPT_DIR}/seed-rabbitmq-e2e-admin.py"

  compose exec -T shenyu-rabbitmq rabbitmqctl purge_queue queue.logging.plugin >/dev/null 2>&1 || true

  RUN_ORIGINAL_COMPOSE=false \
  SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT}" \
  SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT}" \
  "${SCRIPT_DIR}/run-original-e2e.sh" \
    logging-rabbitmq \
    shenyu-e2e/shenyu-e2e-case/shenyu-e2e-case-logging-rabbitmq
}

run_pulsar_it() {
  RUN_ORIGINAL_COMPOSE=false \
  CASE_MAVEN_ARGS="-Dshenyu.logging.pulsar.serviceUrl=pulsar://127.0.0.1:${PULSAR_PORT}" \
  "${SCRIPT_DIR}/run-original-it.sh" \
    logging-pulsar \
    shenyu-integrated-test/shenyu-integrated-test-http-logging-pulsar
}

cd "${REPO_DIR}"
case "${PLUGIN}" in
  logging-rabbitmq|rabbitmq)
    PLUGIN="logging-rabbitmq"
    export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-shenyu-store-rabbitmq-original}"
    export COMPOSE_FILE_EXTRA="${COMPOSE_FILE_EXTRA:-${SCRIPT_DIR}/docker-compose.rabbitmq-e2e.yml}"
    export SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT:-31095}"
    export SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-31195}"
    export RABBITMQ_PORT="${RABBITMQ_PORT:-5672}"
    export RABBITMQ_MANAGEMENT_PORT="${RABBITMQ_MANAGEMENT_PORT:-15672}"
    export STORE_PLUGIN_CLASS="${STORE_PLUGIN_CLASS:-org.apache.shenyu.plugin.logging.rabbitmq.LoggingRabbitmqPlugin}"
    export STORE_PLUGIN_MODULES="${STORE_PLUGIN_MODULES:-shenyu-plugin/shenyu-plugin-logging/shenyu-plugin-logging-rabbitmq,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-logging-rabbitmq}"
    export KEEP_COMPOSE=true
    export SEED_HTTP_DIVIDE_ROUTE=false
    ;;
  logging-pulsar|pulsar)
    PLUGIN="logging-pulsar"
    export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-shenyu-store-pulsar-original}"
    export COMPOSE_FILE_EXTRA="${COMPOSE_FILE_EXTRA:-${SCRIPT_DIR}/docker-compose.pulsar-broker.yml}"
    export SHENYU_ADMIN_PORT="${SHENYU_ADMIN_PORT:-33095}"
    export SHENYU_BOOTSTRAP_PORT="${SHENYU_BOOTSTRAP_PORT:-33195}"
    export PULSAR_PORT="${PULSAR_PORT:-6650}"
    export PULSAR_HTTP_PORT="${PULSAR_HTTP_PORT:-18080}"
    export STORE_PLUGIN_CLASS="${STORE_PLUGIN_CLASS:-org.apache.shenyu.plugin.logging.pulsar.LoggingPulsarPlugin}"
    export STORE_PLUGIN_MODULES="${STORE_PLUGIN_MODULES:-shenyu-plugin/shenyu-plugin-logging/shenyu-plugin-logging-pulsar,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-logging-pulsar}"
    export KEEP_COMPOSE=true
    ;;
  *)
    echo "Unsupported broker plugin: ${PLUGIN}" >&2
    exit 1
    ;;
esac

IFS=':' read -r -a extra_compose_files <<< "${COMPOSE_FILE_EXTRA}"
compose_files=(-f "${SCRIPT_DIR}/docker-compose.original-suite.yml")
for extra_compose_file in "${extra_compose_files[@]}"; do
  compose_files+=(-f "${extra_compose_file}")
done

trap cleanup EXIT
cleanup
ensure_store_plugin_jars
"${SCRIPT_DIR}/run-core-compose.sh" "${PLUGIN}"

case "${PLUGIN}" in
  logging-rabbitmq)
    wait_for_rabbitmq
    case "${SUITE}" in
      all)
        run_rabbitmq_it
        cleanup
        "${SCRIPT_DIR}/run-core-compose.sh" "${PLUGIN}"
        wait_for_rabbitmq
        run_rabbitmq_e2e
        ;;
      it)
        run_rabbitmq_it
        ;;
      e2e)
        run_rabbitmq_e2e
        ;;
      *)
        echo "Unsupported RabbitMQ suite: ${SUITE}" >&2
        exit 1
        ;;
    esac
    ;;
  logging-pulsar)
    wait_for_pulsar
    case "${SUITE}" in
      all|it)
        run_pulsar_it
        ;;
      *)
        echo "Unsupported Pulsar suite: ${SUITE}" >&2
        exit 1
        ;;
    esac
    ;;
esac
