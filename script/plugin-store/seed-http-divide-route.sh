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

GATEWAY_URL="${SHENYU_GATEWAY_URL:-http://localhost:${SHENYU_BOOTSTRAP_PORT:-31195}}"
UPSTREAM_URL="${STORE_HTTP_BACKEND_UPSTREAM:-http://plugin-store-backend:9080}"

post_json() {
  local path="$1"
  local payload="$2"
  local response
  response="$(curl -fsS -H 'Content-Type: application/json' -H 'localKey: 123456' -d "${payload}" "${GATEWAY_URL}${path}")"
  if [[ "${response}" != "success" ]]; then
    echo "Unexpected response from ${path}: ${response}" >&2
    exit 1
  fi
}

post_json '/shenyu/plugin/saveOrUpdate' '{"id":"plugin-store-divide","name":"divide","enabled":true,"config":""}'

post_json '/shenyu/plugin/selectorAndRules' "{
  \"pluginName\": \"divide\",
  \"selectorHandler\": \"[{\\\"upstreamHost\\\":\\\"plugin-store-backend\\\",\\\"protocol\\\":\\\"http://\\\",\\\"upstreamUrl\\\":\\\"${UPSTREAM_URL#http://}\\\",\\\"weight\\\":50,\\\"status\\\":true,\\\"timestamp\\\":0,\\\"warmup\\\":0,\\\"healthCheckEnabled\\\":false}]\",
  \"conditionDataList\": [
    {\"paramType\": \"uri\", \"operator\": \"match\", \"paramValue\": \"/http/**\"}
  ],
  \"ruleDataList\": [
    {
      \"ruleName\": \"plugin-store-http-route\",
      \"ruleHandler\": \"{}\",
      \"conditionDataList\": [
        {\"paramType\": \"uri\", \"operator\": \"match\", \"paramValue\": \"/http/**\"}
      ]
    }
  ]
}"

curl -fsS "${GATEWAY_URL}/http/test/hystrix/pass" | grep -q '"code":200'
echo "Seeded divide route /http/** to ${UPSTREAM_URL}"
