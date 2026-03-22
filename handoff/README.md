# handoff (OpenClaw)

This skill helps you create **handoff documentation** in a shared Obsidian vault.

Vault root:

- `~/.openclaw/shared/`

## Commands

### 1) Create/update a handoff (smart default)

```
/handoff <project> [--log] [--name <base>] [--ask]
```

- The assistant will automatically decide whether to create a new handoff or update the most relevant existing one.
- Use `--ask` if you want more confirmations.

### 2) Load context from an existing handoff (read-only)

```
/handoff load <project> [--date YYYY-MM-DD] [--max-docs N]
```

- Reads the best matching handoff for the project.
- Also reads linked knowledge/playbooks and a small number of inferred relevant docs.
- Never writes files.

### 3) Maintain knowledge docs (propose-first)

```
/handoff know <project> [--target <path>] [--apply] [--ask]
```

- For long-term docs under `shared/knowledge/<project>/...`.
- Defaults to propose-only; apply only with `--apply` + explicit approval.

### 4) Help

```
/handoff help
```

## Output locations

Temporary handoffs:

- `~/.openclaw/shared/handoff/<project>/<YYYY-MM-DD>/...`

Knowledge docs:

- `~/.openclaw/shared/knowledge/<project>/...`
