#!/usr/bin/env python3
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
#
"""Build and optionally execute an H2 fixture for store-owned plugin SQL.

The fixture keeps pinned core DDL/data as the baseline, removes only the target
plugin seed rows recorded in a shipped row-manifest.json, runs the store-owned
preflight.sql before install.sql, then proves the installed row counts and
repeatability. This lets original IT/E2E harnesses prove that plugin rows,
handles, resources, permissions, and namespace bindings come from the store SQL
asset rather than from a bundled core seed.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
from pathlib import Path
from typing import Any

SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_MANIFEST = SCRIPT_DIR / "plugin-sql-seed-manifest.json"
DEFAULT_CORE_SOURCE = Path(os.environ.get("SHENYU_CORE_SOURCE", "/tmp/shenyu-remaining-source"))
DEFAULT_OUTPUT_DIR = Path(os.environ.get("STORE_PLUGIN_SQL_FIXTURE_DIR", "target/plugin-store-sql-fixture"))
DEFAULT_H2_JAR = Path.home() / ".m2" / "repository" / "com" / "h2database" / "h2" / "1.4.200" / "h2-1.4.200.jar"
DEFAULT_NAMESPACE = "649330b6-c2d7-4edc-be8e-8a54df9eb385"
TABLES = {"plugin", "plugin_handle", "resource", "permission", "namespace_plugin_rel"}
COUNT_TABLES = ["plugin", "plugin_handle", "resource", "permission", "namespace_plugin_rel"]


def split_statements(sql: str) -> list[str]:
    statements: list[str] = []
    start = 0
    in_single = False
    in_double = False
    in_line_comment = False
    in_block_comment = False
    i = 0
    while i < len(sql):
        char = sql[i]
        next_char = sql[i + 1] if i + 1 < len(sql) else ""
        if in_line_comment:
            if char == "\n":
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if char == "*" and next_char == "/":
                in_block_comment = False
                i += 2
                continue
            i += 1
            continue
        if not in_single and not in_double and char == "-" and next_char == "-":
            in_line_comment = True
            i += 2
            continue
        if not in_single and not in_double and char == "/" and next_char == "*":
            in_block_comment = True
            i += 2
            continue
        if char == "'" and not in_double:
            if in_single and next_char == "'":
                i += 2
                continue
            if in_single and i > 0 and sql[i - 1] == "\\":
                i += 1
                continue
            in_single = not in_single
        elif char == '"' and not in_single:
            in_double = not in_double
        elif char == ";" and not in_single and not in_double:
            statement = sql[start:i].strip()
            if statement:
                statements.append(statement)
            start = i + 1
        i += 1
    tail = sql[start:].strip()
    if tail:
        statements.append(tail)
    return statements


def split_csv(text: str) -> list[str]:
    values: list[str] = []
    current: list[str] = []
    quote: str | None = None
    escape = False
    depth = 0
    for char in text:
        if quote:
            current.append(char)
            if char == "\\" and not escape:
                escape = True
                continue
            if char == quote and not escape:
                quote = None
            escape = False
            continue
        if char in {"'", '"'}:
            quote = char
            current.append(char)
            continue
        if char == "(":
            depth += 1
        elif char == ")" and depth:
            depth -= 1
        if char == "," and depth == 0:
            values.append("".join(current).strip())
            current = []
        else:
            current.append(char)
    values.append("".join(current).strip())
    return values


def literal_value(value: str) -> str | None:
    stripped = value.strip()
    if stripped.upper() == "NULL":
        return None
    if len(stripped) >= 2 and stripped[0] == "'" and stripped[-1] == "'":
        return stripped[1:-1].replace("''", "'")
    return stripped


def sql_literal(value: str) -> str:
    return "'" + value.replace("'", "''") + "'"


def parse_insert_id(statement: str) -> tuple[str, str] | None:
    match = re.match(r"\s*INSERT(?:\s+IGNORE)?\s+INTO\s+`?([\w_]+)`?\s*\((.*?)\)\s*VALUES\s*\((.*)\)\s*;?\s*$", statement, re.IGNORECASE | re.DOTALL)
    if not match:
        return None
    table = match.group(1)
    if table not in TABLES:
        return None
    columns = [column.strip().strip('`"').lower() for column in match.group(2).split(",")]
    try:
        id_index = columns.index("id")
    except ValueError:
        return None
    values = split_csv(match.group(3))
    if id_index >= len(values):
        return None
    row_id = literal_value(values[id_index])
    if row_id is None:
        return None
    return table, row_id


def strip_core_seed_rows(core_schema: Path, seed_ids: dict[str, list[str]], output: Path) -> int:
    source = core_schema.read_text()
    seed_sets = {table: set(ids) for table, ids in seed_ids.items()}
    kept: list[str] = []
    removed = 0
    for statement in split_statements(source):
        parsed = parse_insert_id(statement)
        if parsed and parsed[1] in seed_sets.get(parsed[0], set()):
            removed += 1
            continue
        kept.append(statement.rstrip(";").rstrip() + ";")
    output.write_text("\n\n".join(kept) + "\n")
    return removed


def resolve_store_install(store_sql_dir: Path, plugin: str) -> Path:
    candidates = [
        store_sql_dir / "h2" / "install.sql",
        store_sql_dir / plugin / "h2" / "install.sql",
        store_sql_dir / "db" / "plugins" / plugin / "h2" / "install.sql",
    ]
    for candidate in candidates:
        if candidate.is_file():
            return candidate
    matches = sorted(store_sql_dir.glob(f"**/{plugin}/h2/install.sql")) + sorted(store_sql_dir.glob("**/h2/install.sql"))
    if len(matches) == 1:
        return matches[0]
    if not matches:
        raise FileNotFoundError(f"No H2 install.sql found for {plugin} under {store_sql_dir}")
    raise RuntimeError(f"Multiple H2 install.sql candidates for {plugin} under {store_sql_dir}: {matches}")


def resolve_store_preflight(store_sql_dir: Path, plugin: str) -> Path:
    install = resolve_store_install(store_sql_dir, plugin)
    preflight = install.with_name("preflight.sql")
    if preflight.is_file():
        return preflight
    raise FileNotFoundError(f"No H2 preflight.sql found next to {install}")


def resolve_store_row_manifest(store_sql_dir: Path, plugin: str) -> Path | None:
    candidates = [
        store_sql_dir / "row-manifest.json",
        store_sql_dir / plugin / "row-manifest.json",
        store_sql_dir / "db" / "plugins" / plugin / "row-manifest.json",
    ]
    for candidate in candidates:
        if candidate.is_file():
            return candidate
    matches = sorted(store_sql_dir.glob(f"**/{plugin}/row-manifest.json")) + sorted(store_sql_dir.glob("**/row-manifest.json"))
    if len(matches) == 1:
        return matches[0]
    return None


def h2_counts(plugin_data: dict[str, Any]) -> dict[str, int]:
    raw_counts = plugin_data.get("expectedH2Counts") or plugin_data["dialects"]["h2"]["counts"]
    return {table: int(raw_counts.get(table, 0)) for table in COUNT_TABLES}


def h2_row_ids(plugin_data: dict[str, Any]) -> dict[str, list[str]]:
    raw_ids = plugin_data.get("h2CoreSeedIds") or plugin_data["dialects"]["h2"]["rowIds"]
    return {table: [str(value) for value in raw_ids.get(table, [])] for table in COUNT_TABLES}


def h2_url_for_db_file(db_file: Path) -> str:
    return f"jdbc:h2:file:{db_file.resolve()};DB_CLOSE_DELAY=-1;MODE=MySQL;DATABASE_TO_UPPER=false;"


def h2_args(h2_jar: Path, url: str, password: str) -> list[str]:
    args = ["java", "-cp", str(h2_jar), "org.h2.tools.Shell", "-url", url, "-user", "sa"]
    if password:
        args.extend(["-password", password])
    return args


def clean_h2_database_files(db_file: Path) -> None:
    base = db_file.resolve()
    for path in base.parent.glob(base.name + "*"):
        if path.is_file() and path.suffix in {".db", ".mv.db", ".trace.db", ".lock.db"}:
            path.unlink()


def run_h2_script(h2_jar: Path, url: str, script: Path, password: str) -> None:
    cmd = ["java", "-cp", str(h2_jar), "org.h2.tools.RunScript", "-url", url, "-user", "sa"]
    if password:
        cmd.extend(["-password", password])
    cmd.extend(["-script", str(script)])
    completed = subprocess.run(cmd, text=True, capture_output=True)
    if completed.returncode:
        raise RuntimeError(f"{' '.join(cmd)}\nSTDOUT:\n{completed.stdout}\nSTDERR:\n{completed.stderr}")


def run_h2_sql(h2_jar: Path, url: str, sql: str, password: str) -> subprocess.CompletedProcess[str]:
    cmd = h2_args(h2_jar, url, password) + ["-sql", sql]
    return subprocess.run(cmd, text=True, capture_output=True)


def query_h2(h2_jar: Path, url: str, sql: str, password: str) -> str:
    completed = run_h2_sql(h2_jar, url, sql, password)
    if completed.returncode:
        raise RuntimeError(f"{' '.join(completed.args)}\nSTDOUT:\n{completed.stdout}\nSTDERR:\n{completed.stderr}")
    lines = [line.strip() for line in completed.stdout.splitlines() if line.strip()]
    data = [line for line in lines if not line.startswith(("Welcome", "sql>", "(", "COUNT", "VALUE")) and not set(line) <= {"-"}]
    return data[-1] if data else ""


def write_sql_script(path: Path, statements: list[str]) -> None:
    path.write_text("\n".join(statement.rstrip(";") + ";" for statement in statements) + "\n")


def id_count_sql(table: str, ids: list[str]) -> str:
    if not ids:
        return "SELECT 0;"
    values = ", ".join(sql_literal(row_id) for row_id in ids)
    return f"SELECT COUNT(*) FROM {table} WHERE id IN ({values});"


def count_installed_table(h2_jar: Path, url: str, password: str, table: str, row_ids: dict[str, list[str]], plugin_id: str) -> int:
    if table == "plugin_handle" and not row_ids.get(table):
        sql = f"SELECT COUNT(*) FROM plugin_handle WHERE plugin_id = {sql_literal(plugin_id)};"
    else:
        sql = id_count_sql(table, row_ids.get(table, []))
    return int(query_h2(h2_jar, url, sql, password))


def assert_no_target_rows(h2_jar: Path, url: str, password: str, row_ids: dict[str, list[str]], plugin_id: str, plugin_name: str) -> list[str]:
    lines: list[str] = []
    plugin_count = int(query_h2(h2_jar, url, f"SELECT COUNT(*) FROM plugin WHERE id = {sql_literal(plugin_id)} OR name = {sql_literal(plugin_name)};", password))
    if plugin_count:
        raise AssertionError(f"Pinned core still contains target plugin row: count={plugin_count}")
    lines.append("before-store plugin=0")
    for table in ["plugin_handle", "resource", "permission", "namespace_plugin_rel"]:
        actual = count_installed_table(h2_jar, url, password, table, row_ids, plugin_id)
        if actual:
            raise AssertionError(f"Pinned core still contains target {table} rows: count={actual}")
        lines.append(f"before-store {table}=0")
    return lines


def assert_expected_counts(h2_jar: Path, url: str, password: str, plugin_data: dict[str, Any]) -> list[str]:
    plugin_id = str(plugin_data["pluginId"])
    plugin_name = str(plugin_data["pluginName"])
    expected = h2_counts(plugin_data)
    row_ids = h2_row_ids(plugin_data)
    checks = []
    plugin_actual = int(query_h2(h2_jar, url, f"SELECT COUNT(*) FROM plugin WHERE id = {sql_literal(plugin_id)} AND name = {sql_literal(plugin_name)};", password))
    if plugin_actual != expected["plugin"]:
        raise AssertionError(f"{plugin_name} plugin count {plugin_actual} != {expected['plugin']}")
    checks.append(f"plugin={plugin_actual}")
    for table in ["plugin_handle", "resource", "permission", "namespace_plugin_rel"]:
        actual = count_installed_table(h2_jar, url, password, table, row_ids, plugin_id)
        wanted = expected[table]
        if actual != wanted:
            raise AssertionError(f"{plugin_name} {table} count {actual} != {wanted}")
        checks.append(f"{table}={actual}")
    return checks


def apply_core_preflight_install(h2_jar: Path, url: str, password: str, core_output: Path, preflight_output: Path, install_output: Path) -> None:
    run_h2_script(h2_jar, url, core_output, password)
    run_h2_script(h2_jar, url, preflight_output, password)
    run_h2_script(h2_jar, url, install_output, password)
    run_h2_script(h2_jar, url, install_output, password)


def prepare_database(db_file: Path, h2_jar: Path, password: str, core_output: Path, preflight_output: Path, install_output: Path, plugin_data: dict[str, Any]) -> list[str]:
    clean_h2_database_files(db_file)
    url = h2_url_for_db_file(db_file)
    row_ids = h2_row_ids(plugin_data)
    plugin_id = str(plugin_data["pluginId"])
    plugin_name = str(plugin_data["pluginName"])
    run_h2_script(h2_jar, url, core_output, password)
    lines = assert_no_target_rows(h2_jar, url, password, row_ids, plugin_id, plugin_name)
    run_h2_script(h2_jar, url, preflight_output, password)
    run_h2_script(h2_jar, url, install_output, password)
    run_h2_script(h2_jar, url, install_output, password)
    lines.extend(assert_expected_counts(h2_jar, url, password, plugin_data))
    return lines


def verify_repeatable_install(args: argparse.Namespace, plugin_data: dict[str, Any], core_output: Path, preflight_output: Path, install_output: Path) -> list[str]:
    h2_jar = Path(args.h2_jar)
    output_dir = Path(args.output_dir)
    db_file = output_dir / f"{args.plugin}-fixture"
    return prepare_database(db_file, h2_jar, args.h2_password, core_output, preflight_output, install_output, plugin_data)


def conflict_insert_scripts(output_dir: Path, plugin_data: dict[str, Any], namespace: str) -> dict[str, Path]:
    plugin_id = str(plugin_data["pluginId"])
    plugin_name = str(plugin_data["pluginName"])
    row_ids = h2_row_ids(plugin_data)
    scripts: dict[str, Path] = {}
    cases = {
        "plugin-id": [
            f"INSERT INTO plugin (id, name, config, role, sort, enabled) VALUES ({sql_literal(plugin_id)}, {sql_literal(plugin_name + '_conflict')}, NULL, 'Conflict', 0, 0)"
        ],
        "plugin-name": [
            f"INSERT INTO plugin (id, name, config, role, sort, enabled) VALUES ({sql_literal(plugin_id + '_conflict')}, {sql_literal(plugin_name)}, NULL, 'Conflict', 0, 0)"
        ],
    }
    if row_ids["resource"]:
        cases["resource-id"] = [
            f"INSERT INTO resource (id, parent_id, title, name, url, component, resource_type, sort, icon, is_leaf, is_route, perms, status) VALUES ({sql_literal(row_ids['resource'][0])}, '1346775491550474240', 'conflict', 'conflict', '', '', 1, 0, '', 0, 0, 'conflict', 1)"
        ]
    if row_ids["permission"]:
        cases["permission-id"] = [
            f"INSERT INTO permission (id, object_id, resource_id) VALUES ({sql_literal(row_ids['permission'][0])}, 'conflict-object', 'conflict-resource')"
        ]
    if row_ids["namespace_plugin_rel"]:
        cases["namespace-plugin-rel-id"] = [
            f"INSERT INTO namespace_plugin_rel (id, namespace_id, plugin_id, config, sort, enabled) VALUES ({sql_literal(row_ids['namespace_plugin_rel'][0])}, {sql_literal(namespace + '-conflict')}, {sql_literal(plugin_id)}, NULL, 0, 0)"
        ]
    for name, statements in cases.items():
        script = output_dir / f"conflict-{name}.sql"
        write_sql_script(script, statements)
        scripts[name] = script
    return scripts


def verify_preflight_conflicts(args: argparse.Namespace, plugin_data: dict[str, Any], core_output: Path, preflight_output: Path) -> list[str]:
    h2_jar = Path(args.h2_jar)
    output_dir = Path(args.output_dir) / args.plugin
    scripts = conflict_insert_scripts(output_dir, plugin_data, args.default_namespace)
    lines: list[str] = []
    for name, script in scripts.items():
        db_file = output_dir / f"preflight-conflict-{name}"
        clean_h2_database_files(db_file)
        url = h2_url_for_db_file(db_file)
        run_h2_script(h2_jar, url, core_output, args.h2_password)
        run_h2_script(h2_jar, url, script, args.h2_password)
        completed = subprocess.run([
            "java", "-cp", str(h2_jar), "org.h2.tools.RunScript",
            "-url", url, "-user", "sa", "-password", args.h2_password,
            "-script", str(preflight_output),
        ], text=True, capture_output=True)
        if completed.returncode == 0:
            raise AssertionError(f"preflight accepted {name} conflict from {script}")
        lines.append(f"preflight-rejects-{name}")
    return lines


def verify_custom_config_preserved(args: argparse.Namespace, plugin_data: dict[str, Any], core_output: Path, preflight_output: Path, install_output: Path) -> list[str]:
    h2_jar = Path(args.h2_jar)
    output_dir = Path(args.output_dir) / args.plugin
    db_file = output_dir / "custom-config-preserved"
    clean_h2_database_files(db_file)
    url = h2_url_for_db_file(db_file)
    plugin_id = str(plugin_data["pluginId"])
    plugin_name = str(plugin_data["pluginName"])
    row_ids = h2_row_ids(plugin_data)
    namespace_rel_id = row_ids["namespace_plugin_rel"][0]
    plugin_config = '{"custom":"plugin"}'
    namespace_config = '{"custom":"namespace"}'
    custom_script = output_dir / "custom-config-seed.sql"
    write_sql_script(custom_script, [
        f"INSERT INTO plugin (id, name, config, role, sort, enabled) VALUES ({sql_literal(plugin_id)}, {sql_literal(plugin_name)}, {sql_literal(plugin_config)}, 'CustomRole', 999, 1)",
        f"INSERT INTO namespace_plugin_rel (id, namespace_id, plugin_id, config, sort, enabled) VALUES ({sql_literal(namespace_rel_id)}, {sql_literal(args.default_namespace)}, {sql_literal(plugin_id)}, {sql_literal(namespace_config)}, 999, 1)",
    ])
    run_h2_script(h2_jar, url, core_output, args.h2_password)
    run_h2_script(h2_jar, url, custom_script, args.h2_password)
    run_h2_script(h2_jar, url, preflight_output, args.h2_password)
    run_h2_script(h2_jar, url, install_output, args.h2_password)
    run_h2_script(h2_jar, url, install_output, args.h2_password)
    lines = assert_expected_counts(h2_jar, url, args.h2_password, plugin_data)
    plugin_preserved = int(query_h2(
        h2_jar,
        url,
        f"SELECT COUNT(*) FROM plugin WHERE id = {sql_literal(plugin_id)} AND config = {sql_literal(plugin_config)} AND role = 'CustomRole' AND sort = 999 AND enabled = 1;",
        args.h2_password,
    ))
    if plugin_preserved != 1:
        raise AssertionError("install.sql did not preserve existing plugin config/metadata")
    namespace_preserved = int(query_h2(
        h2_jar,
        url,
        f"SELECT COUNT(*) FROM namespace_plugin_rel WHERE id = {sql_literal(namespace_rel_id)} AND config = {sql_literal(namespace_config)} AND sort = 999 AND enabled = 1;",
        args.h2_password,
    ))
    if namespace_preserved != 1:
        raise AssertionError("install.sql did not preserve existing namespace_plugin_rel config/metadata")
    return ["custom-plugin-config-preserved", "custom-namespace-plugin-rel-config-preserved", *lines]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("plugin", help="Plugin slug, for example motan, sofa, tars, casdoor")
    parser.add_argument("--manifest", default=str(DEFAULT_MANIFEST), help="Seed manifest JSON")
    parser.add_argument("--core-source", default=str(DEFAULT_CORE_SOURCE), help="Pinned ShenYu core checkout containing the H2 schema")
    parser.add_argument("--store-sql-dir", default=None, help="Store SQL directory; defaults to db/plugins/<plugin> in the current checkout")
    parser.add_argument("--output-dir", default=str(DEFAULT_OUTPUT_DIR), help="Output fixture directory")
    parser.add_argument("--h2-jar", default=str(DEFAULT_H2_JAR), help="H2 jar path used with --execute")
    parser.add_argument("--h2-password", default="sa", help="Password for the H2 sa user")
    parser.add_argument("--default-namespace", default=DEFAULT_NAMESPACE, help="Default namespace id used by shipped seed rows")
    parser.add_argument("--execute", action="store_true", help="Apply core fixture and store install twice against H2 and assert expected counts")
    parser.add_argument("--verify-conflicts", action="store_true", help="Assert preflight.sql rejects occupied plugin/resource/permission/namespace rows before install")
    parser.add_argument("--verify-custom-config", action="store_true", help="Assert install.sql preserves existing plugin and namespace_plugin_rel config")
    parser.add_argument("--require-row-manifest", action="store_true", help="Fail unless the store SQL directory ships row-manifest.json")
    parser.add_argument("--prepare-db-file", default=None, help="Write a final prepared H2 database at this file base after verification")
    args = parser.parse_args()

    h2_jar = Path(args.h2_jar)
    if (args.execute or args.verify_conflicts or args.verify_custom_config or args.prepare_db_file) and not h2_jar.is_file():
        raise FileNotFoundError(f"H2 jar not found: {h2_jar}")

    manifest_path = Path(args.manifest)
    manifest = json.loads(manifest_path.read_text())
    if args.plugin not in manifest["plugins"]:
        no_sql = manifest.get("noSql", {}).get(args.plugin)
        if no_sql:
            raise SystemExit(f"{args.plugin} has no plugin-owned SQL: {no_sql['reason']}")
        raise SystemExit(f"Unknown plugin slug in {manifest_path}: {args.plugin}")
    core_schema = Path(args.core_source) / manifest["coreH2Schema"]
    if not core_schema.is_file():
        raise FileNotFoundError(f"Pinned core H2 schema not found: {core_schema}")
    store_sql_dir = Path(args.store_sql_dir) if args.store_sql_dir else Path("db") / "plugins" / args.plugin
    install_source = resolve_store_install(store_sql_dir, args.plugin)
    preflight_source = resolve_store_preflight(store_sql_dir, args.plugin)
    row_manifest_source = resolve_store_row_manifest(store_sql_dir, args.plugin)
    if row_manifest_source:
        plugin_data = json.loads(row_manifest_source.read_text())
    elif args.require_row_manifest:
        raise FileNotFoundError(f"No shipped row-manifest.json found for {args.plugin} under {store_sql_dir}")
    else:
        plugin_data = manifest["plugins"][args.plugin]

    plugin_id = str(plugin_data["pluginId"])
    plugin_name = str(plugin_data["pluginName"])
    manifest_plugin = manifest["plugins"][args.plugin]
    if plugin_id != str(manifest_plugin["pluginId"]) or plugin_name != str(manifest_plugin["pluginName"]):
        raise AssertionError(f"row-manifest plugin identity {plugin_id}/{plugin_name} does not match repo manifest for {args.plugin}")

    output_dir = Path(args.output_dir) / args.plugin
    if output_dir.exists():
        shutil.rmtree(output_dir)
    output_dir.mkdir(parents=True)
    core_output = output_dir / "core-without-target-seeds.sql"
    preflight_output = output_dir / "store-h2-preflight.sql"
    install_output = output_dir / "store-h2-install.sql"
    result_output = output_dir / "fixture-result.json"
    seed_ids = h2_row_ids(plugin_data)
    removed = strip_core_seed_rows(core_schema, seed_ids, core_output)
    preflight_output.write_text(preflight_source.read_text())
    install_output.write_text(install_source.read_text())

    result: dict[str, Any] = {
        "plugin": args.plugin,
        "pluginId": plugin_id,
        "pluginName": plugin_name,
        "coreSchema": str(core_schema),
        "coreWithoutTargetSeeds": str(core_output),
        "storeRowManifest": str(row_manifest_source) if row_manifest_source else None,
        "storePreflightSource": str(preflight_source),
        "storePreflightBundle": str(preflight_output),
        "storeInstallSource": str(install_source),
        "storeInstallBundle": str(install_output),
        "removedCoreSeedRows": removed,
        "expectedH2Counts": h2_counts(plugin_data),
        "h2RowIds": seed_ids,
    }
    if row_manifest_source is None:
        result["warning"] = "repo manifest fallback used; active compose harness should pass --require-row-manifest"
    if args.execute:
        result["execution"] = verify_repeatable_install(args, plugin_data, core_output, preflight_output, install_output)
    if args.verify_conflicts:
        result["preflightConflictChecks"] = verify_preflight_conflicts(args, plugin_data, core_output, preflight_output)
    if args.verify_custom_config:
        result["customConfigChecks"] = verify_custom_config_preserved(args, plugin_data, core_output, preflight_output, install_output)
    if args.prepare_db_file:
        db_file = Path(args.prepare_db_file)
        db_file.parent.mkdir(parents=True, exist_ok=True)
        result["preparedDatabase"] = str(db_file)
        result["preparedDatabaseChecks"] = prepare_database(db_file, h2_jar, args.h2_password, core_output, preflight_output, install_output, plugin_data)
    result_output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
