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

import io
import json
import os
import sys
import time
import uuid
import urllib.error
import urllib.parse
import urllib.request
import zipfile

ADMIN = os.environ.get("SHENYU_ADMIN_URL", "http://localhost:31095")
GATEWAY = os.environ.get("SHENYU_GATEWAY_URL", "http://localhost:31195")
NAMESPACE = os.environ.get("SHENYU_NAMESPACE_ID", "649330b6-c2d7-4edc-be8e-8a54df9eb385")
UPSTREAM = os.environ.get("STORE_HTTP_BACKEND_UPSTREAM", "plugin-store-backend:9080")
if UPSTREAM.startswith("http://"):
    UPSTREAM = UPSTREAM[len("http://"):]


def request(method, url, payload=None, headers=None):
    data = None if payload is None else json.dumps(payload).encode()
    req_headers = {"Content-Type": "application/json"}
    if headers:
        req_headers.update(headers)
    req = urllib.request.Request(url, data=data, headers=req_headers, method=method)
    try:
        with urllib.request.urlopen(req, timeout=20) as response:
            body = response.read().decode()
            parsed = json.loads(body) if body else None
            return response.status, parsed
    except urllib.error.HTTPError as exc:
        body = exc.read().decode()
        raise RuntimeError(f"{method} {url} failed HTTP {exc.code}: {body}") from exc


def request_multipart(method, url, fields, files, headers=None):
    boundary = "----shenyu-plugin-store-" + uuid.uuid4().hex
    parts = []
    for name, value in fields.items():
        parts.append(f"--{boundary}\r\n".encode())
        parts.append(f'Content-Disposition: form-data; name="{name}"\r\n\r\n'.encode())
        parts.append(str(value).encode())
        parts.append(b"\r\n")
    for name, (filename, content_type, content) in files.items():
        parts.append(f"--{boundary}\r\n".encode())
        parts.append(f'Content-Disposition: form-data; name="{name}"; filename="{filename}"\r\n'.encode())
        parts.append(f"Content-Type: {content_type}\r\n\r\n".encode())
        parts.append(content)
        parts.append(b"\r\n")
    parts.append(f"--{boundary}--\r\n".encode())
    data = b"".join(parts)
    req_headers = {"Content-Type": f"multipart/form-data; boundary={boundary}"}
    if headers:
        req_headers.update(headers)
    req = urllib.request.Request(url, data=data, headers=req_headers, method=method)
    try:
        with urllib.request.urlopen(req, timeout=60) as response:
            body = response.read().decode()
            parsed = json.loads(body) if body else None
            return response.status, parsed
    except urllib.error.HTTPError as exc:
        body = exc.read().decode()
        raise RuntimeError(f"{method} {url} failed HTTP {exc.code}: {body}") from exc


def admin_result(method, path, payload=None, token=None, expected_message=None):
    headers = {"X-Access-Token": token} if token else None
    status, body = request(method, ADMIN + path, payload, headers)
    if status != 200:
        raise RuntimeError(f"{method} {path} returned HTTP {status}: {body}")
    if not isinstance(body, dict) or body.get("code") != 200:
        raise RuntimeError(f"{method} {path} returned unsuccessful ShenYu result: {body}")
    if expected_message and body.get("message") != expected_message:
        raise RuntimeError(f"{method} {path} expected message {expected_message!r}, got {body.get('message')!r}: {body}")
    print(f"{method} {path} -> {body.get('message')}")
    return body


def gateway_json(path):
    status, body = request("GET", GATEWAY + path, headers={})
    if status != 200:
        raise RuntimeError(f"GET {path} returned HTTP {status}: {body}")
    return body


def gateway_e2e_json(path):
    status, body = request("GET", GATEWAY + "/shenyu/e2e/" + path, headers={"localKey": "123456"})
    if status != 200:
        raise RuntimeError(f"GET /shenyu/e2e/{path} returned HTTP {status}: {body}")
    return body


def get_admin(path, token):
    status, body = request("GET", ADMIN + path, headers={"X-Access-Token": token})
    if status != 200:
        raise RuntimeError(f"GET {path} returned HTTP {status}: {body}")
    if not isinstance(body, dict) or body.get("code") != 200:
        raise RuntimeError(f"GET {path} returned unsuccessful ShenYu result: {body}")
    print(f"GET {path} -> {body.get('message')}")
    return body


def get_namespace_plugins(token):
    return get_admin(f"/namespace-plugin/all/{NAMESPACE}", token)["data"]


