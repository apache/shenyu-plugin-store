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
CORE_SOURCE="${SHENYU_CORE_SOURCE:-/tmp/shenyu-remaining-source}"
CORE_VERSION="${SHENYU_CORE_VERSION:-2.7.2-SNAPSHOT}"
RUNTIME_DIR="${STORE_CORE_RUNTIME_DIR:-target/plugin-store-core/${PLUGIN}}"
ADMIN_IMAGE="${SHENYU_ADMIN_IMAGE:-shenyu-plugin-store-admin:${PLUGIN}}"
BOOTSTRAP_IMAGE="${SHENYU_BOOTSTRAP_IMAGE:-shenyu-plugin-store-bootstrap:${PLUGIN}}"
STORE_PLUGIN_JAR_GLOB="${STORE_PLUGIN_JAR_GLOB:-shenyu-plugin-${PLUGIN}-*.jar}"
STORE_STARTER_JAR_GLOB="${STORE_STARTER_JAR_GLOB:-shenyu-spring-boot-starter-plugin-${PLUGIN}-*.jar}"

if [[ ! -x "${CORE_SOURCE}/mvnw" ]]; then
  echo "Missing pinned source ./mvnw: ${CORE_SOURCE}" >&2
  exit 1
fi
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required to build task-local core images" >&2
  exit 1
fi

"${CORE_SOURCE}/mvnw" -B -ntp -f "${CORE_SOURCE}/pom.xml" \
  -Prelease \
  -pl shenyu-dist/shenyu-admin-dist,shenyu-dist/shenyu-bootstrap-dist \
  -am package \
  -DskipTests \
  -Dmaven.javadoc.skip=true \
  -Drat.skip=true \
  -Djacoco.skip=true \
  -DskipRemoteResources=true

rm -rf "${RUNTIME_DIR}"
mkdir -p "${RUNTIME_DIR}/admin" "${RUNTIME_DIR}/bootstrap" "${RUNTIME_DIR}/docker-admin" "${RUNTIME_DIR}/docker-bootstrap"
tar -xzf "${CORE_SOURCE}/shenyu-dist/shenyu-admin-dist/target/apache-shenyu-${CORE_VERSION}-admin-bin.tar.gz" -C "${RUNTIME_DIR}/admin" --strip-components=1
tar -xzf "${CORE_SOURCE}/shenyu-dist/shenyu-bootstrap-dist/target/apache-shenyu-${CORE_VERSION}-bootstrap-bin.tar.gz" -C "${RUNTIME_DIR}/bootstrap" --strip-components=1

find "${RUNTIME_DIR}/bootstrap/lib" -maxdepth 1 -type f \( -name "${STORE_PLUGIN_JAR_GLOB}" -o -name "${STORE_STARTER_JAR_GLOB}" \) -delete
if find "${RUNTIME_DIR}/bootstrap/lib" -maxdepth 1 -type f \( -name "${STORE_PLUGIN_JAR_GLOB}" -o -name "${STORE_STARTER_JAR_GLOB}" \) | grep -q .; then
  echo "Target plugin artifacts remain in slim bootstrap lib" >&2
  exit 1
fi

cp -R "${RUNTIME_DIR}/admin/." "${RUNTIME_DIR}/docker-admin/app/"
cp "${CORE_SOURCE}/shenyu-dist/shenyu-admin-dist/docker/entrypoint.sh" "${RUNTIME_DIR}/docker-admin/entrypoint.sh"
cp -R "${RUNTIME_DIR}/bootstrap/." "${RUNTIME_DIR}/docker-bootstrap/app/"
cp "${CORE_SOURCE}/shenyu-dist/shenyu-bootstrap-dist/docker/entrypoint.sh" "${RUNTIME_DIR}/docker-bootstrap/entrypoint.sh"
chmod +x "${RUNTIME_DIR}/docker-admin/entrypoint.sh" "${RUNTIME_DIR}/docker-bootstrap/entrypoint.sh"

cat > "${RUNTIME_DIR}/docker-admin/Dockerfile" <<'DOCKERFILE'
FROM eclipse-temurin:17-jre
WORKDIR /opt/shenyu-admin
COPY app/ /opt/shenyu-admin/
COPY entrypoint.sh /opt/shenyu-admin/entrypoint.sh
ENTRYPOINT ["/opt/shenyu-admin/entrypoint.sh"]
DOCKERFILE

cat > "${RUNTIME_DIR}/docker-bootstrap/Dockerfile" <<'DOCKERFILE'
FROM eclipse-temurin:17-jre
WORKDIR /opt/shenyu-bootstrap
COPY app/ /opt/shenyu-bootstrap/
COPY entrypoint.sh /opt/shenyu-bootstrap/entrypoint.sh
ENTRYPOINT ["/opt/shenyu-bootstrap/entrypoint.sh"]
DOCKERFILE

docker build -t "${ADMIN_IMAGE}" "${RUNTIME_DIR}/docker-admin"
docker build -t "${BOOTSTRAP_IMAGE}" "${RUNTIME_DIR}/docker-bootstrap"

if docker run --rm --entrypoint sh "${BOOTSTRAP_IMAGE}" -c "find /opt/shenyu-bootstrap/lib -maxdepth 1 -type f \\( -name '${STORE_PLUGIN_JAR_GLOB}' -o -name '${STORE_STARTER_JAR_GLOB}' \\) | grep -q ."; then
  echo "Task-local bootstrap image still bundles target plugin artifacts" >&2
  exit 1
fi

echo "Built ${ADMIN_IMAGE} and ${BOOTSTRAP_IMAGE} without ${STORE_PLUGIN_JAR_GLOB}/${STORE_STARTER_JAR_GLOB}"
