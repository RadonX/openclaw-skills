#!/bin/bash
# List projects by priority
# Usage: ./scripts/prio.sh [P0|P1|P2|P3]

PRIO_FILTER="${1:-}"
VAULT_ROOT="/Users/ruonan/.openclaw/shared/knowledge/claw-config"

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
