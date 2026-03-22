# MODULE: Step One — Extract clean dialogue materials (optional)

Purpose:
Export a *view* of the conversation that reads like a normal transcript:
- keep user/assistant text
- filter tool calls/results/thinking
- do NOT delete anything from source history

Input:
- session history (via sessions_history)
- optional message id range

Output:
- a markdown file (default: `/tmp/openclaw-source-to-notes-<sessionKey-sanitized>.md`)

Process:
1) Load history with `includeTools=true` (so tool blocks can be detected and filtered).
2) Apply FILTERING rules (see FILTERING.md).
3) Write the clean transcript.

Sanity checks (must):
- If extracted transcript has 0 user turns OR 0 assistant turns → STOP and report over-filtering or wrong sessionKey.
