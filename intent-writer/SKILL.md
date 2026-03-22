---
name: intent-writer
description: Distill the current session into a minimal INTENT.md (Goal + Target state invariants).
compatibility: OpenClaw
metadata:
  author: RadonX + conversation distillation
  version: "1.0"
  openclaw:
    emoji: "🧭"
---

# intent-writer

Distill the **current session** into a minimal `INTENT.md`.

## Interface

- `/intent-writer` (default)
- `/intent-writer help`

## Parsing rules (hard)

- If the first token is `help`, show help.
- Otherwise run DEFAULT.

## Which references to read

- Always: `references/DEFAULT.md` + `references/EXTRACTION.md`
- If `help`: also `references/HELP.md`

## Guardrails (behavior constraints)

- **Zero-arg**: uses the current session as input.
- **Proposal-only**: do not write files.
- **Prefer not to ask questions.** If session content is insufficient, emit a short error.
- Output is **minimal** and may contain only:
  - header block: `# <title>`, `Model: ...`, `Updated: ...`
  - `## Goal`
  - `## Target state (invariants)`
- Prefer user-stated constraints (corrections, “don’t do X”, formatting requirements) over AI preferences.
