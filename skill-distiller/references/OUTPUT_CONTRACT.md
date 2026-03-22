# Output contract (what to generate)

## Goal

Generate a new OpenClaw skill directory that is:

- structured for progressive disclosure
- low-instruction but robust
- safe-by-default (proposal-first)
- path-sanitized (`~` in docs)

## Directory + files

Write under:

- `~/repo/config/openclaw/skills/<new-skill-name>/`

Minimum recommended structure:

```
<new-skill-name>/
  SKILL.md
  references/
    HELP.md
    <SUBCOMMAND>.md ...
```

Create additional references when they save tokens or reduce ambiguity.

## SKILL.md requirements

SKILL.md must be a **router**:

- frontmatter: `name`, `description` (+ optional compatibility/metadata)
- minimal interface section
- hard parsing rules
- explicit “which references to read” routing table
- global guardrails

Avoid long examples and deep explanations in SKILL.md.

## Description requirements (triggering)

The `description` must:

- say what the skill does
- list the typical user intents that should trigger it
- be concise (command-menu friendly)

## Style constraints

- Use `~` instead of `/Users/...` in generated docs.
- Avoid meta-commentary like “adaptation” in the body.
- Prefer small, orthogonal concepts over monolithic prompts.

## Interaction defaults

- Default to low interaction.
- Ask only when:
  - ambiguous target (multiple valid files)
  - dangerous operation (write/edit/delete)
  - insufficient input (missing project name, unclear goal)

Support an `--ask` flag when appropriate.

## Apply behavior (if your skill supports it)

If the new skill can write files:

- proposal-first
- require explicit confirmation before applying
- prefer reversible steps (git commits; avoid destructive ops)
