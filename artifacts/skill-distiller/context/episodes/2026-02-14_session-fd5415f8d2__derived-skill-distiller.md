---
skill: "skill-distiller"
date: "2026-02-14"
session_opaque: "fd5415f8d2"
episode_type: "evolution"
title: "Derived: skill-distiller interaction notes from fd5415f8d2"
status: "completed"
derived_from: "artifacts/intent-writer/context/episodes/2026-02-14_session-fd5415f8d2.md"
focus: "Only the parts about using skill-distiller/skill-distiller-gemini and critiques"
---
## Episode Summary

User was working on zsh dotfiles with stow and asked the agent to write an `INTENT.md` describing how to generate the zsh config (msg 9). After several rounds of corrections — INTENT.md was too verbose, too procedural, included unnecessary metadata headers — the user pivoted (msg 24): instead of fixing INTENT.md inline, create a reusable **skill** that distills any session into a minimal INTENT.md. The agent attempted skill creation via skill-distiller, which the user rejected as too specific (msg 25), then re-ran with skill-distiller-gemini. Through iterative refinement (msgs 26–38), the skill's core contract was established: zero-arg, proposal-only, minimal output (Goal + invariants), no questions.

## Key User Quotes

- "write a INTENT.md to describe how to generate zsh/" (msg 9)
- "应该只留下能够推理出目标的最小INTENT" (msg 15)
- "不是。以下不需要： Audience: LLM operator Author LLM: …" (msg 23)
- "use skill distiller to create skill that writes INTENT.md" (msg 24)
- "I do not like the skill you just created. too specific." (msg 25)
- "we don't even need an arg, I guess? prefer not to ask" (msg 35)
- "为啥 intent-writer skill create 起来这么困难" (msg 40)

## Key Decisions / Constraints

- **Zero-arg interface**: no CLI flags, no path arguments — derive everything from current session history
- **Proposal-only**: print INTENT.md content, never write files
- **Output minimalism**: only `# <title>`, `## Goal`, `## Target state (invariants)` — anything procedural must be rewritten as invariant or deleted
- **No questions by default**: if session content is insufficient, emit a short error instead of asking
- **Header rejection**: user explicitly removed Audience, Author LLM, Model metadata lines from INTENT.md output
- **Description vs guardrails split**: frontmatter description kept routing-only; behavioral constraints live in SKILL.md guardrails
- **skill-distiller critique**: user questioned whether skill-distiller/skill-distiller-gemini were adequate for this workflow

## Relation to skill evolution

This is the **conception episode** for the intent-writer skill. The session (2026-02-14) predates the actual git commits (2026-03-18) by over a month. Every major design decision in the final SKILL.md traces back to user corrections in this session: zero-arg, proposal-only, minimal output, anti-bloat extraction rules. The git commits a month later formalized what was already designed here. The earlier decisions.yaml entries (D0001–D0005 dated 2026-02-14) correctly captured these decisions before being regenerated from git history on 2026-03-18.
