# `/handoff know` (knowledge maintenance)

## Command form

```
/handoff know <project> [--target <path>] [--apply] [--ask]
```

## Goal

Maintain long-term **knowledge docs** under:

- `shared/knowledge/<project>/...`

These docs capture procedures, architecture, and debugging playbooks.

## Scope

- Prefer updating an existing knowledge doc when it exists.
- If a new doc is needed, propose it (filename + outline) before writing.

## Target selection

If `--target <path>` is provided:
- Use it.

If target is missing/ambiguous:
- Propose the most likely candidate path(s) under `shared/knowledge/<project>/`.
- Ask the user to confirm.

## Apply model

- Default behavior is **propose-only**.
- Only write changes when:
  - the user explicitly approves, AND
  - `--apply` is present.

## Content guidance

- Focus on evolution of understanding: wrong assumptions → what became clear.
- Prefer reusable procedures over session-specific chatter.

## Required guardrails

Follow `references/PRINCIPLES.md` (especially propose-first + documentation strategy).
