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
STORE_PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-target/plugin-store-jars}"
STORE_PLUGIN_SQL_DIR="${STORE_PLUGIN_SQL_DIR:-db/plugins/${PLUGIN}}"
STORE_PLUGIN_JAR_GLOB="${STORE_PLUGIN_JAR_GLOB:-shenyu-plugin-${PLUGIN}-*.jar}"
STORE_STARTER_JAR_GLOB="${STORE_STARTER_JAR_GLOB:-shenyu-spring-boot-starter-plugin-${PLUGIN}-*.jar}"

if [[ ! -d "${STORE_PLUGIN_JARS_DIR}" ]]; then
  echo "Missing store plugin jar directory: ${STORE_PLUGIN_JARS_DIR}" >&2
  exit 1
fi

if ! find "${STORE_PLUGIN_JARS_DIR}" -maxdepth 1 -type f -name "${STORE_PLUGIN_JAR_GLOB}" | grep -q .; then
  echo "Missing store plugin jar matching ${STORE_PLUGIN_JAR_GLOB} in ${STORE_PLUGIN_JARS_DIR}" >&2
  exit 1
fi

if [[ "${STORE_STARTER_JAR_GLOB}" != "none" ]] && ! find "${STORE_PLUGIN_JARS_DIR}" -maxdepth 1 -type f -name "${STORE_STARTER_JAR_GLOB}" | grep -q .; then
  echo "Missing store starter jar matching ${STORE_STARTER_JAR_GLOB} in ${STORE_PLUGIN_JARS_DIR}" >&2
  exit 1
fi

if [[ ! -d "${STORE_PLUGIN_SQL_DIR}" ]]; then
  echo "Missing store plugin SQL directory: ${STORE_PLUGIN_SQL_DIR}" >&2
  exit 1
fi

if ! find "${STORE_PLUGIN_SQL_DIR}" -type f -name 'install.sql' | grep -q .; then
  echo "Missing idempotent store install.sql under ${STORE_PLUGIN_SQL_DIR}" >&2
  exit 1
fi

if [[ "${CHECK_CORE_IMAGE_BUNDLE:-false}" == "true" ]]; then
  SHENYU_BOOTSTRAP_IMAGE="${SHENYU_BOOTSTRAP_IMAGE:-apache/shenyu-bootstrap:2.7.2-SNAPSHOT}"
  if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is required for CHECK_CORE_IMAGE_BUNDLE=true" >&2
    exit 1
  fi
  docker image inspect "${SHENYU_BOOTSTRAP_IMAGE}" >/dev/null 2>&1 || docker pull "${SHENYU_BOOTSTRAP_IMAGE}"
  if docker run --rm "${SHENYU_BOOTSTRAP_IMAGE}" sh -c "find /opt/shenyu-bootstrap/lib -maxdepth 1 -type f -name '${STORE_PLUGIN_JAR_GLOB}' | grep -q ."; then
    echo "Pinned bootstrap image already bundles ${STORE_PLUGIN_JAR_GLOB}; refusing copy-only success" >&2
    exit 1
  fi
fi

echo "Store fixture gate passed for ${PLUGIN}"
