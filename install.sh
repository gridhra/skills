#!/bin/bash
# このリポジトリのskills/ とscripts/ を ~/.claudeにsymlinkで配る（冪等。既存の実ファイルは壊さずSKIP）。
# hook（scripts/*.sh）の登録は ~/.claude/settings.json に自分で書く。例:
#   "hooks": {"UserPromptSubmit": [{"hooks": [
#     {"type": "command", "command": "~/.claude/scripts/low-context-reminder.sh", "timeout": 5},
#     {"type": "command", "command": "~/.claude/scripts/subagent-review-reminder.sh", "timeout": 5}]}]}
set -u
SRC="$(cd "$(dirname "$0")" && pwd)"
DST="${CLAUDE_HOME:-$HOME/.claude}"
mkdir -p "$DST/scripts" "$DST/skills"

link() { # link <src> <dst>
  if [ -L "$2" ]; then ln -sfn "$1" "$2"; echo "link  $2"
  elif [ -e "$2" ]; then
    if [ "${FORCE:-}" = 1 ]; then rm -r "$2"; ln -s "$1" "$2"; echo "link  $2（置き換え）"
    else echo "SKIP  $2（実ファイルがある。FORCE=1で置き換え）"; fi
  else ln -s "$1" "$2"; echo "link  $2"; fi
}

for f in "$SRC"/scripts/*; do link "$f" "$DST/scripts/$(basename "$f")"; done
for d in "$SRC"/skills/*/; do d="${d%/}"; link "$d" "$DST/skills/$(basename "$d")"; done
echo "done."