def import_namespace_plugin_relation(token, plugin_id, plugin_name):
    archive = io.BytesIO()
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as config_zip:
        config_zip.writestr("plugin_template.json", json.dumps([{
            "id": plugin_id,
            "name": plugin_name,
            "role": "Proxy",
            "sort": 200,
            "enabled": True,
        }]))
        config_zip.writestr("namespace_plugin.json", json.dumps([{
            "pluginId": plugin_id,
            "name": plugin_name,
            "config": json.dumps({"multiSelectorHandle": "1", "multiRuleHandle": "0"}),
            "sort": 200,
            "enabled": True,
        }]))
    status, body = request_multipart(
        "POST",
        ADMIN + "/configs/import",
        {"namespace": NAMESPACE},
        {"file": ("divide-namespace-plugin.zip", "application/zip", archive.getvalue())},
        {"X-Access-Token": token},
    )
    if status != 200:
        raise RuntimeError(f"POST /configs/import returned HTTP {status}: {body}")
    if not isinstance(body, dict) or body.get("code") != 200:
        raise RuntimeError(f"POST /configs/import returned unsuccessful ShenYu result: {body}")
    print(f"POST /configs/import -> {body.get('message')} {body.get('data')}")


def enable_namespace_plugin(token, plugin_id, plugin_name):
    plugins = get_namespace_plugins(token)
    match = next((plugin for plugin in plugins if str(plugin.get("id") or plugin.get("pluginId")) == plugin_id or plugin.get("name") == plugin_name), None)
    if match is None:
        import_namespace_plugin_relation(token, plugin_id, plugin_name)
        plugins = get_namespace_plugins(token)
        match = next((plugin for plugin in plugins if str(plugin.get("id") or plugin.get("pluginId")) == plugin_id or plugin.get("name") == plugin_name), None)
    if match is None:
        raise RuntimeError(f"could not resolve namespace plugin relation for {plugin_name}: {plugins}")
    admin_result("POST", "/namespace-plugin/enabledByNamespace", {"ids": [plugin_id], "enabled": True, "namespaceId": NAMESPACE}, token)
    admin_result("POST", "/namespace-plugin/syncPluginAll", {"namespaceId": NAMESPACE}, token)
    print(f"enabled namespace plugin {plugin_name} plugin id={plugin_id}")
    return plugin_id

def search(token, path, condition):
    body = admin_result("POST", path, {"pageNum": 1, "pageSize": 20, "condition": condition}, token, "query success")
    return body["data"]


def login():
    body = admin_result("POST", "/platform/login", {"userName": "admin", "password": "123456"}, None, "login dashboard user success")
    token = body["data"]["token"]
    if not token:
        raise RuntimeError("admin login returned empty token")
    return token


def create_selector(token):
    selector = {
        "name": "plugin-store-http-route",
        "pluginId": "5",
        "type": "1",
        "matchMode": "0",
        "enabled": True,
        "loged": True,
        "continued": True,
        "matchRestful": False,
        "sort": 1,
        "namespaceId": NAMESPACE,
        "handle": json.dumps([{
            "upstreamHost": "plugin-store-backend",
            "protocol": "http://",
            "upstreamUrl": UPSTREAM,
            "weight": 50,
            "status": True,
            "timestamp": 0,
            "warmup": 0,
            "healthCheckEnabled": False,
        }]),
        "selectorConditions": [{"paramType": "uri", "operator": "match", "paramName": "/", "paramValue": "/http/**"}],
    }
    admin_result("POST", "/selector", selector, token, "create success")
    found = search(token, "/selector/list/search", {"keyword": selector["name"], "plugins": ["5"], "switchStatus": True, "namespaceId": NAMESPACE})
    if found.get("total") != 1:
        raise RuntimeError(f"expected one divide selector, got {found}")
    selector_id = found["list"][0]["id"]
    print(f"divide selector id={selector_id}")
    return selector_id


def bind_discovery_upstream(token, selector_id):
    binding = {
        "name": "plugin-store-http-route",
        "pluginName": "divide",
        "type": "http",
        "selectorId": selector_id,
        "namespaceId": NAMESPACE,
        "discovery": {
            "discoveryType": "local",
            "props": "{}",
        },
        "discoveryUpstreams": [{
            "url": UPSTREAM,
            "protocol": "http://",
            "status": 0,
            "weight": 50,
            "namespaceId": NAMESPACE,
            "props": json.dumps({"warmup": "0", "healthCheckEnabled": "false"}),
        }],
    }
    admin_result("POST", "/proxy-selector/binding", binding, token, "create success")


