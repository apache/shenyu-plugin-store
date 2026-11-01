#!/usr/bin/env python3
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

import importlib.util
import json
import os
from pathlib import Path
import sys
import time
import urllib.error
import urllib.request

SPEC = importlib.util.spec_from_file_location("admin_fixture", Path(__file__).with_name("seed-rabbitmq-e2e-admin.py"))
API = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(API)
STATE = Path(os.environ["ETCD_E2E_STATE"])


def route(path):
    try:
        with urllib.request.urlopen(API.GATEWAY + path, timeout=5) as response:
            return response.status, response.read().decode()
    except urllib.error.HTTPError as exc:
        return exc.code, exc.read().decode()


def await_route(path, expected):
    deadline = time.monotonic() + 60
    while time.monotonic() < deadline:
        status, body = route(path)
        if expected and status == 200 and body == "etcd-e2e-upstream":
            return
        if not expected and body != "etcd-e2e-upstream" and status >= 400:
            return
        time.sleep(0.5)
    raise AssertionError(f"route {path}: status={status}, body={body!r}, expected matched={expected}")


def prepare():
    token = API.login()
    API.enable_namespace_plugin(token, "5", "divide")
    selector = API.create_selector(token)
    rule = API.create_rule(token, selector)
    API.bind_discovery_upstream(token, selector)
    STATE.write_text(json.dumps({"selector": selector, "rule": rule}), encoding="utf-8")


def verify():
    state = json.loads(STATE.read_text(encoding="utf-8"))
    token = API.login()
    # Data exists before the gateway starts: this is initial snapshot coverage.
    await_route("/http/initial", True)
    updated = {
        "id": state["rule"], "name": "plugin-store-http-route", "selectorId": state["selector"],
        "matchMode": 0, "enabled": True, "loged": False, "matchRestful": False, "sort": 1,
        "namespaceId": API.NAMESPACE, "handle": json.dumps({"loadBalance": "hash", "retry": 0, "timeout": 3000}),
        "ruleConditions": [{"paramType": "uri", "operator": "=", "paramName": "/", "paramValue": "/http/updated"}],
    }
    API.admin_result("PUT", "/rule/" + state["rule"], updated, token)
    await_route("/http/updated", True)
    await_route("/http/initial", False)
    API.admin_result("DELETE", "/rule/batch", {"ids": [state["rule"]], "namespaceId": API.NAMESPACE}, token)
    await_route("/http/updated", False)
    API.admin_result("DELETE", "/selector/batch", {"ids": [state["selector"]], "namespaceId": API.NAMESPACE}, token)


if __name__ == "__main__":
    {"prepare": prepare, "verify": verify}[sys.argv[1]]()
