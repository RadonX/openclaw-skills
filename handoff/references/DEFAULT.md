# `/handoff <project>` (default, smart new/update)

## Command form

```
/handoff <project> [--log] [--name <base>] [--ask]
```

## Goal

Create (or update) a **temporary handoff** doc that transfers state to the next person/agent.

## Smart decision policy (AI chooses new vs update)

Read-only discovery:

1) Check `shared/handoff/<project>/INDEX.md` if present.
2) Otherwise scan `shared/handoff/<project>/` for date folders (newest first).

Choose **update** when there is a clear best target:

- INDEX.md points to a single current handoff, OR
- the newest date folder contains exactly one `*_handoff.md`.

Choose **new** when no suitable target exists.

If multiple plausible update targets exist:

- With `--ask`: ask the user to pick.
- Without `--ask`: pick deterministically (newest `*_handoff.md` by mtime), and state the rationale.

## Output paths

Handoff root: `~/.openclaw/shared/handoff/<project>/<YYYY-MM-DD>/`

Suggested filenames:

- `<base>_handoff.md`
- `<base>_work_log.md` (only with `--log`)

If `--name <base>` is omitted, derive a short, safe base name from the session’s core task.

## Required sections (handoff doc)

1) Title: `Project Handoff: <project>`
2) Header note: temporary / discard-after-use
3) Key document links (knowledge docs). 1 sentence per link on utility.
4) Session goal
5) Work done (concise)
6) Current status (artifact/knowledge state)
7) Next steps (actionable)
8) If `--log`: link to work log

Start with YAML:

```yaml
---
type: handoff
temporary: true
project: <project>
date: <YYYY-MM-DD>
created_at: <ISO8601>
author: <agentId>
session: <sessionKey if available>
---
```

## Work log (only with `--log`)

- Commands executed + key outputs
- Files read/modified + summary
- Hypotheses/decisions/errors
- Avoid duplicating overview/goal/status/next steps
