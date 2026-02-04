---
name: handoff
description: Create a temporary handoff doc (and optional work log) in a shared Obsidian vault. Use when you need to transfer session state to a future human/agent, or when the user says "handoff", "交接", "接手", "handover".
compatibility: OpenClaw. Uses the shared Obsidian vault at `~/.openclaw/shared/`.
metadata:
  author: RadonX
  version: "1.2"
  openclaw:
    emoji: "🧷"
---

# handoff

This skill turns a chat session into **handoff documentation** stored in a shared Obsidian vault.

Doc types:

- **Temporary handoff** (primary): state transfer for the *next* person/agent.
- **Work log** (optional): detailed actions/commands/files touched.
- **Permanent docs** (optional, guarded): long-term procedures / architecture / debugging playbooks.

## Vault layout (shared)

Root: `~/.openclaw/shared/`

- Temporary: `shared/handoff/<project>/<YYYY-MM-DD>/...`
- Permanent: `shared/knowledge/<project>/...`

## Supported commands (v1)

This skill supports **exactly two user-facing forms**:

1) **Default**

- `/handoff <project> [--new|--update] [--log] [--name <base>] [--permanent <path>] [--apply]`

2) **Load (reserved, instructions-only)**

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

## Modes (default form)

### Default mode: temporary handoff

Goal: produce a *disposable* state-transfer doc for the next person.

- Prefer updating an existing relevant handoff file if one exists for the same project.
- If multiple candidates exist, ask the user which file to update.

### `--log` mode: work log

Also generate a `*_work_log.md` file (same base name), containing a more detailed record of actions.

### `--permanent <path>` mode: permanent doc update (guarded)

Update **only** the specified permanent doc with key long-term insights.

- If `<path>` is missing or ambiguous (e.g. user says “update the main doc”), propose likely doc paths and ask the user to confirm.
- Focus on:
  - procedures / architecture / debugging strategy
  - the evolution of understanding (wrong assumptions → what became clear)

`--apply` is required to actually write changes.

## `/handoff load` behavior (instructions-only, no implementation)

When the user invokes `/handoff load ...`, you MUST read and follow:

- `references/LOAD.md`

Hard rule: **read-only** (do not write/edit any files).

## Safety + correctness rules (must follow)

### 1) Confirm before writing

Before **any** `write` or `edit`, you MUST:
1) print the resolved absolute output path(s), and
2) ask the user to confirm.

### 2) Permanent docs: propose first

For any permanent doc creation/update:

- Read the target doc if it exists.
- Analyze its existing purpose/tone.
- Produce a **PROPOSED PATCH**.
- STOP and ask for explicit confirmation.

Only after confirmation (and `--apply`, if applicable) should you apply changes.

### 3) Communicate documentation strategy

If you move information from a temporary handoff into a permanent doc during this session:
- explicitly say *what moved* and *which permanent doc now contains it*.

### 4) Don’t invent state

When reporting status (tests, file creation, git state), do not claim something happened unless you verified it.

## Output requirements

### Temporary handoff doc (required)

Must include:

1) **Title**: `Project Handoff: <project>`
2) **Header note**: temporary / discard-after-use
3) **Key document links** (permanent docs). For each link, add 1 sentence on why it matters.
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

- Keep `SKILL.md` focused; put long references in `references/`.
- Prefer Obsidian-friendly relative links inside `shared/`.
