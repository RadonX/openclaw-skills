# KB Steward Tools

**Query and maintenance tools for kb-steward managed vaults**

## Why install this skill?

`kb-steward` excels at ingesting and organizing content into your knowledge base. However, once your KB grows, you need tools to:

- **Find tasks**: "Show me all integration tasks"
- **Update status**: "Mark this project as done"
- **Browse by priority**: "What's my P0 backlog?"
- **Clean up**: "Delete this completed project"

This toolset provides those day-to-day maintenance utilities that `kb-steward` intentionally doesn't include.

## How it works

`kb-steward` writes to your KB; `kb-steward-tools` helps you read and maintain it.

The scripts use `obsidian-cli` for safe frontmatter operations (better than raw `sed`/`grep`).

## Prerequisites

1. **`kb-steward` skill** - This toolset extends kb-steward, not replaces it
2. **`obsidian-cli`** - Install via `brew install yakitrak/yakitrak/obsidian-cli`
3. **kb-steward vault structure** - Run `kb-steward bootstrap --apply` if needed

See `references/SETUP.md` for complete setup.

## Quick examples

```bash
# Find all integration tasks
scripts/todo.sh area/integration

# Mark a project complete
scripts/status.sh "Project Name" done

# What's P0?
scripts/prio.sh P0

# Browse tags
scripts/tags.sh area
```

## Scope

This toolset provides **query and maintenance** utilities. It does NOT:
- Ingest new content (use `kb-steward add`)
- Create folders (use `kb-steward bootstrap`)
- Manage taxonomy (use `kb-steward`'s registry)

## Installation

Copy this skill to your OpenClaw skills directory. All scripts are self-contained.

## Documentation

- **`SKILL.md`**: Agent documentation (when/how scripts are used)
- **`references/SETUP.md`**: First-time setup guide
- **`references/FRONTMATTER.md`**: Complete frontmatter operations guide
