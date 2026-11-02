# Statusline de Claude Code: modelo, contexto y límites en vivo

[Read in English](README.en.md)

English version: [README.en.md](README.en.md) (archivos en `en/`).

Una barra de estado para Claude Code en Python, sin dependencias (no necesita `jq`): modelo, carpeta y rama de git, porcentaje de contexto con color, uso de los límites de 5 h y 7 días (planes Pro, Max y Ultra) y coste estimado de la sesión.

```text
[Opus] mi-proyecto (main) | ctx 62% | 5h 24% | 7d 41% | $0.43
```

La explicación completa (cuándo se ejecuta, qué campos llegan, por qué `/context` marca más y qué hacer si la barra no aparece) está en la receta:

- Español: https://ctrlia.dev/recetas/statusline.html
- English: https://ctrlia.dev/en/recetas/statusline.html

## Qué incluye

| Archivo | Para qué |
| --- | --- |
| `statusline.py` | El script de la barra (Python 3, solo biblioteca estándar) |
| `settings.ejemplo.json` | El bloque `statusLine` para `~/.claude/settings.json` |
| `settings.jq.ejemplo.json` | La alternativa de una línea de la doc oficial (requiere `jq`) |
| `probar.sh` | Prueba el script con datos simulados, sin abrir Claude Code |

## Cómo usarlo

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-statusline.git
cp ctrlia-statusline/statusline.py ~/.claude/statusline.py
chmod +x ~/.claude/statusline.py
./ctrlia-statusline/probar.sh ~/.claude/statusline.py
```

Después añade a `~/.claude/settings.json` el bloque de `settings.ejemplo.json` (si ya tienes otras claves, mezcla solo `statusLine`, no sustituyas el archivo). Claude Code recarga la configuración solo.

Si la barra no aparece: acepta la confianza en la carpeta, comprueba `chmod +x` y arranca con `claude --debug-file /tmp/claude-debug.log` para ver el stderr y el código de salida del script.

## Qué se probó

Con Claude Code **2.1.316**, Python 3.12.3 y Linux: `probar.sh` pasa las pruebas con todos los datos, con campos `null` o ausentes y con un JSON vacío. En una carpeta de confianza (con `claude --settings`, sin tocar la configuración del usuario) la barra se pintó y el registro dijo `completed with status 0`. No se vio `rate_limits` en la barra real (solo llega tras la primera respuesta) ni se comprobó el mensaje de carpeta sin confianza, que sale de la doc oficial.

## Licencia

MIT. Ver [LICENSE](LICENSE).

---
Parte de **[Ctrl+IA](https://ctrlia.dev/)**: programa con Claude Code como un pro, en español. Hecho por Carlos P.
