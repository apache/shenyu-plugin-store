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

usage() {
  cat <<'USAGE'
Usage: script/plugin-store/run-sofa-original-suites.sh [options]

Runs the restored original SOFA plugin-store verification entrypoints with
store-owned artifacts and disposable local runtime resources.

Default lane:
  sql preflight/origin proof + store SOFA jars + SOFA provider image + SOFA IT
  gateway image + original SOFA IT tests + restored SOFA E2E DataSyn/scenarios.

Options:
  --k8s              Also run the original K8s ingress SOFA kind lane.
  --only <phase>     Run one phase: sql, build, compose, it, e2e, k8s, all.
  --skip-build       Reuse existing local images/jars; still runs SQL proof.
  --keep-stacks      Do not tear down compose/kind on exit.
  --report-dir <dir> Write logs and generated overrides under <dir>.
  --help             Show this help.

Important env:
  SHENYU_CORE_SOURCE   Pinned core source checkout for SQL baseline proof
                       (default: current checkout; sparse migration worktrees
                       fall back to /tmp/shenyu-remaining-source when present).
  SOFA_COMPOSE_NAME    Compose project/container prefix
                       (default: shenyu-sofa-original-<pid>).
  SOFA_KIND_CLUSTER    Kind cluster name for --k8s
                       (default: shenyu-sofa-k8s-<pid>).
  SHENYU_ADMIN_IMAGE   Admin image used by compose
                       (default: shenyu-plugin-store-admin:sofa).
  SOFA_GATEWAY_IMAGE   SOFA gateway image used by compose
                       (default: apache/shenyu-integrated-test-sofa:latest).
  SHENYU_ADMIN_PORT    Host admin port for E2E/IT compose (default: 31095).
  SHENYU_GATEWAY_PORT  Host gateway port for E2E/IT compose (default: 31195).

Examples:
  script/plugin-store/run-sofa-original-suites.sh
  script/plugin-store/run-sofa-original-suites.sh --k8s
  script/plugin-store/run-sofa-original-suites.sh --only e2e --skip-build
  SHENYU_CORE_SOURCE=/path/to/pinned/core script/plugin-store/run-sofa-original-suites.sh --only sql
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
DEFAULT_REPORT_DIR="${REPO_DIR}/target/plugin-store-sofa-reports/$(date +%Y%m%d-%H%M%S)"
REPORT_DIR="${SOFA_REPORT_DIR:-${DEFAULT_REPORT_DIR}}"
CORE_SCHEMA_REL="shenyu-admin/src/main/resources/sql-script/h2/schema.sql"
LEGACY_CORE_SOURCE="/tmp/shenyu-remaining-source"
if [[ -n "${SHENYU_CORE_SOURCE:-}" ]]; then
  CORE_SOURCE="${SHENYU_CORE_SOURCE}"
elif [[ -f "${REPO_DIR}/${CORE_SCHEMA_REL}" ]]; then
  CORE_SOURCE="${REPO_DIR}"
elif [[ -f "${LEGACY_CORE_SOURCE}/${CORE_SCHEMA_REL}" ]]; then
  CORE_SOURCE="${LEGACY_CORE_SOURCE}"
else
  CORE_SOURCE="${REPO_DIR}"
fi
ADMIN_IMAGE="${SHENYU_ADMIN_IMAGE:-shenyu-plugin-store-admin:sofa}"
BOOTSTRAP_IMAGE="${SHENYU_BOOTSTRAP_IMAGE:-shenyu-plugin-store-bootstrap:sofa}"
GATEWAY_IMAGE="${SOFA_GATEWAY_IMAGE:-apache/shenyu-integrated-test-sofa:latest}"
PROVIDER_IMAGE="${SOFA_PROVIDER_IMAGE:-shenyu-examples-sofa:latest}"
STORE_H2_DIR="${STORE_H2_DIR:-${REPO_DIR}/target/plugin-store-h2/sofa}"
ADMIN_PORT="${SHENYU_ADMIN_PORT:-31095}"
GATEWAY_PORT="${SHENYU_GATEWAY_PORT:-31195}"
EXAMPLE_HEALTH_PORT="${SOFA_EXAMPLE_HEALTH_PORT:-28011}"
EXAMPLE_HTTP_PORT="${SOFA_EXAMPLE_HTTP_PORT:-8888}"
COMPOSE_NAME="${SOFA_COMPOSE_NAME:-shenyu-sofa-original-$$}"
NETWORK_NAME="${SOFA_NETWORK_NAME:-${COMPOSE_NAME}-net}"
KIND_CLUSTER="${SOFA_KIND_CLUSTER:-shenyu-sofa-k8s-$$}"
RUN_K8S=false
ONLY_PHASE="all"
SKIP_BUILD=false
KEEP_STACKS=false
COMPOSE_STARTED=false
KIND_STARTED=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --k8s)
      RUN_K8S=true
      shift
      ;;
    --only)
      ONLY_PHASE="${2:?--only requires a phase}"
      shift 2
      ;;
    --skip-build)
      SKIP_BUILD=true
      shift
      ;;
    --keep-stacks)
      KEEP_STACKS=true
      shift
      ;;
    --report-dir)
      REPORT_DIR="${2:?--report-dir requires a directory}"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

