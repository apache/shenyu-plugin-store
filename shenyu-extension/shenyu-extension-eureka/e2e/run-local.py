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

import argparse
import hashlib
import http.server
import json
import os
from pathlib import Path
import re
import secrets
import subprocess
import threading
import time
import urllib.error
import urllib.request
import uuid

NAMESPACE = "649330b6-c2d7-4edc-be8e-8a54df9eb385"
APP = "SHENYU-EXTERNAL-" + uuid.uuid4().hex.upper()
GATEWAY_APP = APP + "-GATEWAY"
PREFIX = "/external-eureka"

def request(url, data=None, token=None, method=None):
    headers = {"Accept": "application/json"}
    if data is not None:
        headers["Content-Type"] = "application/json"
    if token:
        headers["X-Access-Token"] = token
    req = urllib.request.Request(url, data=None if data is None else json.dumps(data).encode(), headers=headers, method=method)
    with urllib.request.urlopen(req, timeout=4) as response:
        return response.status, response.read().decode()

def wait_for(description, check, timeout=90):
    end = time.monotonic() + timeout
    last = None
    while time.monotonic() < end:
        try:
            result = check()
            if result:
                print(description + ": passed", flush=True)
                return result
        except (OSError, ValueError, KeyError, urllib.error.HTTPError) as error:
            last = type(error).__name__
        time.sleep(0.2)
    raise AssertionError(description + " timed out; last error=" + str(last))

def jar(module):
    candidates = [p for p in (module / "target").glob("*.jar")
        if not p.name.startswith("original-") and not p.name.endswith(("-sources.jar", "-javadoc.jar", "-shaded.jar"))]
    assert len(candidates) == 1, candidates
    return candidates[0]

def dependencies(module):
    text = (module / "target/eureka-classpath.txt").read_text().strip()
    return [Path(p.replace(chr(92), "/")) for p in text.split(os.pathsep) if p]

def artifact(path):
    if "repository" in path.parts:
        return path.parent.parent.name
    return re.sub(r"-[0-9].*$", "", path.stem)

def exists(path):
    return path.exists() or (os.name == "nt" and Path(chr(92) * 2 + "?" + chr(92) + str(path.resolve())).exists())

def classpath(core, store, main):
    extension = store / "shenyu-extension/shenyu-extension-eureka"
    registry = extension / "shenyu-registry-eureka"
    starter = extension / "shenyu-spring-boot-starter-registry-eureka"
    retained = core / "shenyu-spring-boot-starter/shenyu-spring-boot-starter-registry"
    ordered = [jar(core / main)] + dependencies(core / main)
    extra = [jar(registry)] + dependencies(registry)
    if main == "shenyu-bootstrap":
        ordered += [jar(retained)] + dependencies(retained)
        extra = [jar(starter), jar(registry)] + dependencies(starter)
    selected = {}
    for path in ordered:
        if artifact(path) != "shenyu-registry-eureka":
            selected.setdefault(artifact(path), path)
    for path in extra:
        selected.setdefault(artifact(path), path)
    assert selected["shenyu-registry-eureka"].resolve() == jar(registry).resolve()
    assert all(exists(path) for path in selected.values()), [str(path) for path in selected.values() if not exists(path)]
    return os.pathsep.join(str(path.resolve()).replace("\\", "/") for path in selected.values())

def backend(label):
    class Handler(http.server.BaseHTTPRequestHandler):
        def do_GET(self):
            body = label.encode()
            self.send_response(200)
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        def log_message(self, *args):
            pass
    server = http.server.ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    threading.Thread(target=server.serve_forever, daemon=True).start()
    return server

