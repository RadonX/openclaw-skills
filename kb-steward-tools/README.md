# KB Steward Tools

**Query and maintenance tools for kb-steward managed vaults**

## Why install this skill?

`kb-steward` excels at ingesting and organizing content into your knowledge base. However, once your KB grows, you need tools to:

- **Find tasks**: "Show me all integration tasks"
- **Update status**: "Mark this project as done"
- **Browse by priority**: "What's my P0 backlog?"
- **Clean up**: "Delete this completed project"

This toolset provides those day-to-day maintenance utilities that `kb-steward` intentionally doesn't include.

## What this toolset provides

### Query tools
- Search tasks by tags (area/, type/, service/)
- Browse all tags in your vault
- View projects by priority level

### Maintenance tools
- Update project status via safe frontmatter operations
- Delete notes with automatic backup

## How it relates to kb-steward

`kb-steward` **writes** to your KB (ingests URLs, creates notes, manages taxonomy).

`kb-steward-tools` helps you **read and maintain** your KB (query tasks, update status, delete notes).

Think of it as: `kb-steward` is the writer; `kb-steward-tools` is the librarian.

## What you need before installing

1. **`kb-steward` skill** - This toolset extends kb-steward, not replaces it
2. **`obsidian-cli`** - Install via `brew install yakitrak/yakitrak/obsidian-cli`
3. **A kb-steward managed vault** - Run `kb-steward bootstrap --apply` if needed

See `references/SETUP.md` for complete setup instructions.

## Documentation for usage

- **`SKILL.md`**: Complete usage guide (when agents should use these tools)
- **`references/SETUP.md`**: First-time setup guide
- **`references/FRONTMATTER.md`**: Frontmatter operations reference

## Installation

Copy this skill to your OpenClaw skills directory. All scripts are self-contained and ready to use.
