# Frontmatter Operations Guide

Complete reference for managing YAML frontmatter in project notes using `obsidian-cli`.

## Why obsidian-cli for frontmatter?

Compared to `sed`/`awk`:
- **Safer**: Structured YAML parsing, not regex
- **Clearer**: Explicit key-value operations
- **Cross-platform**: Works on Linux/macOS/Windows

## Basic operations

### Read frontmatter

```bash
obsidian-cli frontmatter "Project Name" --print
```

Example output:
```yaml
status: backlog
prio: P2
tags:
  - area/integration
  - type/implementation
```

### Update a field

```bash
obsidian-cli frontmatter "Project Name" --edit --key "status" --value "done"
```

Valid status values:
- `backlog` - Not started
- `in_progress` - Active work
- `done` - Completed
- `archived` - No longer relevant

### Delete a field

```bash
obsidian-cli frontmatter "Project Name" --delete --key "due"
```

### Add tags (append to array)

```bash
obsidian-cli frontmatter "Project Name" --edit --key "tags[]" --value "area/new-tag"
```

## Common frontmatter fields

```yaml
---
title: "Project Name"
status: backlog|in_progress|done|archived
prio: P0|P1|P2|P3
created: YYYY-MM-DD
due: YYYY-MM-DD
blocked_by:
related_docs:
  - "[[Related Note]]"
tags:
  - area/category
  - type/category
---
```

## Workflows

### Mark task complete

```bash
# 1. Find the project
scripts/todo.sh area/integration

# 2. Update status
scripts/status.sh "Project Name" done

# 3. Verify
obsidian-cli frontmatter "Project Name" --print
```

### Bulk status updates

```bash
# Find all P0 tasks
for proj in $(scripts/prio.sh P0 | tail -n +2); do
  scripts/status.sh "$proj" in_progress
done
```

### Clean up deprecated fields

```bash
# Remove 'blocked_by' from completed projects
grep -l "status: done" ~/path/to/10-Projects/*.md | while read -r file; do
  basename "$file" .md | xargs -I {} obsidian-cli frontmatter "{}" --delete --key "blocked_by"
done
```

### Delete notes

```bash
# Delete with backup
scripts/delete.sh "Project Name"

# Delete without backup
scripts/delete.sh "Project Name" --no-backup
```

The delete script:
1. Shows note details (title, status)
2. Asks for confirmation
3. Creates `.bak.md` backup (unless `--no-backup`)
4. Deletes the note

**Warning**: Related_doc links in other notes are NOT automatically updated. Manual cleanup may be needed.

## Troubleshooting

### "Cannot find note in vault"
- Check vault path: `obsidian-cli print-default`
- Verify note exists in vault
- Use partial name match (obsidian-cli is fuzzy)

### "obsidian-cli: command not found"
- Install via Homebrew: `brew install yakitrak/yakitrak/obsidian-cli`
- See `SETUP.md` for complete setup guide

### "Updated but no change visible"
- Frontmatter updates are atomic
- Check YAML syntax if manual edits were made
- Verify the note is in the default vault

### Tag array issues
- Use `tags[]` syntax to append
- Overwrite entire array with `tags` (no brackets)
- Arrays must be valid YAML lists
