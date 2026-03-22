#!/bin/bash
# Delete a note from the vault (with backup)
# Usage: ./scripts/delete.sh <note-name> [--no-backup]

NOTE_NAME="$1"
NO_BACKUP="${2:-}"

if [[ -z "$NOTE_NAME" ]]; then
  echo "Usage: $0 <note-name> [--no-backup]"
  echo ""
  echo "Examples:"
  echo "  $0 \"My Project\""
  echo "  $0 \"Old Research\" --no-backup"
  echo ""
  echo "⚠️  This will:"
  echo "  1. Create a .bak backup (unless --no-backup)"
  echo "  2. Delete the note from the vault"
  echo "  3. Update any related_doc links in other notes (NOT YET IMPLEMENTED)"
  exit 1
fi

# Discover vault path
VAULT_ROOT="$(obsidian-cli print-default 2>/dev/null | grep "Default vault path" | cut -d: -f2 | xargs)"

if [[ -z "$VAULT_ROOT" || ! -d "$VAULT_ROOT" ]]; then
  echo "❌ Error: Cannot find vault path"
  echo "Run 'obsidian-cli print-default' to verify configuration"
  exit 1
fi

# Find the note (obsidian-cli fuzzy search)
NOTE_PATH="$VAULT_ROOT/$NOTE_NAME.md"

if [[ ! -f "$NOTE_PATH" ]]; then
  echo "❌ Error: Note not found: $NOTE_PATH"
  echo ""
  echo "Searching for similar notes..."
  find "$VAULT_ROOT" -name "*$NOTE_NAME*.md" -type f | head -5
  exit 1
fi

# Show what will be deleted
echo "📄 Note to delete:"
echo "   Path: $NOTE_PATH"
echo "   Title: $(grep "^title:" "$NOTE_PATH" 2>/dev/null || echo "N/A")"
echo "   Status: $(grep "^status:" "$NOTE_PATH" 2>/dev/null || echo "N/A")"
echo ""

# Confirm deletion
read -p "❓ Confirm deletion? [y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "❌ Cancelled"
  exit 0
fi

# Backup (unless --no-backup)
if [[ "$NO_BACKUP" != "--no-backup" ]]; then
  BACKUP_PATH="${NOTE_PATH%.md}.bak.md"
  cp "$NOTE_PATH" "$BACKUP_PATH"
  echo "✅ Backup created: $BACKUP_PATH"
fi

# Delete
rm "$NOTE_PATH"
echo "✅ Deleted: $NOTE_PATH"
echo ""
echo "📝 Note: Related_doc links in other notes are NOT automatically updated."
echo "   This is a known limitation. Manual cleanup may be needed."
