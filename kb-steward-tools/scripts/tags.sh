#!/bin/bash
# Tag browser for KB vault
# Usage: ./scripts/tags.sh [area|type|service|all]

# Discover vault path automatically
VAULT_ROOT="$(obsidian-cli print-default 2>/dev/null | grep "Default vault path" | cut -d: -f2 | xargs)"

if [[ -z "$VAULT_ROOT" || ! -d "$VAULT_ROOT" ]]; then
  echo "❌ Error: Cannot find vault path"
  echo "Run 'obsidian-cli print-default' to verify configuration"
  echo "See references/SETUP.md for setup instructions"
  exit 1
fi

CATEGORY="$1"

if [[ -n "$CATEGORY" && "$CATEGORY" != "all" ]]; then
  echo "🏷️  Tags in category: $CATEGORY"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 2>/dev/null | grep "  - $CATEGORY/" | sort -u
else
  echo "🏷️  All tag categories (discovered from vault):"
  echo ""

  echo "📍 area/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 2>/dev/null | grep "  - area/" | sed 's/.*area/  area/' | sort -u
  echo ""

  echo "📦 type/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 2>/dev/null | grep "  - type/" | sed 's/.*type/  type/' | sort -u
  echo ""

  echo "🔧 service/:"
  grep "^tags:" "$VAULT_ROOT"/10-Projects/*.md -A10 2>/dev/null | grep "  - service/" | sed 's/.*service/  service/' | sort -u
fi
