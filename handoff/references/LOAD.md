# `/handoff load` (prime session context)

## Goal

Load a handoff document and **prime the current session** by reading any relevant supporting docs.

In OpenClaw terms: this means using `read`/`web_fetch` (when appropriate) to pull in the handoff + linked knowledge/playbooks so you can work immediately without asking the user to paste context.

## Command form

```
/handoff load <arg> [--date YYYY-MM-DD] [--max-docs N]
```

Where `<arg>` is either:

- a **handoff path** (recommended when you already have one), e.g.
  - `~/.openclaw/shared/handoff/foo/2026-02-04/bar_handoff.md`
- a **project name** (fallback), e.g.
  - `foo`

`--date` only applies when `<arg>` is a project name.

## Hard constraints (safety)

- **Read-only**: never `write` or `edit` in `load` mode.
- Do not claim something was loaded unless you actually read it.
- Keep context proportional: stop after a reasonable number of docs.

## Step-by-step behavior

### 1) Resolve the handoff file

Determine whether `<arg>` is a path or a project:

- Treat `<arg>` as a **path** if it contains `/` or ends with `.md` or starts with `~`.
  - Expand `~` to the home directory before reading.
- Otherwise treat `<arg>` as a **project**.

If `<arg>` is a project:

1) Search under `~/.openclaw/shared/handoff/<project>/`.
2) Prefer `INDEX.md` if present.
3) If `--date` is provided, prefer `.../<YYYY-MM-DD>/`.
4) Pick the best candidate `*_handoff.md` (prefer over `*_work_log.md`).
5) If multiple candidates remain and you cannot choose confidently, ask the user which one to load.

### 2) Read and analyze the handoff

Read the resolved handoff file and extract:

- The session goal / current status / next steps
- Keywords: project/system names, incident IDs, topics, commands
- **All explicit links** to supporting docs (especially knowledge/playbooks)

### 3) Load explicitly linked docs

From the handoff content, collect doc references. Common OpenClaw-friendly forms:

- Markdown links: `[text](relative/or/absolute/path.md)`
- Backticked paths: `` `shared/knowledge/foo/playbook.md` ``
- Plain absolute paths: `/.../something.md`
- Vault-relative paths: `shared/knowledge/<project>/...`

Resolution rules:

- If a link starts with `shared/`, resolve relative to the vault root: `~/.openclaw/shared/<that path>`.
- If a link is relative (no leading `/` and not starting with `shared/`), try:
  1) relative to the handoff file’s directory, then
  2) relative to `~/.openclaw/shared/`.

For each resolved path:
- `read` it.
- Record a 1–2 line purpose summary.

### 4) Infer and load related docs (intelligent step)

If the handoff mentions a system or task but links are missing, proactively search *locally* for likely supporting docs.

Suggested search scope (in priority order):

1) `~/.openclaw/shared/knowledge/<project>/` (if it exists)
2) `~/.openclaw/shared/knowledge/` (global)

Search method:

- Prefer light `rg`-style keyword search (if tool access allows).
- Use extracted keywords (system names, component names, common terms like "routing", "cron", "telegram", etc.).

Load at most `--max-docs` inferred docs (default 5). If too many match, present a shortlist and ask which to load.

### 5) Present what’s now in context

Reply with:

- **Handoff loaded**: the handoff path
- **Docs loaded**: list of every doc you read (paths/URLs), each with a 1-sentence relevance note
- **Key extracted context**: 5–10 bullets (tasks, risks, next steps)
- A question only if needed: e.g. "Which of these two playbooks should I follow?"

## Defaults

- `--max-docs` default: 5

## Notes (OpenClaw adaptation)

- In OpenClaw, “loading context” means reading these files **during this run** so the model can reference them immediately.
- This mode is intentionally read-only; any updates should be done via `/handoff <project>` (temporary) or `/handoff know ...` (knowledge).
