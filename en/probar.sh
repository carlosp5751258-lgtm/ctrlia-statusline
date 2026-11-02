#!/usr/bin/env bash
# Tests statusline.py with mock data, without opening Claude Code.
set -euo pipefail
SCRIPT="${1:-$(dirname "$0")/statusline.py}"

echo "== With all the data =="
echo '{"model":{"display_name":"Opus"},"workspace":{"current_dir":"'"$PWD"'"},"context_window":{"used_percentage":62.4},"cost":{"total_cost_usd":0.43},"rate_limits":{"five_hour":{"used_percentage":23.5},"seven_day":{"used_percentage":41.2}},"session_id":"test"}' \
  | "$SCRIPT"

echo "== No limits or data (session start or API key) =="
output="$(echo '{"model":{"display_name":"Sonnet"},"workspace":{"current_dir":"/tmp"},"context_window":{"used_percentage":null},"session_id":"x"}' | "$SCRIPT")"
echo "$output"
case "$output" in
  *"[Sonnet] tmp"*"ctx 0%"*'$0.00') echo "OK: copes with null or missing fields" ;;
  *) echo "ERROR: unexpected output" >&2; exit 1 ;;
esac

echo "== Empty JSON =="
echo '{}' | "$SCRIPT"
