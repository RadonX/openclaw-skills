# Directory Structure v2.0

## Overview

As of 2026-03-09, the `10-Projects/` directory has been restructured to support better organization and navigation.

## New Structure

```
10-Projects/
├── 🔄 active/                          # Active projects
│   ├── <project-name>/                 # Project folder
│   │   ├── PROJECT.md                  # Project overview (required)
│   │   ├── tasks/                      # Sub-tasks
│   │   │   ├── task-1.md
│   │   │   └── task-2.md
│   │   └── references/                 # Reference materials
│   │       └── ref-1.md
│   ├── README.md                       # Active projects index
│   └── ...
│
├── ✅ completed/                       # Completed projects
│   ├── YYYY-MM/                        # By completion date
│   │   ├── <project-name>/
│   │   │   ├── PROJECT.md              # Project overview (status: done)
│   │   │   ├── SUMMARY.md              # Optional summary
│   │   │   └── ...
│   │   └── README.md                   # Completed projects index
│   └── ...
│
├── 💭 backlog/                         # Backlog / idea pool
│   ├── future-ideas.md
│   └── ...
│
└── 📋 templates/                       # Project & task templates
    ├── project-template.md
    └── task-template.md
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
status: active | done
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

## Querying with kb-steward-tools

### Query Active Projects

```bash
# List all active projects
scripts/todo.sh --scope active

# List all pending tasks in active projects
scripts/todo.sh --scope active --status pending

# List high-priority active tasks
scripts/todo.sh --scope active --prio 1
```

### Query Completed Projects

```bash
# List completed projects this month
scripts/todo.sh --scope completed --month 2026-03

# List all done projects
scripts/todo.sh --status done
```

### Query Specific Project

```bash
# Show all tasks for a project
scripts/todo.sh --project clawport-skills

# Show project status
scripts/status.sh "clawport-skills" active
```

## Automated Scripts

### Create New Project

```bash
scripts/create-project.sh "My Project" "area/skills" 1
```
Creates:
```
🔄 active/my-project/
├── PROJECT.md
└── tasks/
```

### Create Task in Project

```bash
scripts/create-task.sh "clawport-skills" "Cost Dashboard" "2-3h" 1
```
Creates:
```
🔄 active/clawport-skills/tasks/cost-dashboard.md
```

### Complete Project

```bash
scripts/complete-project.sh "clawport-skills"
```
Moves project to `✅ completed/YYYY-MM/clawport-skills/` and updates status.

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

## Benefits

1. **Clear Status**: Easy to see what's active vs completed
2. **Project Hierarchy**: Related tasks grouped under project
3. **Better Navigation**: README.md files for quick overview
4. **Scalable**: Easy to add many projects without clutter
5. **Archive Friendly**: Completed projects auto-archived by month

## Updating Tools

All `kb-steward-tools` scripts have been updated to support the new structure:

- ✅ `todo.sh` - Supports `--scope` flag (active/completed/backlog)
- ✅ `status.sh` - Updates status and moves project if needed
- ✅ `prio.sh` - Filters by scope automatically
- ✅ `tags.sh` - Works across all scopes
- ✅ `delete.sh` - Works with new paths

## Backward Compatibility

The new structure is **backward compatible** with existing tools:

- Old path references still work (via symlinks or legacy support)
- `todo.sh` without `--scope` searches all directories
- Status updates work regardless of location

## See Also

- `README.md` in each directory for quick overview
- `📋 templates/` for starting new projects
- `references/FRONTMATTER.md` for frontmatter reference
