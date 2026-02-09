---
name: skill-distiller
description: Synthesizes a new OpenClaw skill by analyzing a conversation history, distilling principles from the interaction, and structuring the output according to best practices. Use when creating a new skill from a successful workflow.
compatibility: OpenClaw with host git CLI access.
metadata:
  author: RadonX
  version: "1.0"
  openclaw:
    emoji: "⚗️"
---

# skill-distiller

This meta-skill creates a new, robust OpenClaw skill by analyzing the conversation history of a task that was successfully completed. It synthesizes the skill from the lessons learned during the interaction.

## Interface

```
/skill-distiller <new-skill-name> [--session <sessionKey>] [--message-id-start <id>] [--message-id-end <id>] [--apply]
```

- If session/message IDs are omitted, assume the current session's full history.
- Without `--apply`, this skill outputs a proposed file tree and content for the new skill.

## Workflow (must follow)

1) **Always read `references/PRINCIPLES.md` first.** This is your constitution for creating good skills.

2) **Gather conversation history.**
   - Use `sessions_history` with the provided session key and message ID range.

3) **Analyze the conversation (Root Cause Analysis).**
   - **Initial State:** Identify the first attempt at the task. Note its flaws and naive assumptions.
   - **Corrections:** Pinpoint every instance where the user provided a correction, clarification, or new constraint. These are the most critical pieces of information.
   - **Final State:** Locate the final, user-approved artifact (the skill, the config, etc.). This is the "ground truth" your synthesized skill must be able to produce directly.

4) **Synthesize the new skill's prompt and structure.**
   - **Abstract, don't copy:** Distill the *underlying principle* from each correction.
   - **Follow `PRINCIPLES.md`:**
     - Structure with progressive disclosure (`SKILL.md` as a router, details in `references/`).
     - Design a CLI-like interface (subcommands > flags for modes).
     - Bake in safety guardrails (confirm-before-write, propose-first).
     - Create a human-friendly `README.md`.

5) **Propose the new skill.**
   - Output the complete file tree for `<new-skill-name>/`.
   - For each file, provide the full proposed content.

6) **Apply the new skill (`--apply`).**
   - Only after user confirmation, write the files to `~/repo/config/openclaw/skills/<new-skill-name>/`.
   - After writing, `cd` into the repo and run `git add <new-skill-name>`.
   - Ask the user for a commit message or propose one based on the conversation.