case "${ONLY_PHASE}" in
  sql|build|compose|it|e2e|k8s|all)
    ;;
  *)
    echo "Unknown --only phase: ${ONLY_PHASE}" >&2
    usage >&2
    exit 1
    ;;
esac

mkdir -p "${REPORT_DIR}"
REPORT_DIR="$(cd "${REPORT_DIR}" && pwd)"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%dT%H:%M:%S%z')" "$*"
}

run_logged() {
  local name="$1"
  shift
  log "running ${name}: $*"
  set +e
  "$@" >"${REPORT_DIR}/${name}.log" 2>&1
  local rc=$?
  set -e
  tail -120 "${REPORT_DIR}/${name}.log" || true
  return "${rc}"
}

cleanup() {
  local rc=$?
  if [[ "${KEEP_STACKS}" != "true" ]]; then
    if [[ "${COMPOSE_STARTED}" == "true" ]]; then
      docker compose -p "${COMPOSE_NAME}" -f "${REPO_DIR}/shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml" -f "${REPORT_DIR}/sofa-compose-override.yml" down --remove-orphans >"${REPORT_DIR}/compose-cleanup.log" 2>&1 || true
    fi
    if [[ "${KIND_STARTED}" == "true" ]]; then
      kind delete cluster --name "${KIND_CLUSTER}" >"${REPORT_DIR}/kind-cleanup.log" 2>&1 || true
      python3 - <<PY || true
from pathlib import Path
Path('${REPORT_DIR}/kubeconfig-${KIND_CLUSTER}.yaml').unlink(missing_ok=True)
PY
    fi
  fi
  exit "${rc}"
}
trap cleanup EXIT

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

require_docker_image() {
  if ! docker image inspect "$1" >/dev/null 2>&1; then
    echo "Missing required Docker image: $1" >&2
    echo "Run without --skip-build first, or provide a prebuilt image tag with the documented image env vars." >&2
    exit 1
  fi
}

checksum_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

require_free_port() {
  local port="$1"
  python3 - <<PY
import socket
import sys
port = int('${port}')
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
try:
    sock.bind(('0.0.0.0', port))
except OSError as exc:
    print(f'Port {port} is unavailable: {exc}', file=sys.stderr)
    sys.exit(1)
finally:
    sock.close()
PY
}

require_compose_ports() {
  # The restored SOFA E2E annotations use localhost:31095/31195, and the
  # original compose file still publishes its legacy host ports. Fail before
  # creating partial containers if another local lane owns one of them.
  for port in 2181 8888 9095 9195 28011 "${ADMIN_PORT}" "${GATEWAY_PORT}"; do
    require_free_port "${port}"
  done
}

