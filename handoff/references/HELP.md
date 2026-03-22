# `/handoff help`

Print usage and a few examples. No file reads/writes.

## Usage

- `/handoff <project> [--log] [--name <base>] [--ask]`
- `/handoff load <project> [--date YYYY-MM-DD] [--max-docs N]`
- `/handoff know <project> [--target <path>] [--apply] [--ask]`

## Notes

- `--ask`: favor interactive confirmations; default tries to minimize user prompts.
- `load` is read-only.
- `know` is propose-first; apply only with `--apply` and explicit user approval.
