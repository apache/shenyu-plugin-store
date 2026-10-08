#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

PLUGIN="${1:?Usage: $0 <plugin-name>}"
SHENYU_GATEWAY_URL="${SHENYU_GATEWAY_URL:-http://localhost:${SHENYU_BOOTSTRAP_PORT:-31195}}"
LOCAL_KEY="${SHENYU_LOCAL_KEY:-123456}"

status_without_key="$(curl -sS -o /dev/null -w '%{http_code}' "${SHENYU_GATEWAY_URL}/shenyu/e2e/plugins")"
if [[ "${status_without_key}" != "403" ]]; then
  echo "Expected /shenyu/e2e/plugins without localKey to return 403, got ${status_without_key}" >&2
  exit 1
fi

for path in metadata selectorData ruleData plugins; do
  response="$(curl -fsS -H "localKey: ${LOCAL_KEY}" "${SHENYU_GATEWAY_URL}/shenyu/e2e/${path}")"
  RESPONSE="${response}" RESPONSE_PATH="${path}" TARGET_PLUGIN="${PLUGIN}" python3 - <<'PY'
import json
import os
import sys

path = os.environ["RESPONSE_PATH"]
target = os.environ["TARGET_PLUGIN"].lower()
try:
    payload = json.loads(os.environ["RESPONSE"])
except json.JSONDecodeError as exc:
    raise SystemExit(f"/shenyu/e2e/{path} returned invalid JSON: {exc}") from exc
if payload in ({}, [], None, ""):
    raise SystemExit(f"/shenyu/e2e/{path} returned an empty payload")
if path != "plugins":
    sys.exit(0)


def has_plugin(value):
    if isinstance(value, dict):
        for key, nested in value.items():
            expected_class = os.environ.get("STORE_PLUGIN_CLASS", "")
            expected_basename = "".join(char.lower() for char in f"{os.environ['TARGET_PLUGIN']}Plugin" if char.isalnum())
            key_basename = "".join(char.lower() for char in key.rsplit(".", 1)[-1] if char.isalnum())
            if key == os.environ["TARGET_PLUGIN"]:
                return True
            if expected_class and key == expected_class:
                return True
            if key_basename == expected_basename:
                return True
            if key.lower() in {"name", "pluginname"} and str(nested).lower() == target:
                return True
            if has_plugin(nested):
                return True
    if isinstance(value, list):
        return any(has_plugin(item) for item in value)
    return False


if not has_plugin(payload):
    raise SystemExit(f"/shenyu/e2e/plugins did not include plugin {os.environ['TARGET_PLUGIN']}")
PY
  echo "/shenyu/e2e/${path} OK"
done
