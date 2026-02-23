# Project Template

Standard template for creating new project notes in the knowledge base.

## Quick create

```bash
# Using obsidian-cli
obsidian-cli create "Project Name" --content '...content...'

# Or create manually in your vault
# Create new note → Paste template
```

See `SETUP.md` for obsidian-cli installation and configuration.

## Template

```yaml
---
title: "Project Name"
status: backlog
prio: P2
created: YYYY-MM-DD
due:
blocked_by:
related_docs:
tags:
  - area/category
  - type/category
---

# Goal

[Describe the objective in 1-2 sentences]

## Background

[Context and motivation - why this project exists]

## Tasks

- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Notes

[Progress updates, blockers, decisions, next steps]
```

## Field explanations

### Required fields
- **title**: Project name (should match filename)
- **status**: One of `backlog`, `in_progress`, `done`, `archived`
- **prio**: Priority level (`P0` = highest, `P3` = lowest)
- **created**: Creation date (YYYY-MM-DD format)
- **tags**: At least one `area/*` tag and optionally one `type/*` tag

### Optional fields
- **due**: Deadline date (YYYY-MM-DD format)
- **blocked_by**: What blocks this project (free text)
- **related_docs**: Array of links to related notes (`[[Note Name]]`)

## Tag selection guide

### area/* (domain categories)

Choose based on the project's domain:

| Domain | Tag |
|--------|-----|
| Third-party integrations | `area/integration` |
| Telegram bot/features | `area/telegram` |
| Knowledge management | `area/memory` |
| LLM model hosting | `area/model-serving` |
| Agent personality design | `area/agent-persona` |
| Skill development | `area/skills` |
| OpenClaw core platform | `area/openclaw` |
| Troubleshooting | `area/debugging` |
| Workflow automation | `area/workflow` |

### type/* (activity categories)

Choose based on what you're doing:

| Activity | Tag |
|----------|-----|
| Investigation/analysis | `type/research` |
| Building/implementing | `type/implementation` |
| Creating new agent/skill | `type/creation` |
| Automation scripts | `type/automation` |
| Refactoring existing code | `type/refactor` |
| Bug hunting | `type/bug-hunt` |

### service/* (specific services)

Add when the project relates to a specific service:
- Example: `service/gemini-local` for Gemini Local issues

## Examples

### Integration project
```yaml
---
title: "Integrate Example API"
status: backlog
prio: P1
created: 2026-02-05
tags:
  - area/integration
  - type/implementation
---

# Goal

Integrate Example API for feature X.
```

### Research project
```yaml
---
title: "Evaluate Agent Framework"
status: in_progress
prio: P2
created: 2026-02-10
tags:
  - area/competitor-analysis
  - type/research
---

# Goal

Compare Agent Framework vs alternatives.
```

### Bug fix project
```yaml
---
title: "Fix Service Authentication"
status: in_progress
prio: P0
created: 2026-02-10
tags:
  - area/debugging
  - area/model-serving
  - service/your-service
  - bug
---

# Goal

Fix authentication failure in service X.
```

## Tasks format

Use standard Markdown checkboxes:

```markdown
## Tasks

### Phase 1
- [ ] Subtask 1.1
- [ ] Subtask 1.2

### Phase 2
- [ ] Subtask 2.1
- [x] Completed task
```

The `scripts/todo.sh` tool parses these checkboxes for querying.
