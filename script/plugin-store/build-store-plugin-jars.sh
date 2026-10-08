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
STORE_PLUGIN_SOURCE="${STORE_PLUGIN_SOURCE:-$(pwd)}"
STORE_PLUGIN_JARS_DIR="${STORE_PLUGIN_JARS_DIR:-target/plugin-store-jars}"
DEPENDENCY_SCOPE="${STORE_PLUGIN_DEPENDENCY_SCOPE:-runtime}"
STORE_PLUGIN_MAVEN_GOAL="${STORE_PLUGIN_MAVEN_GOAL:-install}"

case "${PLUGIN}" in
  motan)
    STORE_PLUGIN_MODULES="${STORE_PLUGIN_MODULES:-shenyu-plugin/shenyu-plugin-proxy/shenyu-plugin-motan,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-motan}"
    ;;
  tars)
    STORE_PLUGIN_MODULES="${STORE_PLUGIN_MODULES:-shenyu-plugin/shenyu-plugin-proxy/shenyu-plugin-tars,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-tars}"
    ;;
  hystrix)
    STORE_PLUGIN_MODULES="${STORE_PLUGIN_MODULES:-shenyu-plugin/shenyu-plugin-fault-tolerance/shenyu-plugin-hystrix,shenyu-spring-boot-starter-plugin/shenyu-spring-boot-starter-plugin-hystrix}"
    ;;
  *)
    if [[ -z "${STORE_PLUGIN_MODULES:-}" ]]; then
      echo "Set STORE_PLUGIN_MODULES for ${PLUGIN}, for example module-a,module-b" >&2
      exit 1
    fi
    ;;
esac

if [[ ! -x "${STORE_PLUGIN_SOURCE}/mvnw" ]]; then
  echo "Missing store source ./mvnw: ${STORE_PLUGIN_SOURCE}" >&2
  exit 1
fi

"${STORE_PLUGIN_SOURCE}/mvnw" -B -ntp -f "${STORE_PLUGIN_SOURCE}/pom.xml" -pl "${STORE_PLUGIN_MODULES}" -am "${STORE_PLUGIN_MAVEN_GOAL}" -DskipTests -Dapi.version="${API_VERSION:-1.44}"

rm -rf "${STORE_PLUGIN_JARS_DIR}"
mkdir -p "${STORE_PLUGIN_JARS_DIR}"
STORE_PLUGIN_JARS_DIR="$(cd "${STORE_PLUGIN_JARS_DIR}" && pwd)"
IFS=',' read -r -a MODULES <<< "${STORE_PLUGIN_MODULES}"
for module in "${MODULES[@]}"; do
  module_dir="${STORE_PLUGIN_SOURCE}/${module}"
  if [[ ! -d "${module_dir}" ]]; then
    echo "Missing store plugin module: ${module_dir}" >&2
    exit 1
  fi
  find "${module_dir}/target" -maxdepth 1 -type f -name '*.jar' \
    ! -name '*-sources.jar' \
    ! -name '*-javadoc.jar' \
    ! -name '*-tests.jar' \
    -exec cp {} "${STORE_PLUGIN_JARS_DIR}/" \;
  "${STORE_PLUGIN_SOURCE}/mvnw" -B -ntp -f "${module_dir}/pom.xml" dependency:copy-dependencies \
    -DincludeScope="${DEPENDENCY_SCOPE}" \
    -DexcludeTransitive=false \
    -DoutputDirectory="${STORE_PLUGIN_JARS_DIR}" \
    -Dmdep.overWriteReleases=false \
    -Dmdep.overWriteSnapshots=false \
    -Dmdep.overWriteIfNewer=true \
    -Dapi.version="${API_VERSION:-1.44}"
done

find "${STORE_PLUGIN_JARS_DIR}" -maxdepth 1 -type f -name '*.jar' -print | sort
