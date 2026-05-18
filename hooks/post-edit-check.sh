#!/bin/bash
# YES.md Hook: Post-Edit Ripple Check Reminder
# 觸發時機：AI 用 Write/Edit 修改檔案後
# 作用：提醒 AI 跑 ripple-check，不靠自律靠機器

FILE="${1:-$TOOL_INPUT}"

# 跳過非程式碼檔案
case "$FILE" in
  *.md|*.txt|*.log|*.json.bak*|*.bak*) exit 0 ;;
esac

echo "═══════════════════════════════════════════"
echo "🔔 YES.md Ripple Check — you edited: $FILE"
echo "═══════════════════════════════════════════"
echo "Before reporting 'done', verify:"
echo "  □ Same pattern elsewhere?  (grep for similar code)"
echo "  □ Upstream/downstream ok?  (grep who uses this)"
echo "  □ Edge cases covered?      (null, long input, concurrency)"
echo "  □ Actually tested?         (curl / run / execute)"
echo "═══════════════════════════════════════════"
