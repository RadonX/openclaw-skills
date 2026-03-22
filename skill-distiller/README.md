# skill-distiller (for installers)

This document is **for the human who installs/maintains skills**, not for the agent using the skill at runtime.

## What this is

`skill-distiller` is a meta-skill: it helps you turn a *successful* conversation/workflow into a reusable OpenClaw skill.

You likely want it if you often find yourself saying:

- “We did this once successfully — make it repeatable.”
- “Let’s turn this final, accepted workflow into a skill.”

## Which one should you install?

This repo contains two related skills:

### A) `skill-distiller` (recommended)

Install this if you want the **current, maintainable** distillation workflow.

Design goals:

- Progressive disclosure: lean `SKILL.md` router + focused `references/`
- Low interaction by default; ask only when ambiguous
- Supports multiple history sources:
  - `context` (use current conversation)
  - `session` (fetch via `sessions_history` when available)
  - `paste` (user pastes a transcript slice)

### B) `skill-distiller-gemini` (archived/reference)

This is the **Gemini-generated** earlier iteration, preserved for comparison.

Install this only if you specifically want to evaluate the Gemini draft behavior or keep it as a historical reference.

## Installation patterns

Common setups:

- **Symlink-per-skill** (recommended):
  - `~/.openclaw/skills/skill-distiller -> ~/repo/config/openclaw/skills/skill-distiller`

This keeps your runtime skills pointing at a version-controlled working copy.

## Operational notes

- `skill-distiller` is proposal-first: it should output a full proposed file tree + contents before writing anything.
- Applying changes should be gated by explicit user intent (e.g. `--apply`).
