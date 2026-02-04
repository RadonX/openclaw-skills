# `/handoff load` (spec / instructions)

Status: **instructions-only**. Do not implement new behaviors beyond reading + reporting.

## Goal

Provide a fast, safe way to *locate* the most relevant existing handoff doc(s) for a project.

- This is an **on-demand navigation** helper.
- It should be usable in chat: user asks for context, you point them to the right handoff file.
- It must not create noise or mutate state.

## Command form

```
/handoff load <project> [--date YYYY-MM-DD]
```

- `<project>` maps to the folder: `shared/handoff/<project>/`
- `--date` narrows to `shared/handoff/<project>/<YYYY-MM-DD>/`

## Search locations

Vault root: `/Users/ruonan/.openclaw/shared/`

Search in this order:

1) `shared/handoff/<project>/INDEX.md` (if present)
2) `shared/handoff/<project>/<YYYY-MM-DD>/` (if `--date` provided)
3) Recent date folders under `shared/handoff/<project>/` (descending by date)

Within a date folder, prefer:

- `*_handoff.md` over `*_work_log.md`
- newest mtime as tie-breaker

## Output format (what to reply)

Return:

1) **Best match**: absolute path to the best candidate handoff doc
2) **Alternatives** (0–3): other likely relevant handoff docs
3) For each file: a **3–8 bullet** summary based on reading the doc (read-only)
4) A question: "Do you want to update this existing handoff or create a new one?"

## Hard constraints

- **Read-only**: never `write` or `edit` in `load` mode.
- If the project folder does not exist, say so and ask whether to create a new handoff instead.
- If multiple files are plausible, ask a clarifying question rather than guessing.

## Minimal example response

- Best match: `/Users/ruonan/.openclaw/shared/handoff/foo/2026-02-04/bar_handoff.md`
- Also relevant:
  - `/Users/ruonan/.openclaw/shared/handoff/foo/2026-02-03/baz_handoff.md`

Summary (bar_handoff.md):
- ...
- ...

Do you want to update `bar_handoff.md` or create a new handoff for today?
