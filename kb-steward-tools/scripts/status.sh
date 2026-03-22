#!/bin/bash
# Quick status update helper
# Usage: ./scripts/status.sh "Project Name" <new status>

PROJECT_NAME="$1"
NEW_STATUS="$2"

if [[ -z "$PROJECT_NAME" || -z "$NEW_STATUS" ]]; then
  echo "Usage: $0 <Project Name> <new status>"
  echo ""
  echo "Common statuses:"
  echo "  backlog     - 未开始"
  echo "  in_progress - 进行中"
  echo "  done        - 已完成"
  echo "  archived    - 已归档"
  exit 1
fi

echo "Updating '$PROJECT_NAME' to status: $NEW_STATUS"

if command -v obsidian-cli &> /dev/null; then
  obsidian-cli frontmatter "$PROJECT_NAME" --edit --key "status" --value "$NEW_STATUS"
  echo ""
  echo "✅ Updated! Current frontmatter:"
  obsidian-cli frontmatter "$PROJECT_NAME" --print
else
  echo "❌ Error: obsidian-cli not found"
  echo "Install via: brew install yakitrak/yakitrak/obsidian-cli"
  echo "See references/SETUP.md for setup instructions"
  exit 1
fi
