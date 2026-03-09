# Directory Structure - kb-steward Integration

## Extension of Core Specification

This document extends `DIRECTORY_STRUCTURE.md` with kb-steward-specific behavior.

## kb-steward Operations

### `/kb-steward add --kind project`

**Behavior**:
1. Creates `10-Projects/🔄 active/<project-folder>/`
2. Creates `PROJECT.md` with `status: active`
3. Creates `tasks/` and `references/` subdirectories
4. Ingests URL/paste content to `references/source-1.md`
5. Adds source to `related_docs` in `PROJECT.md`

**Example**:
```bash
/kb-steward add https://example.com --kind project --title "My Project"
```

**Creates**:
```
10-Projects/🔄 active/my-project/
├── PROJECT.md                          # status: active
├── tasks/                              # empty
└── references/
    └── source-1.md                     # ingested content
```

### `/kb-steward doctor`

**Checks**:
- ✅ Each project in `🔄 active/` has `PROJECT.md`
- ✅ Each project has `tasks/` and `references/` directories
- ✅ `PROJECT.md` frontmatter has valid `status` field
- ✅ Top-level directories have `README.md`

**Report example**:
```
✅ clawport-skills: PROJECT.md found, tasks/ exists
❌ missing-project: PROJECT.md not found
⚠️  old-project: missing tasks/ directory
```

### `/kb-steward bootstrap --apply`

**Creates** (if missing):
```
10-Projects/
├── 🔄 active/
│   └── README.md
├── ✅ completed/
│   └── README.md
├── 💭 backlog/
│   └── README.md
└── 📋 templates/
    ├── project-template.md
    ├── task-template.md
    └── README.md
```

**Rules**:
- Never overwrite existing files
- Only append to registries, never replace
- Ask before creating top-level directories

## PROJECT.md Frontmatter (kb-steward)

### Required fields

```yaml
---
title: Project Name
status: active | done | backlog
prio: 1-3
tags:
  - area/category
  - source/source
created: YYYY-MM-DD
updated: YYYY-MM-DD
related_docs:
  - 'references/source-1.md'
---
```

### Status field meanings

- **active**: Currently being worked on
- **done**: Completed (move to `✅ completed/YYYY-MM/`)
- **backlog**: Not actively working on

## Workflow Examples

### Creating a new project

```bash
/kb-steward add <url> --kind project --title "My Project"
```

**Result**:
- Project folder created
- PROJECT.md with `status: active`
- URL content ingested to `references/`

### Adding to existing project

```bash
/kb-steward add <url> --kind project --title "My Project" --relate
```

**Result**:
- New reference added to `references/`
- PROJECT.md `related_docs` updated

## Auto-Bootstrap Behavior

When `add` is called, kb-steward implicitly runs auto-bootstrap:

1. Checks for `🔄 active/`, `✅ completed/`, `💭 backlog/`, `📋 templates/`
2. Creates missing directories
3. Creates missing README.md files
4. Never overwrites existing content

## Backward Compatibility

### Old paths still work

- Existing notes in `10-Projects/` root are still valid
- kb-steward can read and update them
- No forced migration required

### Gradual migration

- New projects use v2.0 structure automatically
- Old projects can be migrated manually or via tool
- Both structures coexist during transition

## See Also

- **Core specification**: `DIRECTORY_STRUCTURE.md`
- **Frontmatter guide**: `references/FRONTMATTER.md`
- **Bootstrap policy**: `references/BOOTSTRAP.md`
- **Workflow**: `references/WORKFLOW.md`
