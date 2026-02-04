---
name: handoff
description: Create handoff documentation (temporary state transfer + optional work log) in a shared Obsidian vault. Use when you need to hand work to a future human/agent, or when the user says "handoff", "交接", "接手", "handover".
compatibility: OpenClaw. Uses the shared Obsidian vault at `~/.openclaw/shared/`.
metadata:
  author: RadonX
  version: "2.0"
  openclaw:
    emoji: "🧷"
---

# handoff

This skill turns a chat session into **handoff documentation** stored in a shared Obsidian vault.

Doc types:

- **Temporary handoff** (primary): state transfer for the *next* person/agent.
- **Work log** (optional): a detailed record of actions/commands/files touched.
- **Knowledge docs** (optional): long-term procedures / architecture / debugging playbooks (guarded).

## Vault layout (shared)

Root: `~/.openclaw/shared/`

- Temporary: `shared/handoff/<project>/<YYYY-MM-DD>/...`
- Knowledge: `shared/knowledge/<project>/...`

## Command interface (v2)

This skill is intentionally designed like a small CLI:

### A) Smart default (AI decides new vs update)

```
/handoff <project> [--log] [--name <base>] [--ask]
```

Behavior:

- AI decides whether to **create a new** handoff or **update an existing** one.
- AI should ask the user *only when it cannot make a high-confidence choice*.

### B) Subcommands

```
/handoff load <project> [--date YYYY-MM-DD]
/handoff know <project> [--target <path>] [--apply] [--ask]
```

Notes:
- `load` is **read-only** (navigation).
- `know` is for **knowledge-base maintenance** (guarded, propose-first).

### Parsing rules (hard)

- The first token after `/handoff` is either:
  - `<project>` (smart default), or
  - the literal subcommand `load`, or
  - the literal subcommand `know`.
- Any other subcommand-like token is unsupported. Show usage and ask the user to restate.

## Smart default decision policy (new vs update)

Goal: minimize user interaction while staying correct.

When invoked as `/handoff <project> ...`:

1) Determine candidate existing handoffs for this project (read-only):
   - Prefer `shared/handoff/<project>/INDEX.md` if present.
   - Otherwise scan `shared/handoff/<project>/` for date folders, newest first.

2) Choose **update** when there is a clear best existing target:
   - If INDEX.md names a single "current" handoff → update that.
   - Else if the newest date folder contains exactly one `*_handoff.md` → update that.

3) Choose **new** when there is no suitable target.

4) If multiple plausible update targets exist (ambiguity):
   - If `--ask` is present: ask the user to pick.
   - Otherwise: pick deterministically (newest `*_handoff.md` by mtime), and state the choice + rationale.

## `--ask` flag

`--ask` forces interactive confirmation (more prompts, more safety).

Without `--ask`, the skill should keep interaction minimal **but must still be explicit** about what it is going to write.

## `/handoff load` (instructions-only, no implementation)

When the user invokes `/handoff load ...`, you MUST read and follow:

- `references/LOAD.md`

Hard rule: **read-only** (do not write/edit any files).

## `/handoff know` (knowledge-base maintenance)

Purpose: maintain long-term docs under `shared/knowledge/<project>/`.

This mode is inspired by the “permanent documentation” principles:

- Capture procedures / architecture / debugging strategy.
- Focus on evolution of understanding: wrong assumptions → what became clear.

### Guardrails (must follow)

- If the target doc path is ambiguous, propose candidates and ask for confirmation.
- You MUST propose changes first (see below). Only apply with explicit confirmation and `--apply`.

## Safety + correctness rules (Gemini handoff essentials)

These are the distilled “non-negotiables” from the original Gemini handoff command.

### 1) Handle ambiguous doc references

If the user asks to update "the main doc" / "the triage doc" / similar ambiguous references:

- Acknowledge ambiguity.
- Propose the most likely file path(s).
- Ask the user to confirm the target.

### 2) Confirm before writing (minimal-interaction version)

- Always print the resolved absolute output path(s) you intend to write.
- If `--ask` is present, you MUST ask the user to confirm before writing.
- If `--ask` is NOT present, you may proceed without a question **only when**:
  - you are creating a new file (not overwriting), and
  - you have printed the path(s) you will write.

### 3) Knowledge docs: propose first (CRITICAL)

Before creating/updating knowledge docs:

- Read the target doc if it exists.
- Analyze its existing purpose/tone.
- Produce a **PROPOSED PATCH**.
- STOP and ask for explicit confirmation.

Only after confirmation (and `--apply`) should you apply changes.

### 4) Communicate documentation strategy

If you move information from a temporary handoff into a knowledge doc:

- Explicitly state *what moved* and *where it now lives*.

### 5) Don’t invent state

Do not claim tests/file writes/git actions occurred unless verified.

## Output contracts

### Temporary handoff doc (required in smart default mode)

Must include:

1) Title: `Project Handoff: <project>`
2) Header note: temporary / discard-after-use
3) Key document links (knowledge docs). For each link, 1 sentence on utility.
4) Session goal
5) Work done (concise)
6) Current status (artifact/knowledge state, not action list)
7) Next steps (actionable)
8) If `--log`: link to work log

Must start with YAML:

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

## Optional: baseline README (propose-only)

If you discover that a project lacks any permanent/knowledge docs, you may propose creating a baseline README under `shared/knowledge/<project>/README.md` (title, overview, key components, key config points, maintenance tips).

Do **not** write it without explicit user approval.

## Implementation notes

- Keep SKILL.md focused; put long references in `references/`.
- Prefer Obsidian-friendly relative links inside `shared/`.
- Keep subcommands orthogonal; do not introduce new mode-switching flags.
