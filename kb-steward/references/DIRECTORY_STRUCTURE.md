# Directory Structure - Core Specification

## Overview

The `10-Projects/` directory uses **status-based layering** and **project aggregation** for better organization.

## Directory Structure

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

## File Naming Conventions

### Project Folders
- Use lowercase with hyphens: `clawport-skills`, `baoyu-skills-integration`
- Avoid spaces and special characters (except emoji in top-level folders)

### PROJECT.md
- Every project MUST have a `PROJECT.md` at its root
- Contains project metadata and task list
- Example:
```yaml
---
title: Project Name
status: active | done | backlog
prio: 1-3
tags: [area/category, source/source]
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

### Task Files
- Located in `tasks/` subdirectory
- Named with descriptive titles: `cost-dashboard.md`, `format-markdown.md`
- Frontmatter:
```yaml
---
title: Task Name
status: pending | doing | done
prio: 1-3
estimated: 1-2h
tags: [area/category]
---
```

## Status Flow

```
backlog → active → completed
   ↑        ↓         ↓
   └────────┴─────────┘
     (can move back at any time)
```

### Status Definitions

- **backlog**: Idea pool, not actively working on
  - `status: backlog` or file in `💭 backlog/`

- **active**: Currently being worked on
  - `status: active`
  - Located in `🔄 active/<project-name>/`

- **done**: Completed
  - `status: done`
  - Moved to `✅ completed/YYYY-MM/<project-name>/`

## Benefits

1. **Clear Status**: Easy to see what's active vs completed
2. **Project Hierarchy**: Related tasks grouped under project
3. **Better Navigation**: README.md files for quick overview
4. **Scalable**: Easy to add many projects without clutter
5. **Archive Friendly**: Completed projects auto-archived by month

## Migration Notes

### Old Structure

```
10-Projects/
├── some-project.md
├── another-project.md
└── ...
```

### New Structure

```
10-Projects/
├── 🔄 active/
│   ├── some-project/
│   │   ├── PROJECT.md
│   │   └── tasks/
│   └── another-project/
│       └── PROJECT.md
└── ✅ completed/
    └── ...
```

## References

- **kb-steward integration**: See `KB_STEWARD_EXTENSION.md`
- **kb-steward-tools integration**: See `../kb-steward-tools/references/TOOLS_EXTENSION.md`
- **Project management**: `kb/knowledge/project-management.md`
- **Frontmatter guide**: `references/FRONTMATTER.md`
