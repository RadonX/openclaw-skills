#!/bin/bash
# Tag browser for Claw 3PO knowledge base
# Usage: ./tools/tags.sh [area|type|service]  # List all tags in category

VAULT_ROOT="/Users/ruonan/.openclaw/shared/knowledge/claw-config"

CATEGORY="$1"

if [[ -n "$CATEGORY" ]]; then
  echo "🏷️  Tags in category: $CATEGORY"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A5 | grep "  - $CATEGORY/" | sort -u
else
  echo "🏷️  All tag categories:"
  echo ""
  echo "📍 area/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 | grep "  - area/" | sed 's/.*area/  area/' | sort -u
  echo ""
  echo "📦 type/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 | grep "  - type/" | sed 's/.*type/  type/' | sort -u
  echo ""
  echo "🔧 service/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 | grep "  - service/" | sed 's/.*service/  service/' | sort -u
fi
