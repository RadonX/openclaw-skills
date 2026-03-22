#!/bin/bash

# tag.sh - Manage tags in the YAML frontmatter of a markdown file.
# Requires 'yq' (https://github.com/mikefarah/yq)

set -e

usage() {
  echo "Usage: $(basename "$0") <file> [--add <tag>...] | [--remove <tag>...] | [--list]"
  echo "Manages the 'tags' array in a file's YAML frontmatter."
  echo ""
  echo "Actions:"
  echo "  --add <tag>...    Add one or more tags. Ensures uniqueness."
  echo "  --remove <tag>... Remove one or more tags."
  echo "  --list            (Default) List current tags in YAML format."
  exit 1
}

# --- Dependency Check ---
if ! command -v yq &> /dev/null; then
  echo "Error: 'yq' command not found. This script requires yq." >&2
  echo "On macOS, install with: brew install yq" >&2
  exit 127
fi

# --- Argument Parsing ---
if [[ $# -lt 1 || "$1" == "--help" || "$1" == "-h" ]]; then
  usage
fi

FILE="$1"
if [[ ! -f "$FILE" ]]; then
  echo "Error: File not found: $FILE" >&2
  exit 1
fi
shift

ACTION=${1:---list}
# If the first arg wasn't an action, it's a tag for the default action.
# This part is tricky. Let's simplify and require the action.
if [[ "$ACTION" != "--add" && "$ACTION" != "--remove" && "$ACTION" != "--list" ]]; then
    # Reset for default action if no valid action was specified
    ACTION="--list"
else
    shift
fi


case "$ACTION" in
  --add)
    if [ $# -eq 0 ]; then echo "Error: --add requires at least one tag." >&2; usage; fi
    for tag in "$@"; do
      # Safely add a tag. `// []` creates the 'tags' key if it's null. `unique` prevents duplicates.
      yq eval -i ".tags = (.tags // [] | . + [\"$tag\"] | unique)" "$FILE"
    done
    echo "Updated tags for: $(basename "$FILE")"
    ;;

  --remove)
    if [ $# -eq 0 ]; then echo "Error: --remove requires at least one tag." >&2; usage; fi
    for tag in "$@"; do
      # Safely remove a tag if it exists.
      yq eval -i "del(.tags[] | select(. == \"$tag\"))" "$FILE"
    done
    echo "Updated tags for: $(basename "$FILE")"
    ;;

  --list)
    yq eval '.tags' "$FILE"
    ;;

  *)
    echo "Error: Unknown action '$ACTION'" >&2
    usage
    ;;
esac
