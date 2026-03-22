# `/skill-distiller help`

## Usage

- `/skill-distiller <new-skill-name>`
- `/skill-distiller <new-skill-name> --source session --session <sessionKey> [--range <start..end>]`
- `/skill-distiller <new-skill-name> --source paste`
- Add `--apply` to actually write files (otherwise proposal-only).
- Add `--ask` to increase confirmations.

## What you get

A proposed new skill under:

- `~/repo/config/openclaw/skills/<new-skill-name>/`

Containing:

- `SKILL.md` (lean router)
- `references/` (details, subcommand specs, principles)

## Notes

- The output is synthesized from history: initial attempt → corrections → final accepted shape.
- The distiller will keep `SKILL.md` small and push details into `references/`.
