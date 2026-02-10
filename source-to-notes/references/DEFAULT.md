# Default behavior

You are given: an optional goal + (optionally) a sessionKey and message-id range.

## Goal
- If goal is omitted, treat it as `default`.
- If goal is present, use it as a *high-priority alignment anchor*.

## Internal plans (agent chooses)

### Plan A: Direct distill (skip Step One)
Use when:
- input is already a clean transcript file, OR
- the session history is mostly user/assistant text with minimal tool noise, OR
- the user only wants high-level notes and tool filtering is not critical.

### Plan B: Step One extract → Step Two distill
Use when:
- the session is tool-heavy (many toolCall/toolResult blocks), OR
- the user explicitly says "filter tool calls", OR
- prior attempts accidentally removed user/assistant messages and you need a safe export view.

When proposing output, always state which plan you picked and why, in 1–2 lines.
