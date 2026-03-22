# Handoff principles (distilled)

This reference captures the core “Gemini handoff” essentials that must not be lost.

## 1) Handle ambiguous document references

When the user asks to update a document with an ambiguous reference (e.g. “the main doc”, “triage doc”):

- Acknowledge the ambiguity.
- Propose the most likely candidate file path(s).
- Ask the user to confirm the correct target.

## 2) Proportionality

- Keep the handoff concise.
- Match detail level to the conceptual scale of the work.

## 3) Confirm before writing (safety)

Before any file write/edit:

- Print the resolved absolute output path(s) you intend to write.
- If interaction is required (e.g. `--ask`, permanent/knowledge writes), ask for explicit confirmation.

## 4) Knowledge docs (permanent docs): propose first (CRITICAL)

For any creation/update of long-term docs:

- Read the target doc first if it exists.
- Analyze its existing purpose/tone.
- Produce a **PROPOSED PATCH**.
- STOP and ask for explicit confirmation.
- Apply only after confirmation (and `--apply`, if applicable).

## 5) Communicate documentation strategy

If information that previously lived in a temporary handoff has been moved into a knowledge doc during the session:

- Explicitly state what moved and where it now lives.

## 6) Current Status = artifact/knowledge state

When writing “Current Status”, focus on the state of artifacts/knowledge at end-of-session, not a chronological action list.

## 7) Never invent state

Do not claim tests, file writes, git actions, or external side effects occurred unless verified.

## 8) Baseline README (propose-only)

If a project lacks any permanent/knowledge docs, you may propose creating a baseline README (title/overview/components/config/maintenance tips).

Do not write it without explicit approval.
