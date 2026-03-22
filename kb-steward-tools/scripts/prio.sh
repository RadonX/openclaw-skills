#!/bin/bash
# List projects by priority
# Usage: ./scripts/prio.sh [P0|P1|P2|P3]

# Discover vault path automatically
VAULT_ROOT="$(obsidian-cli print-default 2>/dev/null | grep "Default vault path" | cut -d: -f2 | xargs)"

if [[ -z "$VAULT_ROOT" || ! -d "$VAULT_ROOT" ]]; then
  echo "❌ Error: Cannot find vault path"
  echo "Run 'obsidian-cli print-default' to verify configuration"
  echo "See references/SETUP.md for setup instructions"
  exit 1
fi

PRIO_FILTER="${1:-}"

if [[ -n "$PRIO_FILTER" ]]; then
  echo "🎯 Priority: $PRIO_FILTER"
  grep -l "prio: $PRIO_FILTER" "$VAULT_ROOT"/10-Projects/*.md 2>/dev/null | while read -r file; do
    basename "$file" .md | sed 's/^/  /'
  done
else
  echo "🎯 All projects by priority:"
  echo ""
  for prio in P0 P1 P2 P3; do
    count=$(grep -l "prio: $prio" "$VAULT_ROOT"/10-Projects/*.md 2>/dev/null | wc -l | tr -d ' ')
    if [[ $count -gt 0 ]]; then
      echo "$prio: $count projects"
      grep -l "prio: $prio" "$VAULT_ROOT"/10-Projects/*.md 2>/dev/null | while read -r file; do
        basename "$file" .md | sed 's/^/    /'
      done
      echo ""
    fi
  done
fi
