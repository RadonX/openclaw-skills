# DEFAULT

## Input

Use the **current session history** as the only input.

## Output

Print a minimal `INTENT.md` using the fixed structure below. Do not write files.

```md
# <title>

Model: gpt-5.2
Updated: <YYYY-MM-DD>

## Goal
<one sentence>

## Target state (invariants)
- <bullet>
```

## Defaults

- `Model:` defaults to `gpt-5.2`.
- `Updated:` defaults to the local date `YYYY-MM-DD`.
- Do not ask questions unless the session is insufficient to infer Goal + ≥3 invariants.
