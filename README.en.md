# Claude Code statusline: live model, context and usage limits

[Leer en español](README.md)

A Python status line for Claude Code with no dependencies (no `jq` needed): model, folder and git branch, colored context percentage, usage of the 5-hour and 7-day limits (Pro, Max and Ultra plans) and the session's estimated cost.

```text
[Opus] my-project (main) | ctx 62% | 5h 24% | 7d 41% | $0.43
```

The full explanation (when it runs, which fields arrive, why `/context` shows more and what to do if the bar doesn't show) is in the recipe:

- English: https://ctrlia.dev/en/recetas/statusline.html
- Español: https://ctrlia.dev/recetas/statusline.html

## What's included

| File | What for |
| --- | --- |
| `statusline.py` | The status line script (Python 3, standard library only) |
| `settings.ejemplo.json` | The `statusLine` block for `~/.claude/settings.json` |
| `settings.jq.ejemplo.json` | The one-line alternative from the official docs (requires `jq`) |
| `probar.sh` | Tests the script with mock data, without opening Claude Code (messages in Spanish) |

## How to use it

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-statusline.git
cp ctrlia-statusline/statusline.py ~/.claude/statusline.py
chmod +x ~/.claude/statusline.py
./ctrlia-statusline/probar.sh ~/.claude/statusline.py
```

Then add the block from `settings.ejemplo.json` to `~/.claude/settings.json` (if you already have other keys, merge only `statusLine`, don't replace the file). Claude Code reloads the settings by itself.

If the bar doesn't show: accept workspace trust for the folder, check `chmod +x` and start with `claude --debug-file /tmp/claude-debug.log` to see the script's stderr and exit code.

## What was tested

With Claude Code **2.1.316**, Python 3.12.3 and Linux: `probar.sh` passes with full data, with `null` or missing fields and with an empty JSON. In a trusted folder (with `claude --settings`, without touching the user's settings) the bar rendered and the log said `completed with status 0`. `rate_limits` wasn't seen in the real bar (it only arrives after the first response), and the untrusted-folder message wasn't verified; it comes from the official docs.

## License

MIT. See [LICENSE](LICENSE).

---
Part of **[Ctrl+IA](https://ctrlia.dev/)**: code with Claude Code like a pro, in Spanish. Made by Carlos P.
