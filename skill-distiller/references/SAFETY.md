# Safety + git workflow

## Read/write rules

- Default mode is **proposal-only**.
- Never `write`/`edit` unless the user explicitly requested applying.
- Before any write/edit:
  - print the absolute destination path(s)
  - show the full proposed content (or a unified diff)
  - get confirmation

## Git rules (skills repo)

When applying changes in `~/repo/config/openclaw/skills/`:

1) `git status` first
2) write files
3) `git diff` (sanity check)
4) `git add <new-skill-name>/`
5) commit with a precise Conventional Commit message
6) push

## Destructive ops

Avoid deletion. Prefer renames or moving aside. If deletion is necessary, ask first.