def announce(eureka, port, identity="external-backend"):
    payload = {"instance": {"instanceId": identity, "hostName": "127.0.0.1", "app": APP,
        "ipAddr": "127.0.0.1", "status": "UP", "port": {"$": port, "@enabled": "true"},
        "dataCenterInfo": {"@class": "com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo", "name": "MyOwn"},
        "leaseInfo": {"renewalIntervalInSecs": 30, "durationInSecs": 180},
        "metadata": {"weight": "100"}, "vipAddress": APP, "secureVipAddress": APP}}
    status, _ = request(eureka + "/apps/" + APP, payload)
    assert status in (200, 204)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--core", type=Path, required=True)
    parser.add_argument("--store", type=Path, required=True)
    parser.add_argument("--java", type=Path, required=True)
    parser.add_argument("--eureka", default="http://127.0.0.1:18761/eureka")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    core, store = args.core.resolve(), args.store.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    admin = "http://127.0.0.1:18765"
    gateway = "http://127.0.0.1:19195"
    processes = []
    logs = []
    sync_token = secrets.token_hex(32)
    selector_id = None
    first, second, sibling = backend("first"), backend("second"), backend("healthy-sibling")

    def write_args(path, arguments):
        path.write_text("\n".join('"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"' for value in arguments))

    def stop(process):
        if process.poll() is not None:
            return
        process.stdin.write(b"x")
        process.stdin.flush()
        try:
            process.wait(timeout=20)
        except subprocess.TimeoutExpired:
            process.kill()
            process.wait(timeout=5)

    def start(name, module, main_class, properties):
        cp = classpath(core, store, module)
        helper = output / "helper"
        helper.mkdir(exist_ok=True)
        if not (helper / "ExternalProcess.class").exists():
            javac = args.java.parent / ("javac.exe" if os.name == "nt" else "javac")
            compile_args = output / "javac.args"
            write_args(compile_args, ["-cp", cp, "-d", str(helper), str(Path(__file__).with_name("ExternalProcess.java"))])
            subprocess.run([str(javac), "@" + str(compile_args)], check=True)
        cp = str(helper) + os.pathsep + cp
        arguments = ["-Xms128m", "-Xmx768m", "-Deureka.client.refresh.interval=1",
            "-Deureka.appinfo.initial.replicate.time=1", "-Deureka.appinfo.replicate.interval=1",
            "-Xlog:class+load=info:file=" + name + "-classes.log", "-cp", cp, "ExternalProcess", main_class] + properties
        argfile = output / (name + ".args")
        write_args(argfile, arguments)
        log = (output / (name + ".log")).open("w")
        logs.append(log)
        process = subprocess.Popen([str(args.java), "@" + str(argfile)], cwd=output, stdin=subprocess.PIPE, stdout=log, stderr=subprocess.STDOUT)
        processes.append(process)
        return process

    def token():
        if processes[0].poll() is not None:
            raise RuntimeError("Admin exited before readiness; inspect admin.log")
        _, response = request(admin + "/platform/login", {"userName": "admin", "password": "123456"})
        data = json.loads(response)
        return data.get("data", {}).get("token")

    def send(path, body, auth):
        status, response = request(admin + path, body, auth)
        if path.startswith("/shenyu-client/"):
            assert status == 200 and response == "success", (status, response)
        else:
            assert status == 200 and json.loads(response)["code"] == 200, (status, response)

    def provider_loaded(name):
        text = (output / (name + "-classes.log")).read_text(errors="replace")
        lines = [line for line in text.splitlines() if "org.apache.shenyu.registry.eureka.EurekaInstanceRegisterRepository source:" in line]
        return bool(lines) and all("shenyu-extension-eureka" in line for line in lines)

    def gateway_registered():
        data = json.loads(request(args.eureka + "/apps/" + GATEWAY_APP)[1])
        instances = data["application"]["instance"]
        if isinstance(instances, dict):
            instances = [instances]
        return any(int(instance["port"]["$"]) == 19195 for instance in instances)

    def gateway_deregistered():
        try:
            request(args.eureka + "/apps/" + GATEWAY_APP)
            return False
        except urllib.error.HTTPError as error:
            return error.code == 404

    def selector_state():
        nonlocal selector_id
        if selector_id is None:
            pending = [json.loads(request(admin + "/selector?pluginId=5&namespaceId=" + NAMESPACE
                + "&currentPage=1&pageSize=100", token=auth)[1])]
            while pending:
                item = pending.pop()
                if isinstance(item, dict):
                    if item.get("name") == PREFIX:
                        selector_id = item["id"]
                        break
                    pending.extend(item.values())
                elif isinstance(item, list):
                    pending.extend(item)
        if selector_id is None:
            return set()
        data = json.loads(request(admin + "/selector/" + selector_id, token=auth)[1])["data"]
        return {row.get("url", row.get("upstreamUrl")) for row in data.get("discoveryUpstreams", []) if row.get("status") == 0}

    def start_gateway():
        return start("gateway", "shenyu-bootstrap", "org.apache.shenyu.bootstrap.ShenyuBootstrapApplication", [
            "--server.port=19195", "--shenyu.sync.websocket.urls=ws://127.0.0.1:18765/websocket",
            "--shenyu.sync.websocket.token=" + sync_token,
            "--shenyu.heartbeat.serverLists=http://127.0.0.1:18765", "--shenyu.register.enabled=true",
            "--shenyu.register.registerType=eureka", "--shenyu.register.serverLists=" + args.eureka + "/",
            "--shenyu.register.props.name=" + GATEWAY_APP, "--shenyu.register.props.host=127.0.0.1"])

    def route_removed():
        try:
            status, body = request(gateway + PREFIX + "/hello")
            return status != 200 or json.loads(body).get("code") == -119
        except urllib.error.HTTPError as error:
            return error.code in (404, 502, 503)

    try:
        start("admin", "shenyu-admin", "org.apache.shenyu.admin.ShenyuAdminBootstrap", [
            "--server.port=18765", "--spring.profiles.active=h2",
            "--spring.datasource.url=jdbc:h2:mem:external-eureka-e2e;DB_CLOSE_DELAY=-1;MODE=MySQL",
            "--shenyu.jwt.secretKey=" + secrets.token_hex(32),
            "--shenyu.sync.websocket.token=" + sync_token, "--shenyu.register.enabled=true"])
        auth = wait_for("Admin authenticated readiness", token)
        bootstrap = start_gateway()
        wait_for("Gateway external provider origin", lambda: provider_loaded("gateway"))
        wait_for("Gateway bound-port registration", gateway_registered)
        announce(args.eureka, first.server_port)
        send("/shenyu-client/register-metadata", {"appName": "external-eureka", "contextPath": PREFIX,
            "path": PREFIX + "/**", "ruleName": "external-eureka-route", "rpcType": "http", "enabled": True, "registerMetaData": False,
            "host": "127.0.0.1", "port": first.server_port, "pluginNames": ["divide"],
            "timeMillis": int(time.time() * 1000),
            "addPrefixed": False, "namespaceId": NAMESPACE}, auth)
        wait_for("Registered selector readiness", lambda: PREFIX in request(admin
            + "/selector?pluginId=5&namespaceId=" + NAMESPACE + "&currentPage=1&pageSize=100", token=auth)[1])
        send("/shenyu-client/register-discoveryConfig", {"selectorName": PREFIX, "pluginName": "divide",
            "name": "external-eureka", "discoveryType": "eureka", "serverList": args.eureka + "/",
            "listenerNode": APP, "handler": "{}", "namespaceId": NAMESPACE, "props": {}}, auth)
        wait_for("Admin external provider origin", lambda: provider_loaded("admin"))
        wait_for("Admin discovery to gateway HTTP routing", lambda: request(gateway + PREFIX + "/hello")[1] == "first")
        announce(args.eureka, second.server_port)
        wait_for("Eureka update refreshes gateway routing", lambda: request(gateway + PREFIX + "/hello")[1] == "second")
        wait_for("Old endpoint is removed after identity-preserving update", lambda:
            "127.0.0.1:" + str(second.server_port) in selector_state()
            and "127.0.0.1:" + str(first.server_port) not in selector_state())
        stop(bootstrap)
        wait_for("Gateway context shutdown deregisters its instance", gateway_deregistered)
        bootstrap = start_gateway()
        wait_for("Gateway restart restores discovered route", lambda: request(gateway + PREFIX + "/hello")[1] == "second")
        announce(args.eureka, sibling.server_port, "healthy-sibling")
        wait_for("Healthy sibling enters discovery", lambda: "127.0.0.1:" + str(sibling.server_port) in selector_state())
        request(args.eureka + "/apps/" + APP + "/external-backend", method="DELETE")
        wait_for("Deregistration preserves healthy sibling routing", lambda: request(gateway + PREFIX + "/hello")[1] == "healthy-sibling")
        request(args.eureka + "/apps/" + APP + "/healthy-sibling", method="DELETE")
        wait_for("Eureka deregistration removes gateway route", route_removed)
        first.shutdown()
        second.shutdown()
        result = {"core": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=core, text=True).strip(),
            "store": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=store, text=True).strip(),
            "assertions": ["admin-ready", "external-provider-origin-admin", "external-provider-origin-gateway",
                "gateway-bound-port", "discovery-proxy", "discovery-refresh", "old-endpoint-removal",
                "gateway-context-deregistration", "gateway-restart", "healthy-sibling", "deregistration"],
            "backendApplication": APP, "gatewayApplication": GATEWAY_APP,
            "externalRegistryJarSha256": hashlib.sha256(jar(store / "shenyu-extension/shenyu-extension-eureka/shenyu-registry-eureka").read_bytes()).hexdigest()}
        (output / "result.json").write_text(json.dumps(result, indent=2))
    finally:
        for process in reversed(processes):
            stop(process)
        for server in (first, second, sibling):
            server.shutdown()
            server.server_close()
        for log in logs:
            log.close()

if __name__ == "__main__":
    main()

