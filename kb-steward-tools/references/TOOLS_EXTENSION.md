# Directory Structure - kb-steward-tools Integration

## Extension of Core Specification

This document extends `../kb-steward/references/DIRECTORY_STRUCTURE.md` with kb-steward-tools-specific behavior.

## Tool Operations

### Querying Projects

```bash
# List all active projects
scripts/todo.sh --scope active

# List all pending tasks in active projects
scripts/todo.sh --scope active --status pending

# List high-priority active tasks
scripts/todo.sh --scope active --prio 1
```

### Project Management

```bash
# Create new project
scripts/create-project.sh "My Project" "area/skills" 1

# Create task in project
scripts/create-task.sh "my-project" "Task Name" "2-3h" 1

# Complete project (moves to completed/)
scripts/complete-project.sh "my-project"

# Update project status
scripts/status.sh "my-project" done
```

## Directory Detection

Tools auto-detect project status from directory path:

```bash
# Pseudo-code
if path =~ /🔄 active/:
  scope = "active"
elif path =~ /✅ completed/:
  scope = "completed"
elif path =~ /💭 backlog/:
  scope = "backlog"
```

## Output Formats

### todo.sh output

```
📋 Active Projects (3)

[clawport-skills] P1 ⚙️
  ├─ [pending] Cost Dashboard (2-3h)
  ├─ [pending] Cron Monitor (1-2h)
  └─ [pending] Org Map (2-3h)

[baoyu-skills-integration] P2 📝
  └─ [pending] format-markdown (50m)

[b3ehive-poc] P2 🧪
  └─ [pending] Installation (30m)
```

### status.sh behavior

When updating status:
- `status: done` → moves project to `✅ completed/YYYY-MM/`
- `status: active` → moves project to `🔄 active/`
- `status: backlog` → moves project to `💭 backlog/`

## Shared Utilities

### create-project.sh

**Usage**:
```bash
scripts/create-project.sh "Project Name" "area/category" [priority]
```

**Creates**:
```
🔄 active/<project-folder>/
├── PROJECT.md
├── tasks/
│   └── README.md
└── references/
```

### create-task.sh (future)

**Usage**:
```bash
scripts/create-task.sh "project-folder" "Task Name" "estimated" [priority]
```

**Creates**:
```
🔄 active/<project-folder>/tasks/<task-name>.md
```

### complete-project.sh (future)

**Usage**:
```bash
scripts/complete-project.sh "project-folder"
```

**Does**:
1. Updates `PROJECT.md`: `status: done`, `completed: YYYY-MM-DD`
2. Moves folder to `✅ completed/YYYY-MM/`
3. Updates monthly README

## Workflow Examples

### Create project → Add tasks → Complete

```bash
# 1. Create project
scripts/create-project.sh "ClawPort Skills" "area/skills" 1

# 2. Add tasks
scripts/create-task.sh "clawport-skills" "Cost Dashboard" "2-3h" 1
scripts/create-task.sh "clawport-skills" "Cron Monitor" "1-2h" 1

# 3. Complete project
scripts/complete-project.sh "clawport-skills"
```

### Query by scope

```bash
# Active projects only
scripts/todo.sh --scope active

# Completed this month
scripts/todo.sh --scope completed --month 2026-03

# High priority
scripts/prio.sh 1 --scope active
```

## Backward Compatibility

### Old paths supported

```bash
# Searches all directories by default
scripts/todo.sh

# Explicit scope
scripts/todo.sh --scope all
```

### Migration helper

```bash
# Migrate old projects to new structure
scripts/migrate-projects.sh --dry-run
scripts/migrate-projects.sh --apply
```

## See Also

- **Core specification**: `../kb-steward/references/DIRECTORY_STRUCTURE.md`
- **Tool usage**: `SKILL.md`
- **Frontmatter**: `references/FRONTMATTER.md`
- **Project creation**: `scripts/create-project.sh`
