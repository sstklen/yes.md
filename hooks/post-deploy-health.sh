#!/bin/bash
# YES.md Hook: Post-Deploy Health Check
# 觸發時機：AI 執行含 deploy/docker 的指令後
# 作用：部署後自動提醒跑 health check

CMD="$1"

[ -z "$1" ] && exit 0

# 偵測部署相關指令
if echo "$CMD" | grep -qiE "(docker compose up|docker-compose up|deploy|push.*production|push.*main)"; then
  echo "═══════════════════════════════════════════"
  echo "🏥 YES.md Deploy Health Check"
  echo "═══════════════════════════════════════════"
  echo "You just deployed. Before moving on, verify:"
  echo "  □ Containers healthy?  (docker ps)"
  echo "  □ Endpoints responding? (curl your API)"
  echo "  □ Logs clean?          (docker logs --tail 20)"
  echo "  □ No error spike?      (check monitoring)"
  echo "═══════════════════════════════════════════"
fi

exit 0
