# kb-steward

Per-agent Obsidian-style knowledge base manager for OpenClaw.

## What it does

- **Auto-bootstrap**: creates folders + READMEs + templates on first use (never overwrites existing)
- **Intake**: turn URLs/snippets into properly formatted notes in the right folder
- **Taxonomy evolution**: new tags/fields are allowed, but must be recorded in a registry

## Quick start

```
# Add a task from a URL
/kb-steward add https://github.com/example/repo --kind project

# Add from pasted content
/kb-steward add --paste --kind research --title "Analysis of X"

# Check KB health (no changes)
/kb-steward doctor
```

## Folder structure

```
<agent workspace>/knowledge/
├── 00-Inbox/       # Unsorted items (triage later)
├── 10-Projects/    # Tasks, projects (task-as-a-file)
├── 20-Areas/       # Evergreen principles, constraints
├── 30-Research/    # Analysis, notes, comparisons
└── 99-Templates/   # Note skeletons
```

## Options

| Option | Description |
|--------|-------------|
| `--kind` | `project` (default), `research`, or `area` |
| `--title` | Override the note title |
| `--kb-root` | Custom KB path (default: `<workspace>/knowledge/`) |
| `--relate` | Link related notes (on by default) |
| `--ask` | Force confirmation before writing |

## Minimal output

Chat replies are just: **what changed + path**. Suggestions and next-steps live inside the note itself.
