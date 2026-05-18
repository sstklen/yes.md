#!/bin/bash
# YES.md Hook: Pre-Bash Danger Guard
# 觸發時機：AI 要執行 Bash 指令之前
# 作用：攔截危險操作，不靠 AI 自律靠腳本擋

CMD="${1:-$TOOL_INPUT}"

# 危險指令清單
DANGERS=(
  "rm -rf /"
  "rm -rf *"
  "rm -rf ."
  "git reset --hard"
  "git clean -fd"
  "git checkout -- ."
  "git push --force"
  "git push -f"
  "DROP TABLE"
  "DROP DATABASE"
  "TRUNCATE"
  "> /dev/sda"
  "mkfs"
  ":(){:|:&};:"
)

for DANGER in "${DANGERS[@]}"; do
  if echo "$CMD" | grep -qiF "$DANGER"; then
    echo "═══════════════════════════════════════════"
    echo "🚨 YES.md BLOCKED — dangerous command detected"
    echo "═══════════════════════════════════════════"
    echo "  Command: $CMD"
    echo "  Matched: $DANGER"
    echo ""
    echo "  This command can cause irreversible damage."
    echo "  If you really need this, ask the user first."
    echo "═══════════════════════════════════════════"
    exit 1
  fi
done

exit 0
