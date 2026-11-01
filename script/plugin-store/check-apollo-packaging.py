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

import argparse
from pathlib import Path
import zipfile


MODULES = {
    "shenyu-admin-listener-apollo": ("org/apache/shenyu/admin/config/", "org/apache/shenyu/admin/listener/apollo/"),
    "shenyu-sync-data-apollo": ("org/apache/shenyu/sync/data/apollo/",),
    "shenyu-registry-apollo": ("org/apache/shenyu/registry/apollo/",),
    "shenyu-spring-boot-starter-sync-data-apollo": ("org/apache/shenyu/springboot/sync/data/apollo/",),
}


def check(root, version):
    for module, owned in MODULES.items():
        artifact = root / "shenyu-extension/shenyu-extension-apollo" / module / "target" / f"{module}-{version}.jar"
        with zipfile.ZipFile(artifact) as jar:
            names = jar.namelist()
            classes = [name for name in names if name.startswith("org/apache/shenyu/") and name.endswith(".class")]
            if not classes:
                raise AssertionError(f"{artifact}: missing the extension's implementation classes")
            unexpected = [name for name in classes if not name.startswith(owned)]
            if unexpected:
                raise AssertionError(f"{artifact}: embeds core or sibling classes: {unexpected[:5]}")
            if module == "shenyu-registry-apollo":
                registration = jar.read("META-INF/shenyu/org.apache.shenyu.registry.api.ShenyuInstanceRegisterRepository").decode()
                if "apollo=org.apache.shenyu.registry.apollo.ApolloInstanceRegisterRepository" not in registration:
                    raise AssertionError(f"{artifact}: missing the historical Apollo SPI key")
            if module in {"shenyu-admin-listener-apollo", "shenyu-spring-boot-starter-sync-data-apollo"}:
                imports = jar.read("META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports").decode()
                expected = "org.apache.shenyu.admin.config.ApolloSyncConfiguration" if module == "shenyu-admin-listener-apollo" else "org.apache.shenyu.springboot.sync.data.apollo.ApolloSyncDataConfiguration"
                if expected not in imports:
                    raise AssertionError(f"{artifact}: missing starter auto-configuration registration")
        print(f"{module}: implementation, registrations and core API boundary verified")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Check final Apollo extension JAR ownership and runtime registrations.")
    parser.add_argument("--store-root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--version", default="2.7.1-SNAPSHOT")
    args = parser.parse_args()
    check(args.store_root, args.version)