write_compose_override() {
  cat >"${REPORT_DIR}/sofa-compose-override.yml" <<EOF_OVERRIDE
services:
  shenyu-zk:
    container_name: ${COMPOSE_NAME}-zk
    networks:
      shenyu:
        aliases:
          - shenyu-zk
          - shenyu-zookeeper
  shenyu-admin:
    image: ${ADMIN_IMAGE}
    container_name: ${COMPOSE_NAME}-admin
    environment:
      ADMIN_JVM: -Xms256m -Xmx768m
      SPRING_PROFILES_ACTIVE: h2
      shenyu.sync.websocket.token: shenyu-sync-token
      shenyu.database.init_script: sql-script/h2/schema.sql
      shenyu.jwt.secretKey: shenyu-e2e-jwt-secret-key-2024
    ports:
      - "${ADMIN_PORT}:9095"
    volumes:
      - "${STORE_H2_DIR}:/opt/shenyu-data"
      - "${STORE_H2_DIR}/conf-ext:/opt/shenyu-admin/conf-ext:ro"
  shenyu-integrated-test-sofa:
    image: ${GATEWAY_IMAGE}
    container_name: ${COMPOSE_NAME}-gateway
    ports:
      - "${GATEWAY_PORT}:9195"
  shenyu-examples-sofa:
    image: ${PROVIDER_IMAGE}
    container_name: ${COMPOSE_NAME}-provider
    ports:
      - "${EXAMPLE_HEALTH_PORT}:28011"
      - "${EXAMPLE_HTTP_PORT}:8888"
networks:
  shenyu:
    name: ${NETWORK_NAME}
EOF_OVERRIDE
}

wait_for_url() {
  local url="$1"
  local name="$2"
  local deadline=$((SECONDS + 240))
  until curl -fsS "${url}" >/dev/null 2>&1; do
    if (( SECONDS > deadline )); then
      echo "Timed out waiting for ${name}: ${url}" >&2
      docker compose -p "${COMPOSE_NAME}" -f "${REPO_DIR}/shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml" -f "${REPORT_DIR}/sofa-compose-override.yml" logs --tail=240 >"${REPORT_DIR}/compose-timeout.log" 2>&1 || true
      exit 1
    fi
    sleep 2
  done
}

wait_for_gateway_cache_value() {
  local endpoint="$1"
  local pattern="$2"
  local name="$3"
  local output="${REPORT_DIR}/gateway-${endpoint}.json"
  local deadline=$((SECONDS + 240))
  until curl -fsS -H 'localKey: 123456' "http://localhost:${GATEWAY_PORT}/shenyu/e2e/${endpoint}" >"${output}" 2>/dev/null && grep -Fq "${pattern}" "${output}"; do
    if (( SECONDS > deadline )); then
      echo "Timed out waiting for ${name} in gateway ${endpoint} cache" >&2
      docker compose -p "${COMPOSE_NAME}" -f "${REPO_DIR}/shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml" -f "${REPORT_DIR}/sofa-compose-override.yml" logs --tail=240 >"${REPORT_DIR}/compose-cache-timeout.log" 2>&1 || true
      exit 1
    fi
    sleep 2
  done
}

phase_enabled() {
  local phase="$1"
  [[ "${ONLY_PHASE}" == "all" || "${ONLY_PHASE}" == "${phase}" ]]
}

