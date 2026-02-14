---
name: kb-steward
description: Per-agent Obsidian KB steward: auto-bootstrap folders/READMEs/templates and ingest links/snippets into notes (Projects/Areas/Research) with lightweight related-doc linking.
compatibility: OpenClaw
metadata:
  emoji: "📚"
  version: "0.1"
---

# kb-steward

Steward an Obsidian-style knowledge base rooted under **this agent's workspace** (default), and ingest user-provided URLs/snippets into the right folder with minimal chat noise.

## Interface

- `/kb-steward help`
- `/kb-steward add <url> [--kind project|research|area] [--title "..."] [--kb-root <path>] [--relate] [--ask]`
- `/kb-steward add --paste [--kind ...] [--title ...] [--kb-root <path>]`
- `/kb-steward doctor [--kb-root <path>]` (check only; no writes)
- `/kb-steward bootstrap [--kb-root <path>] --apply` (explicit one-shot bootstrap)

Defaults:
- `kbRoot`: `<agent workspace>/knowledge/`
- `kind`: `project`
- `--relate`: on
- Low interaction: ask only when ambiguous or risky.

## Hard parsing rules

- First token after `/kb-steward` must be one of: `help | add | doctor | bootstrap`.
- `add` requires exactly one of:
  - `<url>`, OR
  - `--paste`
- Unknown tokens/subcommands → show help and stop.

## Which references to read (routing)

- Always read: `references/WORKFLOW.md`, `references/SAFETY.md`
- If `help`: `references/HELP.md`
- If `add`: `references/BOOTSTRAP.md`, `references/FRONTMATTER.md`, `references/SOURCES.md`
- If `--relate`: `references/RELATEDNESS.md`
- If `doctor/bootstrap`: `references/BOOTSTRAP.md`

## Global guardrails

1) **Read-before-write (folder conventions):** before writing a new note into a folder, sample-read 1–2 existing notes in that folder to match naming + frontmatter conventions.
2) **Auto-bootstrap is additive:** `add` may create missing folders/READMEs/templates, but must **never overwrite** existing files (append-only for registries).
3) **Taxonomy is evolvable:** allowed to introduce a new tag/field/subfolder only if recorded as a **Taxonomy decision** in the note and in the folder README registry.
4) **Minimal chat noise:** reply with what changed + exact path(s). Put next-step suggestions inside the note/README.
5) **Destructive ops:** avoid deletions; prefer `.bak` or ask first.

## Output behavior

- `add`:
  - resolves kbRoot
  - runs auto-bootstrap (add missing assets only)
  - ingests the source (URL/paste)
  - writes one note
  - optionally adds `related_docs`
- `doctor`: produces a report only.
- `bootstrap`: proposal first unless `--apply`.
