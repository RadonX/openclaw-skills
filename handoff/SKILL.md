---
name: handoff
description: Create handoff documentation (temporary state transfer + optional work log) in a shared Obsidian vault. Use when you need to hand work to a future human/agent, or when the user says "handoff", "交接", "接手", "handover".
compatibility: OpenClaw. Uses the shared Obsidian vault at `~/.openclaw/shared/`.
metadata:
  author: RadonX
  version: "2.1"
  openclaw:
    emoji: "🧷"
---

# handoff

Keep this SKILL.md small. Most mode details live in `references/` for progressive disclosure.

## Shared vault

Root: `~/.openclaw/shared/`

- Temporary: `shared/handoff/<project>/<YYYY-MM-DD>/...`
- Knowledge: `shared/knowledge/<project>/...`

## Interface

Smart default:

- `/handoff <project> [--log] [--name <base>] [--ask]`

Subcommands:

- `/handoff load <project> [--date YYYY-MM-DD]` (read-only)
- `/handoff know <project> [--target <path>] [--apply] [--ask]`

## Parsing rules (hard)

- First token after `/handoff` is either:
  - `<project>` (smart default), or
  - `load`, or
  - `know`.
- Any other subcommand-like token is unsupported. Show usage and ask the user to restate.

## Which references to read (on-demand)

- Always follow: `references/PRINCIPLES.md`.
- If invoked as `/handoff <project> ...`: read `references/DEFAULT.md`.
- If invoked as `/handoff load ...`: read `references/LOAD.md`.
- If invoked as `/handoff know ...`: read `references/KNOW.md`.

## Global safety guardrails

- Do not invent state.
- Never write/edit files without printing the absolute path(s) you intend to write.
- Knowledge docs are propose-first and require explicit approval; apply only with `--apply`.
