---
name: source-to-notes
description: Turn an OpenClaw conversation (session history) into usable dialogue materials and/or lightweight notes. The agent decides whether to run Step One extraction based on context; extracted materials default to /tmp/. Goal is optional: omitted goal triggers default behavior.
metadata:
  author: RadonX
  version: "0.1"
  openclaw:
    emoji: "🗂️"
---

# source-to-notes

Interface (single entry):

- `/source-to-notes [goal] [--session <sessionKey>] [--message-id-start <id>] [--message-id-end <id>] [--out <path>] [--apply]`

Defaults:
- If `--session` omitted: use current session
- If Step One writes extracted materials: default under `/tmp/`
- Without `--apply`: propose-only (no file writes)
- If `goal` omitted: treat as `default`

Hard rules:
- Never delete or rewrite source session history.
- Do not assume the dialogue is about code.
- Do not force a rigid note structure.

Routing (read on-demand):
- Overall behavior: `references/DEFAULT.md`
- Step One module (optional extract): `references/MODULE_step1_extract.md` + `references/FILTERING.md`
- Step Two module (distill): `references/MODULE_step2_distill.md` + `references/OUTPUTS.md`
- Safety guardrails: `references/SAFETY.md`
