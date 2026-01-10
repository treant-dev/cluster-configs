#!/usr/bin/env python3
import sys, json, yaml

data = json.load(sys.stdin)

groups = {}

for name, meta in data.items():
    ip = meta["public_ip"]
    roles = meta.get("roles") or []
    if isinstance(meta.get("role"), str):
        roles = [meta["role"]]

    if not roles:
        roles = ["ungrouped"]

    for r in roles:
        groups.setdefault(r, {"hosts": {}})
        groups[r]["hosts"][name] = {"ansible_host": ip}

inventory = {
    "all": {
        "vars": {"ansible_user": "root"},
        "children": groups
    }
}

print(yaml.safe_dump(inventory, sort_keys=False))