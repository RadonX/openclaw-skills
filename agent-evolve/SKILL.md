---
name: agent-evolve
description: Refine agent prompt files (SOUL.md, AGENTS.md, SKILL.md, or any agent instruction doc) based on a conversation. Use when a user says "evolve", "refine", "improve", or "fix" an agent's instructions after observing a failure, misunderstanding, or suboptimal behavior in conversation. Analyzes root causes and proposes minimal, principle-driven fixes. Accepts optional --style flag pointing to a style guide file.
---

# Agent Evolve

Analyzes a conversation to identify and fix instruction gaps, then applies targeted improvements to an agent prompt file.

## Target File Selection

Default targets (in priority order):
1. User-specified file (always takes precedence)
2. The skill's own SKILL.md (if the conversation is about a skill misbehaving)
3. Agent persona files: `SOUL.md`, `AGENTS.md`, `HEARTBEAT.md`

## Parameters

- `--style=<file>`: Read the specified file as a style guide and adhere to its principles.

## Workflow

### Step 1 — Analyze & Preserve Core Design Principles

**Before proposing any change**, read the full target file.

Identify the document's:
- Purpose and intended audience (AI agent vs. human)
- Structural principles (modularity, inline vs. appendix, formatting conventions)
- Existing style (tone, verbosity level, use of headers/bullets)

**A user correction that reverts a change = you violated a core principle.** Treat it as the primary insight guiding your refinement.

If `--style` is provided, read that file first and adhere strictly to its principles.

### Step 2 — Conciseness for AI Audience

Instructions for AI agents must be clear and direct. Omit:
- Explanations of concepts foundational to any competent AI
- Redundant phrasing that restates existing rules elsewhere in the document
- Motivational filler that adds length without adding clarity

### Step 3 — Search for the Essence (Root Cause Analysis)

Read the conversation and find all misunderstandings or gaps. Then go deeper:

1. **Ask "Why?" recursively** until you reach a structural or philosophical root cause (e.g., "missing constraint" vs. "agent ignored instruction")
2. **Check for ignored instructions** — if the agent skipped a valid existing rule, diagnose *why* (poor placement, ambiguous wording, buried in noise) and fix that
3. **Generalize, don't patch** — if the user states a lesson or root cause explicitly, treat it as a primary insight and express it as an enduring principle
4. **Anticipate edge cases** — identify ambiguities that could cause future failures even if not in this conversation

See `references/root-cause-patterns.md` for common failure patterns and their fixes.

### Step 4 — Propose a Systematic Solution

For each root cause:

- **Place the fix at the right layer**: system identity (SOUL.md), behavioral rules (AGENTS.md), or procedural mechanics (SKILL.md / sub-doc)
- **Principle over example**: prefer abstract rules; use examples only as secondary illustrations to prevent "example-binding"
- **Explain your reasoning**: for structural changes (moving, merging, or removing content), explain *why*
- **Leverage existing structure**: don't restate rules already present elsewhere; only add what's new or different
- **Strengthen ignored instructions**: make them more prominent, earlier, or more explicit

### Step 5 — Read, Then Generate the Change

You MUST read the full target file before generating any edit — this ensures exact string matching and full context awareness.

Apply changes using the edit tool. Keep diffs minimal and surgical.

### Step 6 — Update Changelog

If the target file has a changelog section, append a concise entry:
```
# YYYY-MM-DD: <One-line summary of what changed and why>
```

### Step 7 — Self-Refine (Meta)

After completing the above, evaluate whether *this skill's instructions* (agent-evolve/SKILL.md) have any weaknesses revealed by this session. If so, propose a follow-up improvement to this skill.