preflight() {
  require_command docker
  require_command curl
  require_command python3
  require_command mvn
  if [[ ! -x "${CORE_SOURCE}/mvnw" ]]; then
    echo "Missing pinned core source mvnw: ${CORE_SOURCE}/mvnw" >&2
    exit 1
  fi
  {
    echo "store=${REPO_DIR}"
    echo "core=${CORE_SOURCE}"
    core_head="$(git -C "${CORE_SOURCE}" rev-parse HEAD 2>/dev/null || true)"
    if [[ -n "${core_head}" ]]; then
      echo "coreGitHead=${core_head}"
    else
      echo "coreGitHead=unavailable-source-snapshot"
    fi
    python3 - <<PY
import json
from pathlib import Path
manifest = json.loads(Path('${REPO_DIR}/db/plugins/sofa/row-manifest.json').read_text())
print('manifest.plugin=' + manifest['plugin'])
print('manifest.pluginId=' + manifest['pluginId'])
print('manifest.sourceSHA=' + manifest['sourceSHA'])
print('h2.counts=' + json.dumps(manifest['dialects']['h2']['counts'], sort_keys=True))
PY
  } | tee "${REPORT_DIR}/preflight-origin.txt"
}

run_sql_proof() {
  log "proving SOFA SQL origin with shipped preflight/install and pinned core schema"
  (
    cd "${REPO_DIR}"
    SHENYU_CORE_SOURCE="${CORE_SOURCE}" STORE_PLUGIN_ID=11 "${SCRIPT_DIR}/prepare-h2-store-db.sh" sofa
  ) >"${REPORT_DIR}/sql-proof.log" 2>&1
  tail -120 "${REPORT_DIR}/sql-proof.log"
}

build_artifacts() {
  if [[ "${SKIP_BUILD}" == "true" ]]; then
    log "skipping build phase by request"
    return
  fi
  log "building store SOFA plugin/starter jars"
  (
    cd "${REPO_DIR}"
    STORE_PLUGIN_MODULES="shenyu-plugin/shenyu-plugin-proxy/shenyu-plugin-sofa,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-sofa" \
      STORE_PLUGIN_JAR_GLOB='shenyu-plugin-sofa-*.jar' \
      STORE_STARTER_JAR_GLOB='shenyu-spring-boot-starter-plugin-sofa-*.jar' \
      "${SCRIPT_DIR}/build-store-plugin-jars.sh" sofa
    STORE_PLUGIN_JAR_GLOB='shenyu-plugin-sofa-*.jar' STORE_STARTER_JAR_GLOB='shenyu-spring-boot-starter-plugin-sofa-*.jar' "${SCRIPT_DIR}/assert-store-fixtures.sh" sofa
    sofa_jar="$(find target/plugin-store-jars -maxdepth 1 -type f -name 'shenyu-plugin-sofa-*.jar' | head -1)"
    jar tf "${sofa_jar}" | grep 'org/apache/shenyu/plugin/sofa/SofaPlugin.class'
    echo "sofaPluginJar=${sofa_jar}"
    echo "sofaPluginJarSha256=$(checksum_file "${sofa_jar}")"
  ) >"${REPORT_DIR}/store-sofa-jars-origin.log" 2>&1
  tail -120 "${REPORT_DIR}/store-sofa-jars-origin.log"

  run_logged sofa-provider-package mvn -B -ntp -f "${REPO_DIR}/shenyu-examples/pom.xml" -pl shenyu-examples-sofa/shenyu-examples-sofa-service -am package -Pexample -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
  run_logged sofa-provider-docker mvn -B -ntp -f "${REPO_DIR}/shenyu-examples/pom.xml" -pl shenyu-examples-sofa/shenyu-examples-sofa-service -am io.fabric8:docker-maven-plugin:0.40.1:build -Pexample -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
  run_logged sofa-it-package mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-sofa -am clean package -Pit -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
  run_logged sofa-it-docker mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-sofa -am io.fabric8:docker-maven-plugin:0.40.1:build -Pit -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
  log "building pinned slim admin image for strict H2 runtime"
  (
    cd "${REPO_DIR}"
    SHENYU_CORE_SOURCE="${CORE_SOURCE}" \
      STORE_CORE_RUNTIME_DIR="${REPO_DIR}/target/plugin-store-core/sofa" \
      SHENYU_ADMIN_IMAGE="${ADMIN_IMAGE}" \
      SHENYU_BOOTSTRAP_IMAGE="${BOOTSTRAP_IMAGE}" \
      STORE_PLUGIN_JAR_GLOB='shenyu-plugin-sofa-*.jar' \
      STORE_STARTER_JAR_GLOB='shenyu-spring-boot-starter-plugin-sofa-*.jar' \
      "${SCRIPT_DIR}/build-slim-core-images.sh" sofa
  ) >"${REPORT_DIR}/slim-admin-image.log" 2>&1
  tail -120 "${REPORT_DIR}/slim-admin-image.log"
}

