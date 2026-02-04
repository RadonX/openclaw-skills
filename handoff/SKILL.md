---
name: handoff
description: Create a temporary handoff doc (and optional work log) in a shared Obsidian vault. Use when you need to transfer session state to a future human/agent, or when the user says "handoff", "交接", "接手", "handover".
compatibility: OpenClaw. Writes to /Users/ruonan/.openclaw/shared/ (Obsidian vault).
metadata:
  author: RadonX
  version: "1.1"
  openclaw:
    emoji: "🧷"
---

# handoff

This skill turns a chat session into **handoff documentation** stored in a shared Obsidian vault.

Two doc types:

- **Temporary handoff** (primary): state transfer for the *next* person/agent.
- **Work log** (optional): detailed actions/commands/files touched.

## Vault layout (shared)

Root: `/Users/ruonan/.openclaw/shared/`

- Temporary: `shared/handoff/<project>/<YYYY-MM-DD>/...`
- Permanent: `shared/knowledge/<project>/...`

## Supported commands (v1)

This skill supports **exactly two** forms:

1) **Default**

- `/handoff <project> [--new|--update] [--log] [--name <base>]`

2) **Load (reserved, not implemented yet)**

- `/handoff load <project> [--date YYYY-MM-DD]`

### Subcommand parsing rules (hard)

- Interpret the first token after `/handoff` as either:
  - the literal subcommand `load`, or
  - `<project>` (default mode).
- Only `load` is recognized as a subcommand in v1.
- Any other subcommand-like token (e.g. `integrity`, `list`, `help`, `handoff:load`) is **unsupported**.
  - Explain it’s unsupported.
  - Show the two supported forms.
  - Ask the user to restate.

### `/handoff load` current behavior (v1)

`load` is **instructions-only** in v1.

- When the user invokes `/handoff load ...`, you MUST read and follow:
  - `references/LOAD.md`
- `load` is **read-only**: do not write/edit any files.
- If the instructions are ambiguous for the user’s intent, ask a clarifying question.

## Safety + correctness rules (must follow)

### 1) Confirm before writing
Before **any** `write` or `edit`, you MUST:
1) print the resolved absolute output path(s), and
2) ask the user to confirm.

### 2) Permanent docs: propose first
If the user requests updating a permanent doc (`shared/knowledge/...` or another target):

- Read the target doc if it exists.
- Analyze its existing purpose/tone.
- Produce a **PROPOSED PATCH**.
- STOP and ask for explicit confirmation.

Only after confirmation should you apply changes.

### 3) Don’t “invent state”
When reporting status (tests, file creation, git state), do not claim something happened unless you verified it.

## Output requirements

### Temporary handoff doc (required in default mode)

Must include:

1) **Title**: `Project Handoff: <project>`
2) **Header note**: temporary/discard-after-use
3) **Key document links** (to permanent docs). For each link, add 1 sentence on why it matters.
4) **Session goal**
5) **Work done** (concise)
6) **Current status** (artifact/knowledge state, not action list)
7) **Next steps** (actionable)
8) If `--log`: link to the work log file

Must start with YAML for indexing:

```yaml
---
type: handoff
temporary: true
project: <project>
date: <YYYY-MM-DD>
created_at: <ISO8601>
author: <agentId>
session: <sessionKey if available>
---
```

### Work log doc (only with `--log`)

- Commands executed + key outputs
- Files read/modified + summary
- Hypotheses/decisions/errors
- Avoid duplicating overview/goal/status/next steps

## Implementation notes

- Keep `SKILL.md` focused; put long references in `references/` if needed.
- Prefer Obsidian-friendly relative links inside `shared/`.
