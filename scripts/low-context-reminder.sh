#!/bin/bash
# UserPromptSubmit hook: ユーザー発話のたびに、低コンテキスト執筆スキルの利用を短く促す
# スキル本文そのものは差し込まない（毎回のtoken消費を避けるため）
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"【執筆規範】low-context-writingスキルをこのセッションでまだ読んでいないなら、返答を書く前にSkillツールで必ず読むこと。既に読んでいるなら、その原則（結論を先に・造語や番号だけの参照をしない・事実/推論/提案を分ける・していないことを明示する・判断を求めるときは前提と選択肢と推奨を添える）に則って返答すること"}}
JSON
