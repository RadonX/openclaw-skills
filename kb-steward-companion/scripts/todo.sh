#!/bin/bash
# Enhanced todo list with tag filtering for Claw 3PO
# Usage:
#   ./tools/todo.sh              # Show all pending tasks
#   ./tools/todo.sh area/integration    # Filter by tag
#   ./tools/todo.sh type/done          # Filter by tag
#   ./tools/todo.sh --all              # Show all (including completed)

VAULT_ROOT="/Users/ruonan/.openclaw/shared/knowledge/claw-config"
FILTER_TAG="$1"
SHOW_ALL="${SHOW_ALL:-false}"

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
find "$VAULT_ROOT" -name "*.md" -type f | while read -r file; do
  # Check if file has the tag (if filtering)
  if [[ -n "$FILTER_TAG" ]]; then
    if ! grep -q "$FILTER_TAG" "$file" 2>/dev/null; then
      continue
    fi
  fi

  # Extract tasks
  grep "$PATTERN" "$file" 2>/dev/null | while read -r line; do
    # Format: remove path prefix, show relative path
    rel_path="${file#$VAULT_ROOT/}"
    # Extract checkbox status and task text
    if [[ "$line" =~ ^-\ \[([ x])\]\ (.*) ]]; then
      status="${BASH_REMATCH[1]}"
      text="${BASH_REMATCH[2]}"
      checkbox="[${status}]"
      echo "  $rel_path  $checkbox $text"
    fi
  done
done
