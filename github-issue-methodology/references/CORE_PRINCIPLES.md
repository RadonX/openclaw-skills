# Core Principles

The methodology is built on these non-negotiable principles:

## 1. Autonomous Research First

Before writing any code, you MUST:

✅ **Read project documentation:**
- `CLAUDE.md` - Project-specific guidance for AI/human collaborators
- `CONTRIBUTING.md` - Contribution guidelines and workflows
- `README.md` - Project overview and setup instructions

✅ **Explore existing code patterns:**
- Find related test files (`*.test.ts`, `*.spec.ts`)
- Look for test harnesses and fixtures
- Study how similar bugs were fixed before
- Check git history for related commits

❌ **DON'T wait for reviewers to guide you:**
- Reviewers validate, they don't teach
- Delaying until feedback slows everyone down
- Be proactive in your research

## 2. Understand the Problem Deeply

Before proposing a solution:

✅ **Reproduce the bug:**
- Set up the project locally
- Create minimal reproduction cases
- Verify the issue actually exists

✅ **Investigate root cause:**
- Use debuggers and logging
- Trace execution paths
- Identify edge cases

✅ **Document findings:**
- Write clear issue descriptions
- Include diagnostic evidence (logs, screenshots)
- Link to relevant code sections

## 3. Explore Existing Solutions

Before implementing from scratch:

✅ **Check for similar fixes:**
- Search git history: `git log --all --grep="keyword"`
- Look for similar PRs that were merged
- Study established patterns in the codebase

✅ **Use existing tooling:**
- Test harnesses and fixtures
- Helper functions and utilities
- CI/CD pipelines and scripts

## 4. Implement with Tests First

✅ **Write tests before or with your fix:**
- Tests document expected behavior
- Tests prevent regressions
- Tests speed up review (reviewers trust tests more than code)

✅ **Test edge cases:**
- Boundary conditions (empty, null, max values)
- Error cases (network failures, invalid input)
- Platform-specific behavior (Windows vs Linux)

✅ **Use established test patterns:**
- Follow the project's testing conventions
- Use existing test harnesses
- Parameterize tests when appropriate

## 5. Validate Thoroughly

Before submitting:

✅ **Run the project's test suite:**
- `pnpm test`, `npm test`, `make test`, etc.
- Fix any failing tests
- Ensure coverage doesn't decrease

✅ **Test manually:**
- Verify the fix works in real scenarios
- Check for unintended side effects
- Test on multiple platforms if applicable

✅ **Check CI/CD requirements:**
- Linting passes
- Type checking passes
- All automated checks pass

## 6. Write Clear PRs

✅ **Title should be descriptive:**
- `[Bug] Fix: <what was broken>`
- `[Feature] Add: <what was added>`
- Include affected component or module

✅ **Description should include:**
- Problem summary (what & why)
- Root cause analysis
- Solution overview
- Testing evidence
- Breaking changes (if any)

✅ **Keep PRs focused:**
- One logical change per PR
- Don't mix refactoring with fixes
- Small, reviewable diffs (< 400 lines ideal)

## 7. Respond to Reviews Quickly

✅ **Address feedback promptly:**
- Update code within hours, not days
- Clarify confusion immediately
- Don't let reviews stale

✅ **Iterative improvement:**
- Use new commits for improvements (not force-pushes unless agreed)
- Mark outdated conversations as resolved
- Keep the conversation moving forward

## Speed vs Quality

**The sweet spot**: 6-12 hours from issue to merged PR

- Too fast (< 2 hours): Probably missing tests or research
- Too slow (> 24 hours): Someone else might ship first
- Just right: Thorough research + tests + clear PR

## Measuring Success

You're following this methodology if:

✅ **Speed**: PR submitted within 24 hours of starting
✅ **Quality**: All tests pass, no regressions
✅ **Review**: Merged within 1-2 review cycles
✅ **Impact**: Fix solves the problem without side effects