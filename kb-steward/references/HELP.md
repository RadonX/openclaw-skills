# kb-steward — Help

## What it does
- Maintains a per-agent Obsidian-style KB under:
  - default: `<agent workspace>/knowledge/claw-config/`
- Auto-bootstraps folders + READMEs + templates (additive only)
- Ingests links/snippets into the right place:
  - `10-Projects/` (tasks/projects)
  - `20-Areas/` (evergreen principles)
  - `30-Research/` (analysis/notes)

## Commands

### Add from URL
`/kb-steward add <url> [--kind project|research|area] [--title "..."] [--kb-root <path>] [--relate] [--ask]`

### Add from pasted text
`/kb-steward add --paste [--kind ...] [--title "..."] [--kb-root <path>]`

### Check KB health (no writes)
`/kb-steward doctor [--kb-root <path>]`

### One-shot bootstrap
`/kb-steward bootstrap [--kb-root <path>] --apply`

## Minimal replies
Chat output is just: created/updated + exact path(s). Suggestions live inside the note.
