# Outputs

If Step One runs:
- default extracted transcript path:
  - `/tmp/openclaw-source-to-notes-<sessionKey-sanitized>.md`

If Step Two writes notes:
- default notes path:
  - `/tmp/openclaw-source-to-notes-<...>.notes.md`

If user provides `--out`:
- treat it as the final output path
- echo the absolute path back before writing
