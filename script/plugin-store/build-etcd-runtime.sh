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

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CORE_SOURCE="${SHENYU_CORE_SOURCE:?Set SHENYU_CORE_SOURCE to the compatible core checkout}"
CORE_VERSION="${SHENYU_CORE_VERSION:-2.7.2-SNAPSHOT}"
EXTENSION="${REPO_DIR}/shenyu-extension/shenyu-extension-etcd"
mkdir -p "${REPO_DIR}/target"
RUNTIME_DIR="$(mktemp -d "${REPO_DIR}/target/etcd-runtime.XXXXXX")"

"${CORE_SOURCE}/mvnw" -B -ntp -f "${CORE_SOURCE}/pom.xml" -Prelease   -pl shenyu-dist/shenyu-admin-dist,shenyu-dist/shenyu-bootstrap-dist -am package   -DskipTests -Dmaven.javadoc.skip=true -Djacoco.skip=true -DskipRemoteResources=true
"${CORE_SOURCE}/mvnw" -B -ntp -f "${CORE_SOURCE}/pom.xml" \
  -pl shenyu-spring-boot-starter/shenyu-spring-boot-starter-registry -am install \
  -DskipTests -Dmaven.javadoc.skip=true -Djacoco.skip=true -DskipRemoteResources=true
mvn -B -ntp -f "${REPO_DIR}/pom.xml"   -pl shenyu-extension/shenyu-extension-etcd/shenyu-spring-boot-starter-sync-data-etcd -am install -DskipTests

for role in admin bootstrap; do
  mkdir -p "${RUNTIME_DIR}/${role}/app" "${RUNTIME_DIR}/${role}/external"
  tar -xzf "${CORE_SOURCE}/shenyu-dist/shenyu-${role}-dist/target/apache-shenyu-${CORE_VERSION}-${role}-bin.tar.gz"     -C "${RUNTIME_DIR}/${role}/app" --strip-components=1
  # Remove old ownership even when building from the pre-cutover pinned core.
  find "${RUNTIME_DIR}/${role}/app/lib" -maxdepth 1 -type f     \( -name 'shenyu-*-etcd-*.jar' -o -name 'jetcd-*.jar' \) -delete
  if [[ "${role}" == "admin" ]]; then
    MODULES=(shenyu-admin-listener-etcd shenyu-registry-etcd)
  else
    MODULES=(shenyu-spring-boot-starter-sync-data-etcd shenyu-registry-etcd)
  fi
  for module in "${MODULES[@]}"; do
    mvn -B -ntp -f "${EXTENSION}/${module}/pom.xml" dependency:copy-dependencies       -DincludeScope=runtime -DoutputDirectory="${RUNTIME_DIR}/${role}/external"
    cp "${EXTENSION}/${module}/target/${module}-2.7.1-SNAPSHOT.jar" "${RUNTIME_DIR}/${role}/external/"
  done
  if [[ "${role}" == "bootstrap" ]]; then
    mvn -B -ntp -f "${REPO_DIR}/examples/etcd/gateway/pom.xml" dependency:copy-dependencies \
      -DincludeScope=runtime -DoutputDirectory="${RUNTIME_DIR}/${role}/external"
  fi
  cp "${RUNTIME_DIR}/${role}/external/"*.jar "${RUNTIME_DIR}/${role}/app/lib/"
  cp "${EXTENSION}/NOTICE" "${RUNTIME_DIR}/${role}/app/ETCD-NOTICE"
  cp "${EXTENSION}/LICENSE" "${RUNTIME_DIR}/${role}/app/ETCD-LICENSE"
  # Prove the runtime implementation is the store build, including the shared client.
  for artifact in shenyu-infra-etcd shenyu-registry-etcd; do
    cmp "${EXTENSION}/${artifact}/target/${artifact}-2.7.1-SNAPSHOT.jar" \
      "${RUNTIME_DIR}/${role}/app/lib/${artifact}-2.7.1-SNAPSHOT.jar"
  done
  if find "${RUNTIME_DIR}/${role}/app/lib" -maxdepth 1 -type f -name 'shenyu-*-etcd-2.7.2-SNAPSHOT.jar' | grep -q .; then
    echo "Duplicate in-tree etcd ownership remains in ${role}" >&2
    exit 1
  fi
  cp "${CORE_SOURCE}/shenyu-dist/shenyu-${role}-dist/docker/entrypoint.sh" "${RUNTIME_DIR}/${role}/entrypoint.sh"
  chmod +x "${RUNTIME_DIR}/${role}/entrypoint.sh"
  cat > "${RUNTIME_DIR}/${role}/Dockerfile" <<DOCKERFILE
FROM eclipse-temurin:17-jre
WORKDIR /opt/shenyu-${role}
COPY app/ /opt/shenyu-${role}/
COPY entrypoint.sh /opt/shenyu-${role}/entrypoint.sh
ENTRYPOINT ["/opt/shenyu-${role}/entrypoint.sh"]
DOCKERFILE
  docker build -t "shenyu-plugin-store-${role}:etcd" "${RUNTIME_DIR}/${role}"
done
printf 'Built external etcd runtime images in %s\n' "${RUNTIME_DIR}"
