#!/usr/bin/env bash
# Prints an xcodebuild -destination string for an available iPhone simulator (prefers iPhone 16, else newest iPhone).
set -euo pipefail
udid=$(xcrun simctl list devices available -j | python3 -c '
import json, sys
data = json.load(sys.stdin)["devices"]
best = None
for runtime, devs in data.items():
    if "iOS" not in runtime:
        continue
    ver = tuple(int(x) for x in runtime.split("iOS-")[-1].split("-") if x.isdigit())
    for d in devs:
        if d.get("isAvailable") and d["name"].startswith("iPhone") and "SE" not in d["name"]:
            pref = 1 if d["name"] == "iPhone 16" else 0
            key = (ver, pref, d["name"])
            if best is None or key > best[0]:
                best = (key, d["udid"])
print(best[1] if best else "")
')
if [ -z "$udid" ]; then echo "No available iPhone simulator" >&2; exit 1; fi
echo "platform=iOS Simulator,id=$udid"
