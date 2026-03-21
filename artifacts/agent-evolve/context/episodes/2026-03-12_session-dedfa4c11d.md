---
skill: agent-evolve
date: "2026-03-12"
session_opaque: dedfa4c11d
episode_type: evolution
title: "Identifying need for systematic agent prompt refinement workflow"
status: completed
models_observed: ["unknown"]
evolution_links:
  commits:
    - "97ca17525e0fe3f3033426824be9aaa5914f2b9b feat: add agent-evolve skill for refining agent prompt files"
    - "10475d3b6f436f560bd53323ff365e1d4f788b05 fix: correct default target files list (HEARTBEAT.md is not a persona file)"
    - "39d7a6c8468e96e7ab2cb8522022863129b41a15 feat: add Step 0 announce on skill invocation"
  changes:
    - "Created agent-evolve skill (SKILL.md + references/root-cause-patterns.md) for systematic prompt refinement"
    - "Defined default target files: SOUL.md, AGENTS.md, SKILL.md, IDENTITY.md, USER.md"
    - "Added root cause analysis workflow with 6 failure patterns"
    - "Added Step 0 announce for transparency on invocation"
tags: ["agent-design", "prompt-engineering", "workspace-config"]
---

## Episode Summary

磨坊主大人 was working on workspace configuration management — deciding which files should be maintained in a public repo and symlinked back to private workspace. She noted that the existing SOUL.md and AGENTS.md lacked the strong boundaries found in workspace-bootstrap templates. This surfaced a broader need: a systematic way to analyze agent behavior failures and apply targeted fixes to instruction files, which became the agent-evolve skill.

## Key Decisions / Constraints

- SOUL.md and AGENTS.md were identified as having weak boundaries compared to workspace-bootstrap
- Public/private repo strategy: SOUL.md and AGENTS.md suitable for public maintenance; TOOLS.md, USER.md, MEMORY.md must stay private
- Decision to use Option B: move config logic into a skill rather than ad-hoc scripts
- Requirement to follow the skill-creator standard when writing the config-workflow skill

## Relation to skill evolution

This session predates the agent-evolve commits by one week (2026-03-12 vs. 2026-03-19). The session is where the core need was identified: the human observed that agent instruction files (SOUL.md, AGENTS.md) were poorly structured and needed principled refinement. This directly motivated the creation of the agent-evolve skill, which provides a structured workflow (root cause analysis → targeted fix → self-refine) for evolving agent prompt files. The commits on 2026-03-19 represent the implementation of that need.
