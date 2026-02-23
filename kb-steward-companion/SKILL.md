---
name: kb-steward-tools
description: Query and maintenance utilities for kb-steward managed Obsidian vaults. Use when: (1) Searching tasks by tags in 10-Projects/, (2) Updating project status in frontmatter, (3) Browsing tag taxonomy established by kb-steward, (4) Viewing projects by priority, (5) Deleting notes with backup. This is a toolset for kb-steward: kb-steward writes/ingests, these tools query/maintain.
---

# KB Steward Tools

Query and maintenance tools for Obsidian vaults managed by `kb-steward`.

## Relationship to kb-steward

**kb-steward** (primary skill): Ingests URLs/snippets into knowledge base with proper frontmatter and taxonomy.

**kb-steward-tools** (this skill): Provides utilities to query, update status, and browse the knowledge base.

Use `kb-steward` to add content; use these tools to maintain and query it.

## Prerequisites

Before using this skill, ensure `obsidian-cli` is installed. If not, follow `references/SETUP.md`.

Your vault should follow the `kb-steward` folder structure:
- `10-Projects/` - Task notes (queried by these tools)
- `20-Areas/` - Durable principles
- `30-Research/` - Analysis and notes

## Interface

```bash
# Query tasks in 10-Projects/
scripts/todo.sh [tag]

# Browse tags (dynamically discovered from vault)
scripts/tags.sh [category]

# Update project status
scripts/status.sh <project> <status>

# View projects by priority
scripts/prio.sh [P0-P3]

# Delete a note (with backup)
scripts/delete.sh <note-name> [--no-backup]
```

## Which references to read

- If user asks about frontmatter: read `references/FRONTMATTER.md`
- If user asks about creating projects: read `references/PROJECT_TEMPLATE.md`
- First-time setup: read `references/SETUP.md`

Tags are discovered dynamically via `scripts/tags.sh` - no static reference needed.

## Global guardrails

- Never modify frontmatter without explicit user confirmation
- Always show full `obsidian-cli` command before execution
- Use `~` paths in all documentation
- Verify vault configuration before operations
- Do NOT create new folders (use `kb-steward bootstrap` for that)
- Do NOT ingest new content (use `kb-steward add` for that)

## Tag categories (from kb-steward taxonomy)

These tools use the same tag hierarchy that `kb-steward` establishes:

- **area/**: Domain categories (integration, telegram, memory, model-serving, etc.)
- **type/**: Task types (research, implementation, creation, done, etc.)
- **service/**: Specific services (gemini-local, etc.)

Run `scripts/tags.sh` to discover all tags in your vault.

## Common workflows

### Search tasks by tag

```bash
# Query 10-Projects/ by area
scripts/todo.sh area/integration
scripts/todo.sh type/research
scripts/todo.sh service/gemini-local
```

### Update project status

```bash
# Update status in frontmatter
scripts/status.sh "Project Name" done
```

Valid statuses: `backlog`, `in_progress`, `done`, `archived`

### View by priority

```bash
# Filter Projects by priority level
scripts/prio.sh P0
scripts/prio.sh P1
```

### Delete a note

```bash
# Delete with backup
scripts/delete.sh "Project Name"

# Delete without backup
scripts/delete.sh "Project Name" --no-backup
```

The delete script creates a `.bak.md` backup before deletion.

## Frontmatter operations (via obsidian-cli)

```bash
# Read project frontmatter
obsidian-cli frontmatter "Project Name" --print

# Update status field
obsidian-cli frontmatter "Project Name" --edit --key "status" --value "done"

# Delete field
obsidian-cli frontmatter "Project Name" --delete --key "due"
```

See `references/FRONTMATTER.md` for complete guide.

## Configuration

The skill automatically discovers your Obsidian vault:

- Checks `obsidian-cli print-default` for current vault
- Expects `kb-steward` folder structure (10-Projects/, 20-Areas/, 30-Research/)
- Uses `~/Library/Application Support/obsidian-cli/` or `~/.config/obsidian-cli/` for config

No manual configuration needed if `obsidian-cli` is properly set up.

## Scope boundaries

### These tools DO:
- ✅ Query notes in `10-Projects/`
- ✅ Update frontmatter (status, prio, tags)
- ✅ Browse tag taxonomy
- ✅ Delete notes with backup

### These tools do NOT:
- ❌ Ingest new URLs (use `kb-steward add`)
- ❌ Create folders (use `kb-steward bootstrap`)
- ❌ Bootstrap new vault (use `kb-steward bootstrap --apply`)
