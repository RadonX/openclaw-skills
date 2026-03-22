# Distillation process (from successful history)

## Goal

Turn a one-off successful interaction into a reusable skill by extracting:

- What was attempted first (and why it was wrong)
- Every correction/constraint the user introduced
- The final accepted artifact(s)

Then synthesize a new skill that would reach the final state directly.

## Inputs (supported sources)

- **context**: the current conversation context
- **session**: a sessionKey (optionally with a message-id range)
- **paste**: a user-pasted transcript snippet (ask for a tight slice)

## Step-by-step

### 1) Identify the final success state (ground truth)

Find the last user-accepted outcome. Examples:

- a final file tree in a repo
- a pushed commit
- a config change that was validated

This is the target your distilled skill must reliably reproduce.

### 2) Reconstruct the evolution

Build a timeline with three buckets:

1. **Initial attempt**
   - What the agent assumed
   - What it over-specified / under-specified
   - What it got wrong structurally

2. **Corrections** (most valuable)
   - Each “don’t do X”
   - Each new constraint (naming, paths, safety, interaction)
   - Each preference (style, tone, format)

3. **Final shape**
   - What changed compared to initial attempt
   - What patterns emerged (e.g., progressive disclosure)

### 3) Abstract principles from corrections

Do not copy the correction verbatim. Convert it into a durable rule.

Examples:

- Correction: “Don’t put mode details in SKILL.md; it’s too long.”
  - Principle: Keep SKILL.md lean; push mode details into references; add explicit routing.

- Correction: “In Telegram, users won’t provide full file paths.”
  - Principle: Prefer project-name interfaces; infer paths; ask only on ambiguity.

### 4) Decide interface shape

Prefer:

- subcommands for modes
- flags for parameters
- `--ask` as an opt-in for extra confirmations
- safe defaults (proposal-first)

### 5) Plan the file tree with progressive disclosure

At minimum:

- `SKILL.md` (router + hard parsing + routing + guardrails)
- `references/HELP.md`
- one reference per subcommand or complex behavior
- `references/PRINCIPLES.md` only for timeless cross-cutting rules (optional)

### 6) Produce the proposal

Output:

- file tree
- full contents for each file
- any open questions (only if blocking)

### 7) Apply (only when explicitly requested)

Follow `references/SAFETY.md`.
