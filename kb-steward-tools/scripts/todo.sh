#!/bin/bash
# Query tasks by tag
# Usage: ./scripts/todo.sh [tag] [--all]

# Discover vault path automatically
VAULT_ROOT="/Users/ruonan/.openclaw/workspace-pensieve/kb"

if [[ -z "$VAULT_ROOT" || ! -d "$VAULT_ROOT" ]]; then
  echo "❌ Error: Cannot find vault path"
  echo "Run 'obsidian-cli print-default' to verify configuration"
  echo "See references/SETUP.md for setup instructions"
  exit 1
fi

FILTER_TAG="$1"
SHOW_ALL="false"

# Parse flags
if [[ "$1" == "--all" ]]; then
  SHOW_ALL="true"
  shift
  FILTER_TAG="$1"
fi

if [[ "$SHOW_ALL" == "true" ]]; then
  PATTERN="^- \\[."
else
  PATTERN="^- \\[ \\]"
fi

echo "📋 Pending Tasks"
if [[ -n "$FILTER_TAG" ]]; then
  echo "🏷️  Filter: $FILTER_TAG"
fi
echo ""

# Find tasks, optionally filtered by tag
find "$VAULT_ROOT" -name "*.md" -type f 2>/dev/null | while read -r file; do
  # Check if file has the tag (if filtering)
  if [[ -n "$FILTER_TAG" ]]; then
    if ! grep -q "$FILTER_TAG" "$file" 2>/dev/null; then
      continue
    fi
  fi

  # Extract tasks
  grep "$PATTERN" "$file" 2>/dev/null | while read -r line; do
    rel_path="${file#$VAULT_ROOT/}"
    if [[ "$line" =~ ^-\ \[([ x])\]\ (.*) ]]; then
      status="${BASH_REMATCH[1]}"
      text="${BASH_REMATCH[2]}"
      checkbox="[${status}]"
      echo "  $rel_path  $checkbox $text"
    fi
  done
done