prove_gateway_class_origin() {
  local store_jar
  store_jar="$(find "${REPO_DIR}/target/plugin-store-jars" -maxdepth 1 -type f -name 'shenyu-plugin-sofa-*.jar' ! -name '*-sources.jar' ! -name '*-javadoc.jar' | sort | head -1)"
  if [[ -z "${store_jar}" ]]; then
    echo "Missing store SOFA plugin jar in ${REPO_DIR}/target/plugin-store-jars" >&2
    exit 1
  fi
  local expected_jar_sha
  expected_jar_sha="$(checksum_file "${store_jar}")"
  local class_path="org/apache/shenyu/plugin/sofa/SofaPlugin.class"
  local store_class_dir="${REPORT_DIR}/store-sofa-class-origin"
  rm -rf "${store_class_dir}"
  mkdir -p "${store_class_dir}"
  (
    cd "${store_class_dir}"
    jar xf "${store_jar}" "${class_path}"
  )
  local expected_class_sha
  expected_class_sha="$(checksum_file "${store_class_dir}/${class_path}")"
  local origin_log="${REPORT_DIR}/gateway-sofa-class-origin.log"
  docker run --rm --entrypoint sh "${GATEWAY_IMAGE}" -c '
set -eu
tmp="$(mktemp -d)"
cd "${tmp}"
jar xf /opt/shenyu-integrated-test-sofa/shenyu-integrated-test-sofa.jar BOOT-INF/lib
find BOOT-INF/lib -maxdepth 1 -type f -name "shenyu-plugin-sofa-*.jar" | sort > nested-jars.txt
count="$(wc -l < nested-jars.txt | tr -d " ")"
test "${count}" = "1"
nested="$(cat nested-jars.txt)"
jar xf "${nested}" org/apache/shenyu/plugin/sofa/SofaPlugin.class
sha256sum "${nested}" > nested.sha256
sha256sum org/apache/shenyu/plugin/sofa/SofaPlugin.class > class.sha256
read -r nested_sha _ < nested.sha256
read -r class_sha _ < class.sha256
echo "gatewayNestedPluginJar=${nested}"
echo "gatewayNestedPluginJarSha256=${nested_sha}"
echo "gatewaySofaPluginClassSha256=${class_sha}"
' >"${origin_log}" 2>&1
  local actual_class_sha
  actual_class_sha="$(awk -F= '$1 == "gatewaySofaPluginClassSha256" {print $2}' "${origin_log}")"
  {
    echo "gatewayImage=${GATEWAY_IMAGE}"
    echo "storePluginJar=${store_jar}"
    echo "storePluginJarSha256=${expected_jar_sha}"
    echo "storeSofaPluginClassSha256=${expected_class_sha}"
  } >>"${origin_log}"
  cat "${origin_log}"
  if [[ "${actual_class_sha}" != "${expected_class_sha}" ]]; then
    echo "Gateway image SofaPlugin.class does not match store-built jar" >&2
    exit 1
  fi
}

require_runtime_images() {
  require_docker_image "${ADMIN_IMAGE}"
  require_docker_image "${GATEWAY_IMAGE}"
  require_docker_image "${PROVIDER_IMAGE}"
}

