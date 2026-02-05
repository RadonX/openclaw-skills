# `/handoff load` (prime session context)

## Goal

Load the most relevant handoff doc for a project and prime the current session by reading any relevant supporting docs (especially knowledge/playbooks).

## Command form

```
/handoff load <project> [--date YYYY-MM-DD] [--max-docs N]
```

Notes:
- In Telegram-style usage, users typically provide a project name, not a full file path.
- `--date` narrows the search to a specific date folder when needed.

## Hard constraints (safety)

- **Read-only**: never `write` or `edit` in `load` mode.
- Do not claim something was loaded unless you actually read it.
- Keep context proportional: stop after a reasonable number of docs.

## Step-by-step behavior

### 1) Resolve the handoff file

Given `<project>`:

1) Search under `~/.openclaw/shared/handoff/<project>/`.
2) Prefer `INDEX.md` if present.
3) If `--date` is provided, prefer `.../<YYYY-MM-DD>/` first.
4) Pick the best candidate `*_handoff.md` (prefer over `*_work_log.md`).
5) If multiple candidates remain and you cannot choose confidently, ask the user which one to load.

### 2) Read and analyze the handoff

Read the resolved handoff file and extract:

- Session goal / current status / next steps
- Keywords: project/system names, incident IDs, topics, commands
- **All explicit links** to supporting docs (especially knowledge/playbooks)

### 3) Load explicitly linked docs

From the handoff content, collect doc references. Common forms:

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

If the handoff mentions a system or task but links are missing, proactively search locally for likely supporting docs.

Suggested search scope (in priority order):

1) `~/.openclaw/shared/knowledge/<project>/` (if it exists)
2) `~/.openclaw/shared/knowledge/` (global)

Search method:

- Prefer lightweight keyword search if tool access allows.
- Use extracted keywords (system names, component names, common terms).

Load at most `--max-docs` inferred docs (default 5). If too many match, present a shortlist and ask which to load.

### 5) Present what’s now in context

Reply with:

- **Handoff loaded**: the handoff path
- **Docs loaded**: list of every doc you read (paths/URLs), each with a 1-sentence relevance note
- **Key extracted context**: 5–10 bullets (tasks, risks, next steps)
- A question only if needed

## Defaults

- `--max-docs` default: 5
