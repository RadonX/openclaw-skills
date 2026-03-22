# source-to-notes

A skill for turning a conversation (OpenClaw session history) into:

- clean dialogue materials (tool calls/results filtered out), and/or
- lightweight notes

Design goals:
- Single command entrypoint
- Optional `goal` argument (`/source-to-notes` == `/source-to-notes default`)
- The agent decides whether to run Step One extraction
- No forced note structure
- Default extracted materials under /tmp/ to reduce repo/vault pollution and write conflicts

What it does NOT do:
- It does NOT delete, edit, or compact your session history.
- It does NOT assume the conversation is about code.
- It does NOT force a rigid notes template.