start_compose() {
  write_compose_override
  require_runtime_images
  prove_gateway_class_origin
  require_compose_ports
  COMPOSE_STARTED=true
  (
    cd "${REPO_DIR}"
    docker compose -p "${COMPOSE_NAME}" -f shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml -f "${REPORT_DIR}/sofa-compose-override.yml" down --remove-orphans || true
    docker compose -p "${COMPOSE_NAME}" -f shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml -f "${REPORT_DIR}/sofa-compose-override.yml" up -d --force-recreate
    docker compose -p "${COMPOSE_NAME}" -f shenyu-integrated-test/shenyu-integrated-test-sofa/docker-compose.yml -f "${REPORT_DIR}/sofa-compose-override.yml" ps
    docker inspect "${COMPOSE_NAME}-admin" --format='adminImage={{.Config.Image}}{{range .Mounts}}{{println}}{{.Source}} -> {{.Destination}}{{end}}' >"${REPORT_DIR}/admin-runtime-mounts.log"
  ) >"${REPORT_DIR}/compose-up.log" 2>&1
  tail -120 "${REPORT_DIR}/compose-up.log"
  cat "${REPORT_DIR}/admin-runtime-mounts.log"
  wait_for_url "http://localhost:${ADMIN_PORT}/actuator/health" shenyu-admin
  wait_for_url "http://localhost:${GATEWAY_PORT}/actuator/health" shenyu-gateway
  wait_for_url "http://localhost:${EXAMPLE_HEALTH_PORT}/actuator/health" sofa-provider
  wait_for_gateway_cache_value metadata /sofa/findById sofa-metadata
  wait_for_gateway_cache_value ruleData /sofa/findById sofa-rule
  curl -fsS -H 'localKey: 123456' "http://localhost:${GATEWAY_PORT}/shenyu/e2e/selectorData" >"${REPORT_DIR}/gateway-selector-cache.json"
}

run_it() {
  start_compose
  run_logged sofa-original-it mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-sofa -Pit -Dtest='SofaPluginTest,SofaPluginShareThreadPoolTest' test -Drat.skip=true -Djacoco.skip=true
}

run_e2e() {
  if [[ "${COMPOSE_STARTED}" != "true" ]]; then
    start_compose
  fi
  run_logged sofa-original-e2e mvn -B -ntp -f "${REPO_DIR}/shenyu-e2e/pom.xml" -pl shenyu-e2e-case/shenyu-e2e-case-sofa -am -Dtest='DataSynTest,SofaPluginTest' -DfailIfNoTests=false test -Drat.skip=true -Djacoco.skip=true
}

load_kind_image() {
  local image="$1"
  if kind load docker-image --name "${KIND_CLUSTER}" "${image}" >"${REPORT_DIR}/kind-load-${image//[^A-Za-z0-9_.-]/_}.log" 2>&1; then
    return
  fi
  log "kind load failed for ${image}; falling back to ctr import"
  docker save "${image}" | docker exec -i "${KIND_CLUSTER}-control-plane" ctr -n k8s.io images import - >>"${REPORT_DIR}/kind-load-${image//[^A-Za-z0-9_.-]/_}.log" 2>&1
}

