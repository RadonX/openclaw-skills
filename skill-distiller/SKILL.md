---
name: skill-distiller
description: Distill a repeatable OpenClaw skill from a successful conversation history. Use when you want to turn “we did this once successfully” into a reusable skill (SKILL.md + references/), capturing the corrections and the final accepted shape.
compatibility: OpenClaw.
metadata:
  author: RadonX
  version: "1.0"
  openclaw:
    emoji: "⚗️"
---

# skill-distiller

Create a new skill by *synthesizing from history* (not generating from vibes): identify the initial attempt, every user correction, and the final accepted artifact; then codify the underlying principles into a new skill with progressive disclosure.

## Interface

- `/skill-distiller help`
- `/skill-distiller <new-skill-name> [--source context|session|paste] [--session <sessionKey>] [--range <start..end>] [--apply] [--ask]`

Defaults:
- `--source context`
- Without `--apply`, output a PROPOSAL only (no writes).

## Parsing rules (hard)

- First token after `/skill-distiller` is either:
  - `help`, or
  - `<new-skill-name>`.
- Any other subcommand-like token is unsupported → show help and ask the user to restate.

## Which references to read (on-demand)

- Always read: `references/PROCESS.md`, `references/OUTPUT_CONTRACT.md`, `references/SAFETY.md`.
- If invoked as `/skill-distiller help`: read `references/HELP.md`.

## Global guardrails

- Prefer low interaction. Ask only when ambiguous or risky (use `--ask` to increase confirmations).
- Never write files unless:
  1) you printed the full proposed file tree + contents, and
  2) the user explicitly requested applying (via `--apply` or an explicit “apply/write it”).
- Keep docs path-sanitized: use `~` in generated skill docs.

## Workflow (must follow)

1) **Collect the history** (depending on `--source`):
   - `context`: use the current conversation context.
   - `session`: use `sessions_history` on `--session` and optionally `--range`.
   - `paste`: ask the user to paste the relevant transcript (and only the relevant part).

2) **Distill the evolution**:
   - Initial state (first attempt) → what was wrong.
   - Corrections (every constraint the user added; every “don’t do that”).
   - Final success state (the accepted file tree / docs / config / behavior).

3) **Synthesize the new skill** per `references/OUTPUT_CONTRACT.md`.

4) **Output a PROPOSAL** (tree + full contents for every file).

5) **Apply only if requested** (see `references/SAFETY.md`).
