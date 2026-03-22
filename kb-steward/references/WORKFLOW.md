# Workflow (must follow)

## 1) Resolve kbRoot
Default: `<agent workspace>/knowledge/`
Override: `--kb-root <path>`

## 2) Decide kind → folder
- project → `10-Projects/`
- area → `20-Areas/`
- research → `30-Research/`

Heuristics:
- user says “创建任务/加入/调研/集成/排查” → project
- user states durable principle/决断/方向 → area
- user provides analysis/对比/诊断/读书笔记 → research

## 3) Auto-bootstrap (additive)
If kbRoot missing → create.
Ensure subdirs exist: `00-Inbox/ 10-Projects/ 20-Areas/ 30-Research/ 99-Templates/`.
Ensure folder READMEs exist; if present, never overwrite.
If README lacks "Taxonomy Registry" section, append an empty section.

## 4) Read-before-write
Before writing a new note into a folder: sample-read 1–2 notes to match:
- frontmatter keys
- naming pattern
- tag style

## 5) Ingest source
Follow `SOURCES.md` to fetch/parse.

## 6) Relatedness (optional)
Use `RELATEDNESS.md` to link 0–3 existing notes into `related_docs`.

## 7) Write one note
- filename = title
- body includes source URL/snippet + summary + next steps
- if new taxonomy introduced: record in note + folder README registry

## 8) Reply minimally
Return only:
- created/updated
- absolute path(s)
