#!/usr/bin/env python3
"""Parse candidates.txt (TAB-separated, preserves empty fields) and perform deletions.
Reads environment variables: DRY_RUN, OWNER, PACKAGE, GITHUB_TOKEN.
This version reads the header (a # comment line) to determine column order
so it matches the workflow's output exactly.
"""
import os
import subprocess
import sys

DRY_RUN = os.environ.get("DRY_RUN", "true").lower() == "true"
OWNER = os.environ.get("OWNER")
PACKAGE = os.environ.get("PACKAGE")
GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")

if OWNER is None or PACKAGE is None:
    print("Missing OWNER or PACKAGE environment variables; aborting.")
    raise SystemExit(1)

path = "candidates.txt"
if not os.path.exists(path):
    print(f"{path} not found; aborting.")
    raise SystemExit(1)

with open(path, "r", newline="") as f:
    for raw in f:
        line = raw.rstrip("\n")
        if not line or line.startswith("#"):
            continue
        fields = line.split("\t")
        if len(fields) < 4:
            continue
        # Workflow writes: id, digest, created_at, selected
        id_, digest, created, selected = fields[0], fields[1], fields[2], fields[3]

        if selected == 'yes':
            if DRY_RUN:
                print(f"[dry-run] Would delete package version (id: {id_}) (digest: {digest}) (created: {created})")
            else:
                print(f"Deleting package version (id: {id_}) (digest: {digest}) (created: {created})")
                cmd = [
                    'curl', '-s', '-X', 'DELETE',
                    '-H', f'Authorization: Bearer {GITHUB_TOKEN}',
                    '-H', 'Accept: application/vnd.github+json',
                    f'https://api.github.com/{OWNER}/packages/container/{PACKAGE}/versions/{id_}',
                ]
                try:
                    subprocess.run(cmd, check=False)
                except Exception as e:
                    print('Warning: curl failed:', e)
        else:
            print(f"Candidate (id: {id_}) (created: {created}) is not older than 30 days; skipping")