def create_rule(token, selector_id):
    rule = {
        "name": "plugin-store-http-route",
        "selectorId": selector_id,
        "matchMode": "0",
        "enabled": True,
        "loged": True,
        "matchRestful": False,
        "sort": 1,
        "namespaceId": NAMESPACE,
        "handle": json.dumps({"loadBalance": "hash", "retryStrategy": "current", "retry": "1", "timeout": 3000, "headerMaxSize": 10240, "requestMaxSize": 10240}),
        "ruleConditions": [{"paramType": "uri", "operator": "match", "paramName": "/", "paramValue": "/http/**"}],
    }
    admin_result("POST", "/rule", rule, token, "create success")
    found = search(token, "/rule/list/search", {"keyword": rule["name"], "selectors": [selector_id], "switchStatus": True, "namespaceId": NAMESPACE})
    if found.get("total") != 1:
        raise RuntimeError(f"expected one divide rule, got {found}")
    rule_id = found["list"][0]["id"]
    print(f"divide rule id={rule_id}")
    return rule_id


def create_metadata(token):
    metadata = {
        "appName": "plugin-store-backend",
        "contextPath": "/http",
        "path": "/http/order/findById",
        "ruleName": "plugin-store-http-route",
        "pathDesc": "store e2e metadata",
        "rpcType": "http",
        "serviceName": "plugin-store-backend",
        "methodName": "findById",
        "parameterTypes": "java.lang.String",
        "rpcExt": "{}",
        "enabled": True,
        "namespaceId": NAMESPACE,
    }
    admin_result("POST", "/meta-data/createOrUpdate", metadata, token)
    admin_result("POST", "/meta-data/syncData", {}, token)


def iter_dicts(value):
    if isinstance(value, dict):
        yield value
        for nested in value.values():
            yield from iter_dicts(nested)
    elif isinstance(value, list):
        for item in value:
            yield from iter_dicts(item)


def contains_named(items, name):
    return any(item.get("name") == name for item in iter_dicts(items))


def contains_key(items, key):
    return any(key in item for item in iter_dicts(items))


def contains_nonempty(items):
    return any(item for item in iter_dicts(items))


def wait_for_sync(token):
    deadline = time.time() + 180
    while time.time() < deadline:
        selectors = search(token, "/selector/list/search", {"switchStatus": True, "namespaceId": NAMESPACE})["list"]
        rules = search(token, "/rule/list/search", {"switchStatus": True, "namespaceId": NAMESPACE})["list"]
        metadata = admin_result("GET", "/meta-data/findAll", None, token, "query success")["data"]
        gateway_plugins = gateway_e2e_json("plugins")
        gateway_selectors = gateway_e2e_json("selectorData")
        gateway_rules = gateway_e2e_json("ruleData")
        gateway_metadata = gateway_e2e_json("metadata")
        synced = (
            contains_key(gateway_plugins, "divide")
            and len(selectors) == len(gateway_selectors)
            and len(rules) == len(gateway_rules)
            and len(metadata) == len(gateway_metadata)
            and contains_nonempty(gateway_selectors)
            and contains_nonempty(gateway_rules)
            and contains_nonempty(gateway_metadata)
        )
        if synced:
            print(f"admin/gateway sync counts plugins={len(gateway_plugins)} selectors={len(selectors)} rules={len(rules)} metadata={len(metadata)}")
            return
        print(f"waiting sync admin selectors/rules/meta={len(selectors)}/{len(rules)}/{len(metadata)} gateway plugins/selectors/rules/meta={len(gateway_plugins)}/{len(gateway_selectors)}/{len(gateway_rules)}/{len(gateway_metadata)}")
        time.sleep(2)
    raise RuntimeError("admin/gateway data sync did not converge")


def wait_for_route():
    deadline = time.time() + 60
    while time.time() < deadline:
        try:
            status, body = request("GET", GATEWAY + "/http/order/findById?id=rabbitmq-e2e-health", headers={})
            if status == 200 and isinstance(body, dict) and body.get("code") is None:
                print(f"gateway route ready: {body}")
                return
            print(f"waiting route status={status} body={body}")
        except Exception as exc:
            print(f"waiting route: {exc}")
        time.sleep(2)
    raise RuntimeError("gateway route did not become ready")


def main():
    token = login()
    enable_namespace_plugin(token, "5", "divide")
    selector_id = create_selector(token)
    create_rule(token, selector_id)
    bind_discovery_upstream(token, selector_id)
    create_metadata(token)
    wait_for_sync(token)
    wait_for_route()


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"seed-rabbitmq-e2e-admin failed: {exc}", file=sys.stderr)
        sys.exit(1)
