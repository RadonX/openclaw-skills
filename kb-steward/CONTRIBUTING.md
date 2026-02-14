# Contributing to kb-steward

Guide for maintainers and contributors.

## Architecture

```
kb-steward/
├── SKILL.md              # AI-facing: interface, routing, guardrails
├── README.md             # User-facing: quick start
├── CONTRIBUTING.md       # Maintainer-facing: this file
├── references/
│   ├── WORKFLOW.md       # Step-by-step execution flow
│   ├── BOOTSTRAP.md      # Auto-bootstrap policy
│   ├── FRONTMATTER.md    # Note schema conventions
│   ├── SOURCES.md        # URL ingestion decision tree
│   ├── RELATEDNESS.md    # Related-doc linking rules
│   ├── SAFETY.md         # Safety constraints
│   └── HELP.md           # Help text for /kb-steward help
└── templates/
    ├── 00-Inbox/README.md
    ├── 10-Projects/README.md
    ├── 20-Areas/README.md
    ├── 30-Research/README.md
    └── 99-Templates/
        ├── README.md
        ├── Project.md
        ├── Area.md
        └── Research.md
```

## Design principles

1. **Additive-only bootstrap**: never overwrite user files; only create missing assets
2. **Read-before-write**: always sample existing notes before writing new ones
3. **Evolvable taxonomy**: new tags/fields OK if recorded in note + README registry
4. **Minimal chat noise**: path-only replies; suggestions inside the note
5. **Per-agent default**: KB root is `<workspace>/knowledge/` by design

## Key files

| File | Purpose | When to edit |
|------|---------|--------------|
| `SKILL.md` | AI reads this first; defines interface + routing | Adding commands, changing guardrails |
| `references/WORKFLOW.md` | Execution steps | Changing the intake flow |
| `references/FRONTMATTER.md` | Schema examples | Adding new frontmatter fields |
| `references/SOURCES.md` | URL → content decision tree | Adding new source types |
| `templates/*` | Bootstrap assets | Changing default folder structure |

## Common maintenance tasks

### Adding a new source type

1. Edit `references/SOURCES.md`
2. Add decision tree entry with: tool/command, fallback, what to extract

### Adding a new folder to bootstrap

1. Create `templates/<NN-FolderName>/README.md`
2. Update `references/BOOTSTRAP.md` asset list
3. Update `references/WORKFLOW.md` kind→folder mapping (if it's a new kind)

### Changing frontmatter schema

1. Edit `references/FRONTMATTER.md` with new baseline
2. Update corresponding template in `templates/99-Templates/`
3. **Do not** retroactively modify user notes; schema changes are forward-only

## Testing

No automated tests yet. Manual verification:

1. Remove a folder README, run `/kb-steward add <url>` — should recreate it
2. Add a note with `--relate` — should find and link related docs
3. Run `/kb-steward doctor` — should report missing assets without writing

## Commit style

Use conventional commits:
- `feat(kb-steward): ...` for new features
- `fix(kb-steward): ...` for bug fixes
- `docs(kb-steward): ...` for documentation only
