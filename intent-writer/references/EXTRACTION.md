# Extraction rules (session → minimal INTENT)

## Goal (one sentence)

Extract the human's outcome intent for the most recent sustained thread. Keep it outcome-oriented (no procedures).

## Invariants (bullets)

Extract invariants primarily from user constraints and corrections:

- explicit formatting requirements
- "too specific" / "too many args" / "INTENT, INTENT"-style corrections
- boundaries (e.g., no runbooks; implementation-agnostic)

Keep only invariants that would cause the user to reject the result if violated.
Target 5–9 bullets.

## Title

Infer a short, concrete title for the thread (no questions). Fallback: `intent`.

## Anti-bloat rule

If a line reads like instructions, delete it or rewrite it as an invariant.
