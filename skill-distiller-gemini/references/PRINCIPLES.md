# Skill creation principles (distilled from experience)

## 1. Structure: Progressive Disclosure is law

A skill is not a single file. It is a directory with a clear hierarchy.

- **`SKILL.md` is a router, not a book.** Keep it under 100 lines. It should contain only:
  - `name`, `description`, `metadata` (frontmatter)
  - A brief interface overview (subcommands, key flags)
  - A hard-coded on-demand routing table (`if subcommand=foo, read references/FOO.md`)
  - Global safety guardrails (e.g. "always confirm before write")

- **Details live in `references/`.** Each subcommand, mode, or complex behavior gets its own `.md` file.
  - `DEFAULT.md` for the default mode
  - `LOAD.md` for the `load` subcommand
  - `KNOW.md` for the `know` subcommand
  - `HELP.md` for the `help` subcommand
  - `PRINCIPLES.md` for timeless, distilled rules

- **Human-facing docs go in `README.md`.** This is for the user, not the agent. Keep it simple.

## 2. Interface: Design like a small, orthogonal CLI

- **Subcommands over flags for mode switching.** `handoff know` is better than `handoff --permanent`.
- **Flags are for parameters, not modes.** `--log` and `--name` are good flags. `--new` and `--update` are bad flags (they should be subcommands or an internal AI decision).
- **Be explicit.** The command structure should be self-documenting.

## 3. Interaction: Low friction, high agency (for the AI)

- **AI makes the obvious choice.** In high-confidence situations (e.g., only one valid file to update), the AI should decide and state its decision, not ask.
- **Ask only when truly ambiguous.** If there are multiple valid paths, present the user with a choice.
- **Provide an escape hatch for more safety.** An `--ask` flag is better than a `--yes` flag. It flips the model from "minimal interaction" to "confirm everything".

## 4. Safety: Never trust, always verify

- **Write-before-confirm is the default.** Always print the absolute path(s) you intend to write to, and get user confirmation *before* mutating the file system.
- **Propose-first for critical changes.** Any change to long-term knowledge, or any potentially destructive action, must be presented as a `PROPOSED PATCH` first. Only apply after explicit user approval (and an `--apply` flag).
- **Sanitize paths.** Never trust user input directly for file paths. Expand `~` and resolve relative paths against a safe root. Remove mentions of user-specific paths like `/Users/ruonan/` in the skill's own documentation.

## 5. Implementation: Self-contained and robust

- **No runtime dependencies on other files.** A skill should be a self-contained unit. If it needs knowledge, that knowledge should be in its `references/`.
- **Handle edge cases.** What happens if a file doesn't exist? What if a command fails? These should be considered in the `SKILL.md` instructions.
