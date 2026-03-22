---
name: github-issue-methodology
description: Systematic methodology for addressing GitHub issues: investigate, fix, validate, and merge PRs quickly (6-12 hours from issue to merge).
compatibility: OpenClaw
metadata:
  emoji: "⚡"
  version: "1.0"
---

# github-issue-methodology

Comprehensive methodology for investigating, fixing, and validating GitHub issues in any open-source project. Emphasizes autonomous research, exploration of existing patterns, and comprehensive testing to ship quality fixes quickly.

## Interface

- `/github-issue-methodology help`
- `/github-issue-methodology investigate <issue-url> [--project <path>]`
- `/github-issue-methodology workflow [--step <all|investigate|implement|validate|submit>]`
- `/github-issue-methodology review <pr-url>` (audit your own PR before submission)

Defaults:
- `project`: current working directory
- `step`: `all`
- Low interaction: show checklist, proceed autonomously

## Hard parsing rules

- First token after `/github-issue-methodology` must be one of: `help | investigate | workflow | review`.
- `investigate` requires: `<issue-url>` (GitHub issue URL)
- `review` requires: `<pr-url>` (GitHub PR URL)
- Unknown tokens/subcommands → show help and stop.

## Which references to read (routing)

- Always read: `references/CORE_PRINCIPLES.md`, `references/WORKFLOW.md`
- If `investigate`: `references/INVESTIGATE.md`, `references/RESEARCH.md`
- If `workflow`: `references/WORKFLOW.md`, `references/PITFALLS.md`
- If `review`: `references/REVIEW_CHECKLIST.md`, `references/PITFALLS.md`
- If `help`: `references/HELP.md`

## Output contract

### Investigate mode

Must output:

1. **Issue summary**: What's broken, who's affected
2. **Root cause analysis**: Diagnostic evidence (logs, traces)
3. **Existing patterns**: Related tests, harnesses, similar fixes
4. **Reproduction steps**: How to verify the bug locally
5. **Implementation plan**: Tests to write, files to change

### Workflow mode

Must output:

1. **Step-by-step checklist**: From investigation to merged PR
2. **Time estimates**: Each phase (investigate 1-2h, implement 2-4h, etc.)
3. **Validation commands**: Test suite, linting, typecheck
4. **PR template**: Title, description structure

### Review mode

Must output:

1. **Pre-submission audit**: Tests, documentation, breaking changes
2. **Common pitfalls**: Reactivity, slowness, missing tests
3. **Readiness score**: Ready for review / needs improvements

## Mental model

**Speed + Quality = Successful Contribution**

Most PRs fail not because of bad code, but because of:
- ❌ Reactive approach (wait for reviewers to guide)
- ❌ Insufficient research (miss existing patterns)
- ❌ Missing tests (reviewers can't trust the fix)
- ❌ Moving too slowly (someone else ships first)

**The fix**: Be autonomous, research thoroughly, write tests alongside code, ship within 24 hours.

## Key principles (non-negotiable)

- **Autonomous research first**: Read CLAUDE.md, CONTRIBUTING.md, explore existing tests
- **Explore existing solutions**: Use test harnesses, follow established patterns
- **Implement with tests**: Write tests alongside fixes, cover edge cases
- **Validate thoroughly**: Run test suites, check CI/CD requirements
- **Ship quickly**: 6-12 hours from issue to PR submission

## Guardrails

- **No guessing**: If docs are ambiguous, confirm in source code
- **Test harness first**: Always check for existing test patterns before writing new tests
- **Small focused PRs**: One logical change per PR, small reviewable diffs
- **Respond to reviews quickly**: Address feedback within hours, not days
