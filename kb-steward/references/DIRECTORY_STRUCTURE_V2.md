# Directory Structure v2.0 - KB Steward Compatibility

## Overview

As of 2026-03-09, the `10-Projects/` directory has been restructured to support better organization with **status-based layering** and **project aggregation**.

## New Structure (under 10-Projects/)

```
10-Projects/
├── 🔄 active/                          # Active projects
│   ├── <project-folder>/               # Project directory
│   │   ├── PROJECT.md                  # Project overview (required)
│   │   ├── tasks/                      # Sub-tasks directory
│   │   │   ├── task-1.md
│   │   │   └── task-2.md
│   │   └── references/                 # Reference materials
│   │       └── ref-1.md
│   └── README.md                       # Active projects index
│
├── ✅ completed/                       # Completed projects (archived)
│   ├── YYYY-MM/                        # By completion date
│   │   ├── <project-folder>/
│   │   │   ├── PROJECT.md              # (status: done)
│   │   │   ├── SUMMARY.md              # Optional
│   │   │   └── ...
│   │   └── README.md                   # Monthly index
│   └── ...
│
├── 💭 backlog/                         # Backlog / idea pool
│   ├── future-ideas.md
│   └── README.md
│
└── 📋 templates/                       # Project & task templates
    ├── project-template.md
    ├── task-template.md
    └── README.md
```

## Compatibility with kb-steward

### kb-steward operations

The new structure is **fully compatible** with kb-steward:

1. **`/kb-steward add --kind project`**:
   - Creates notes in `10-Projects/🔄 active/` by default
   - If project folder exists, adds to `tasks/` or `references/`
   - If creating a new project, creates project folder with `PROJECT.md`

2. **`/kb-steward doctor`**:
   - Checks for `PROJECT.md` in each project folder
   - Verifies `tasks/` and `references/` directories
   - Reports missing README.md files

3. **`/kb-steward bootstrap`**:
   - Creates missing directories (`🔄 active/`, `✅ completed/`, `💭 backlog/`, `📋 templates/`)
   - Creates README.md files for each directory
   - Does NOT overwrite existing files

### Folder detection

kb-steward auto-detects the new structure:

```javascript
// Pseudo-code for folder detection
if (folder.startsWith("🔄 active/")) {
  kind = "project";
  status = "active";
} else if (folder.startsWith("✅ completed/")) {
  kind = "project";
  status = "done";
} else if (folder.startsWith("💭 backlog/")) {
  kind = "project";
  status = "backlog";
}
```

## PROJECT.md frontmatter

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
---
```

### Status field meanings

- **active**: Currently being worked on (in `🔄 active/`)
- **done**: Completed (in `✅ completed/YYYY-MM/`)
- **backlog**: Not actively working on (in `💭 backlog/`)

## Task files (in tasks/)

Task files use simplified frontmatter:

```yaml
---
title: Task Name
status: pending | doing | done
prio: 1-3
estimated: 1-2h
tags:
  - area/category
---
```

## Workflow: Creating a new project

### Using kb-steward

```bash
/kb-steward add <url> --kind project --title "My Project"
```

**Behavior**:
1. Creates `10-Projects/🔄 active/my-project/`
2. Creates `PROJECT.md` with `status: active`
3. Ingests the URL content as `references/source-1.md`
4. Adds to `related_docs` in `PROJECT.md`

### Using kb-steward-tools

```bash
scripts/create-project.sh "My Project" "area/skills" 1
```

**Behavior**:
1. Creates project folder with `tasks/` and `references/`
2. Creates `PROJECT.md` from template
3. Creates `tasks/README.md` with instructions

## Workflow: Completing a project

### Manual process

1. Update `PROJECT.md` frontmatter: `status: done`
2. Add `completed: YYYY-MM-DD` field
3. Move entire project folder to `✅ completed/YYYY-MM/`

### Automated (future)

```bash
scripts/complete-project.sh "my-project"
```

**Behavior**:
1. Updates `status: done` in `PROJECT.md`
2. Adds `completed` date
3. Moves folder to `✅ completed/YYYY-MM/`
4. Updates monthly README

## Backward compatibility

The new structure is **backward compatible**:

1. **Old paths still work**:
   - Existing notes in `10-Projects/` root are still valid
   - kb-steward can read them

2. **Gradual migration**:
   - Old notes can be migrated gradually
   - No forced migration required

3. **kb-steward-tools support**:
   - `scripts/todo.sh` searches all directories by default
   - Use `--scope` to filter by status

## Bootstrap updates

### New bootstrap assets

kb-steward should create these assets when bootstrapping:

```
10-Projects/
├── 🔄 active/
│   └── README.md                    # "Active Projects"
├── ✅ completed/
│   └── README.md                    # "Completed Projects"
├── 💭 backlog/
│   └── README.md                    # "Backlog"
└── 📋 templates/
    ├── project-template.md
    ├── task-template.md
    └── README.md                    # "Templates"
```

### README.md content

**🔄 active/README.md**:
```markdown
# Active Projects

Projects currently being worked on.

Use `kb-steward add --kind project` to create a new project.

## Projects
<!-- Auto-generated list -->
```

**✅ completed/YYYY-MM/README.md**:
```markdown
# Completed Projects - YYYY-MM

Projects completed in this month.

## Projects
<!-- Auto-generated list -->
```

## Migration notes

### From v1 (flat) to v2 (layered)

**Old structure**:
```
10-Projects/
├── some-project.md
└── another-project.md
```

**New structure**:
```
10-Projects/
├── 🔄 active/
│   ├── some-project/
│   │   └── PROJECT.md
│   └── another-project/
│       └── PROJECT.md
└── ✅ completed/
    └── ...
```

### Auto-migration (optional)

kb-steward could offer an auto-migration command:

```bash
/kb-steward migrate-projects --apply
```

**Behavior**:
1. Scans `10-Projects/` for standalone `.md` files
2. Creates project folders in `🔄 active/` or `✅ completed/`
3. Moves files to `references/`
4. Creates `PROJECT.md` with metadata

## References

- **kb-steward-tools**: `../kb-steward-tools/references/DIRECTORY_STRUCTURE_V2.md`
- **Project management**: `kb/knowledge/project-management.md`
- **Frontmatter guide**: `references/FRONTMATTER.md`
