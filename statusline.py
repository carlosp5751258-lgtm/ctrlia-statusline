#!/usr/bin/env python3
# Guárdalo como ~/.claude/statusline.py y dale permisos: chmod +x ~/.claude/statusline.py
"""Barra de estado: modelo · carpeta (rama) · contexto · límites 5 h / 7 d · coste."""
import json, os, subprocess, sys

d = json.load(sys.stdin)
model = (d.get("model") or {}).get("display_name", "?")
cwd = (d.get("workspace") or {}).get("current_dir") or d.get("cwd", "")
pct = int((d.get("context_window") or {}).get("used_percentage") or 0)
cost = (d.get("cost") or {}).get("total_cost_usd") or 0
limits = d.get("rate_limits") or {}

try:
    branch = subprocess.run(["git", "-C", cwd, "branch", "--show-current"],
                            capture_output=True, text=True, timeout=1).stdout.strip()
except Exception:
    branch = ""

color = "\033[31m" if pct >= 80 else "\033[33m" if pct >= 50 else "\033[32m"
parts = [f"[{model}] {os.path.basename(cwd)}" + (f" ({branch})" if branch else ""),
         f"{color}ctx {pct}%\033[0m"]
for key, label in (("five_hour", "5h"), ("seven_day", "7d")):
    used = (limits.get(key) or {}).get("used_percentage")
    if used is not None:
        parts.append(f"{label} {used:.0f}%")
parts.append(f"${cost:.2f}")
print(" | ".join(parts))