run_k8s() {
  require_command kind
  require_command kubectl
  local kubeconfig="${REPORT_DIR}/kubeconfig-${KIND_CLUSTER}.yaml"
  if [[ "${SKIP_BUILD}" != "true" ]]; then
    run_logged sofa-k8s-package mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-k8s-ingress-sofa -am clean package -Pit -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
    run_logged sofa-k8s-docker mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-k8s-ingress-sofa -am io.fabric8:docker-maven-plugin:0.40.1:build -Pit -Dmaven.test.skip=true -Drat.skip=true -Djacoco.skip=true
  fi
  python3 - <<PY
from pathlib import Path
Path('${kubeconfig}').unlink(missing_ok=True)
PY
  kind delete cluster --name "${KIND_CLUSTER}" >"${REPORT_DIR}/kind-delete-before.log" 2>&1 || true
  kind create cluster --name "${KIND_CLUSTER}" --image "${KIND_NODE_IMAGE:-kindest/node:v1.35.0}" --config "${REPO_DIR}/shenyu-integrated-test/shenyu-integrated-test-k8s-ingress-sofa/deploy/kind-config.yaml" --kubeconfig "${kubeconfig}" >"${REPORT_DIR}/kind-create.log" 2>&1
  KIND_STARTED=true
  KUBECONFIG="${kubeconfig}" kubectl wait --for=condition=Ready node --all --timeout=180s >>"${REPORT_DIR}/kind-create.log" 2>&1
  load_kind_image shenyu-examples-sofa:latest
  load_kind_image apache/shenyu-integrated-test-k8s-ingress-sofa:latest
  docker exec "${KIND_CLUSTER}-control-plane" ctr -n k8s.io images ls | grep -E 'shenyu-examples-sofa|shenyu-integrated-test-k8s-ingress-sofa' >"${REPORT_DIR}/kind-image-list.log"
  (
    cd "${REPO_DIR}"
    KUBECONFIG="${kubeconfig}" kubectl apply -f shenyu-examples/shenyu-examples-sofa/shenyu-examples-sofa-service/k8s/shenyu-zookeeper.yml
    KUBECONFIG="${kubeconfig}" kubectl wait --for=condition=Ready pod -l app=shenyu-zk -n shenyu-ingress --timeout=240s
    KUBECONFIG="${kubeconfig}" kubectl apply -f shenyu-examples/shenyu-examples-sofa/shenyu-examples-sofa-service/k8s/shenyu-examples-sofa.yml
    KUBECONFIG="${kubeconfig}" kubectl wait --for=condition=Ready pod -l app=shenyu-examples-sofa -n shenyu-ingress --timeout=300s
    KUBECONFIG="${kubeconfig}" kubectl apply -f shenyu-integrated-test/shenyu-integrated-test-k8s-ingress-sofa/deploy/deploy-shenyu.yaml
    KUBECONFIG="${kubeconfig}" kubectl wait --for=condition=Ready pod -l app=shenyu-ingress-controller -n shenyu-ingress --timeout=300s
    KUBECONFIG="${kubeconfig}" kubectl apply -f shenyu-examples/shenyu-examples-sofa/shenyu-examples-sofa-service/k8s/ingress.yml
    KUBECONFIG="${kubeconfig}" kubectl get pod,svc,ingress -o wide -n shenyu-ingress
  ) >"${REPORT_DIR}/k8s-apply.log" 2>&1
  bash "${REPO_DIR}/shenyu-integrated-test/shenyu-integrated-test-k8s-ingress-sofa/script/healthcheck.sh" >"${REPORT_DIR}/k8s-healthcheck.log" 2>&1
  curl -fsS "http://localhost:30095/sofa/findById?id=1001" >"${REPORT_DIR}/k8s-sofa-findById.json"
  run_logged sofa-k8s-junit mvn -B -ntp -f "${REPO_DIR}/shenyu-integrated-test/pom.xml" -pl shenyu-integrated-test-k8s-ingress-sofa -am -Dtest=SofaPluginShareThreadPoolTest -DfailIfNoTests=false test -Drat.skip=true -Djacoco.skip=true
}

preflight
case "${ONLY_PHASE}" in
  sql)
    run_sql_proof
    ;;
  build)
    run_sql_proof
    build_artifacts
    ;;
  compose)
    run_sql_proof
    build_artifacts
    start_compose
    ;;
  it)
    run_sql_proof
    build_artifacts
    run_it
    ;;
  e2e)
    run_sql_proof
    build_artifacts
    run_e2e
    ;;
  k8s)
    run_sql_proof
    build_artifacts
    run_k8s
    ;;
  all)
    run_sql_proof
    build_artifacts
    run_it
    run_e2e
    if [[ "${RUN_K8S}" == "true" ]]; then
      run_k8s
    fi
    ;;
esac

log "SOFA original suite launcher completed; logs: ${REPORT_DIR}"
