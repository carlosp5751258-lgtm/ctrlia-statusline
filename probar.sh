#!/usr/bin/env bash
# Prueba statusline.py con datos simulados, sin abrir Claude Code.
set -euo pipefail
SCRIPT="${1:-$(dirname "$0")/statusline.py}"

echo "== Con todos los datos =="
echo '{"model":{"display_name":"Opus"},"workspace":{"current_dir":"'"$PWD"'"},"context_window":{"used_percentage":62.4},"cost":{"total_cost_usd":0.43},"rate_limits":{"five_hour":{"used_percentage":23.5},"seven_day":{"used_percentage":41.2}},"session_id":"prueba"}' \
  | "$SCRIPT"

echo "== Sin límites ni datos (inicio de sesión o clave de API) =="
salida="$(echo '{"model":{"display_name":"Sonnet"},"workspace":{"current_dir":"/tmp"},"context_window":{"used_percentage":null},"session_id":"x"}' | "$SCRIPT")"
echo "$salida"
case "$salida" in
  *"[Sonnet] tmp"*"ctx 0%"*'$0.00') echo "OK: aguanta campos null o ausentes" ;;
  *) echo "ERROR: salida inesperada" >&2; exit 1 ;;
esac

echo "== JSON vacío =="
echo '{}' | "$SCRIPT"
