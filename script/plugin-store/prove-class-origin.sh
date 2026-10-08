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

PLUGIN="${1:?Usage: $0 <plugin-slug>}"
case "${PLUGIN}" in
  hystrix)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.hystrix.HystrixPlugin"
    ;;
  motan)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.motan.MotanPlugin"
    ;;
  tars)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.tars.TarsPlugin"
    ;;
  sofa)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.sofa.SofaPlugin"
    ;;
  logging-pulsar|loggingPulsar|pulsar)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.logging.pulsar.LoggingPulsarPlugin"
    ;;
  logging-rabbitmq|loggingRabbitMQ|rabbitmq)
    DEFAULT_STORE_PLUGIN_CLASS="org.apache.shenyu.plugin.logging.rabbitmq.LoggingRabbitmqPlugin"
    ;;
  *)
    DEFAULT_STORE_PLUGIN_CLASS=""
    ;;
esac
STORE_PLUGIN_CLASS="${STORE_PLUGIN_CLASS:-${DEFAULT_STORE_PLUGIN_CLASS}}"
if [[ -z "${STORE_PLUGIN_CLASS}" ]]; then
  echo "Set STORE_PLUGIN_CLASS to the target plugin implementation class for ${PLUGIN}" >&2
  exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
STORE_PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-${REPO_DIR}/target/plugin-store-jars}"
PROBE_BUILD_DIR="${REPO_DIR}/target/plugin-store-probe"
PROBE_JAR="${STORE_PLUGIN_JARS_DIR}/shenyu-plugin-store-class-origin-probe.jar"
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.original-suite.yml"
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-shenyu-store-${PLUGIN}}"

mkdir -p "${PROBE_BUILD_DIR}/classes" "${STORE_PLUGIN_JARS_DIR}"
javac -d "${PROBE_BUILD_DIR}/classes" "${SCRIPT_DIR}/probe/ClassOriginProbe.java"
jar --create --file "${PROBE_JAR}" -C "${PROBE_BUILD_DIR}/classes" .

docker compose -p "${COMPOSE_PROJECT_NAME}" -f "${COMPOSE_FILE}" exec -T shenyu-bootstrap \
  java -cp "/opt/shenyu-bootstrap/conf:/opt/shenyu-bootstrap/lib/*:/opt/shenyu-bootstrap/ext-lib/*" \
  org.apache.shenyu.plugin.store.harness.ClassOriginProbe "${STORE_PLUGIN_CLASS}" "/opt/shenyu-bootstrap/ext-lib/"
