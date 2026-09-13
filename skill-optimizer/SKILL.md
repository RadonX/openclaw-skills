---
name: skill-optimizer
description: Rewrite skill descriptions for accurate triggering. Use when asked to optimize/prune skill descriptions or audit the skills catalog ('优化skill', 'desc 优化'). Description-only in v0.1.
compatibility: OpenClaw.
metadata:
  author: RadonX
  version: "0.1"
  openclaw:
    emoji: "✂️"
---

# skill-optimizer

Optimize the `description` frontmatter of existing skills so the right skill
triggers at the right time. Everything else is out of scope in v0.1.

## Interface

- `/skill-optimizer help`
- `/skill-optimizer desc [--skill <name>] [--apply] [--dry-run]`

Defaults: all owned skills, dry-run (proposal only).

## Parsing rules (hard)

- First token: `help` or `desc`. Anything else → help + note that only `desc`
  exists in v0.1; point to the OpenAI article for the rest (body/router,
  AGENTS.md audits are future modes).
- No `--apply` → never write.

## Routing

- Always read: `references/DESC_CRITERIA.md`.
- `help` → also `references/HELP.md`.
- Applying → also `references/APPLY.md`.

## Guardrails

- Touch ONLY the `description` field. Never edit body, name, or metadata.
- Skip skills not owned by the user (system/bundled skills get overwritten
  on update).
- Proposal-first: show old → new per skill; write only after explicit
  `--apply` or user confirmation.
- Conflicts with sibling skills are resolved by narrowing triggers, not by
  deleting siblings.
