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

CORE_SOURCE="${1:-${SHENYU_CORE_SOURCE:-/tmp/shenyu-remaining-source}}"

if [[ ! -x "${CORE_SOURCE}/mvnw" || ! -f "${CORE_SOURCE}/pom.xml" ]]; then
  echo "Core source is not a ShenYu checkout with ./mvnw: ${CORE_SOURCE}" >&2
  exit 1
fi

CORE_MODULES="shenyu-common,shenyu-web,shenyu-admin-listener/shenyu-admin-listener-api,shenyu-sync-data-center/shenyu-sync-data-api,shenyu-registry/shenyu-registry-api,shenyu-plugin/shenyu-plugin-base,shenyu-spring-boot-starter/shenyu-spring-boot-starter-gateway,shenyu-spring-boot-starter/shenyu-spring-boot-starter-sync-data-center/shenyu-spring-boot-starter-sync-data-websocket"

"${CORE_SOURCE}/mvnw" -B -ntp -f "${CORE_SOURCE}/pom.xml" \
  -pl "${CORE_MODULES}" \
  -am install \
  -DskipTests \
  -Dmaven.javadoc.skip=true \
  -Drat.skip=true \
  -Djacoco.skip=true \
  -DskipRemoteResources=true
