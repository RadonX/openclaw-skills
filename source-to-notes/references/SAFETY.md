# Safety guardrails

- Never mutate source session logs or stores.
- Extraction is an exported view, not an edit.
- If export loses all user or all assistant turns, treat as failure.
- Propose-first is default:
  - Without `--apply`, do not write files; instead show paths + a short preview excerpt.
- When writing:
  - print absolute path(s) and require explicit confirmation (or `--apply`).
