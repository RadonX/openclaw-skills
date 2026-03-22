# Common Pitfalls

Avoid these common mistakes that slow down PRs or cause them to be rejected.

## Pitfall #1: Reacting Instead of Researching

**Bad Pattern:**
- See an issue
- Implement the first solution that comes to mind
- Submit PR
- Wait for reviewers to suggest better approach
- Resubmit with changes

**Time Lost:** 2-3 days

**Good Pattern:**
- See an issue
- Research existing solutions in codebase
- Study test patterns and harnesses
- Implement informed solution
- Submit PR with tests
- Merged in 1 review cycle

**Time Saved:** 1-2 days

---

## Pitfall #2: Writing Code Without Understanding

**Bad Pattern:**
- Start coding immediately
- Figure things out as you go
- Realize halfway through that approach is wrong
- Start over

**Time Lost:** 2-4 hours

**Good Pattern:**
- Investigate root cause first
- Explore existing patterns
- Plan the implementation
- Code with clear direction
- Get it right the first time

**Time Saved:** 1-3 hours

---

## Pitfall #3: Skipping Tests

**Bad Pattern:**
- Implement fix
- Think "I'll add tests later"
- Submit PR without tests
- Reviewers ask for tests
- Add tests after the fact
- Discover edge cases that break the fix
- Fix breaks
- Cycle continues

**Time Lost:** 1-2 days

**Good Pattern:**
- Write test first (TDD) or alongside fix
- Tests document expected behavior
- Edge cases discovered during implementation
- Fix is solid from the start
- Reviewers trust the tests

**Time Saved:** 1 day

---

## Pitfall #4: Moving Too Slowly

**Bad Pattern:**
- Start investigating issue
- Take a break
- Come back next day
- Implement fix slowly
- Submit PR after 2-3 days
- Someone else's PR was merged yesterday

**Result:** Your PR is superseded

**Good Pattern:**
- Start investigating issue
- Work continuously for 3-4 hours
- Implement fix with tests
- Submit PR same day
- First to ship

**Result:** Your PR is merged

---

## Pitfall #5: Ignoring Project Conventions

**Bad Pattern:**
- Use your preferred coding style
- Use different test framework than project uses
- Structure code differently than rest of codebase
- Reviewers ask for style changes
- Resubmit

**Time Lost:** 1-2 review cycles (4-8 hours)

**Good Pattern:**
- Read CONTRIBUTING.md first
- Study existing code patterns
- Follow project conventions
- PR fits seamlessly with codebase
- Merged quickly

**Time Saved:** 1 review cycle

---

## Pitfall #6: Poor PR Communication

**Bad Pattern:**
- Vague PR title: "Fix bug"
- No description
- Reviewers have to ask: "What does this do?"
- Back and forth clarification
- PR stalls

**Time Lost:** 1-2 days

**Good Pattern:**
- Clear PR title: "[Bug] Fix: Telegram Forum implicitMention triggers on topic creation"
- Structured description:
  - Problem summary
  - Root cause analysis
  - Solution overview
  - Testing evidence
  - Breaking changes
- Reviewers understand immediately
- PR moves forward

**Time Saved:** 1 day

---

## Pitfall #7: Large Monolithic PRs

**Bad Pattern:**
- Fix the bug
- Refactor related code
- Add unrelated improvements
- 800+ line diff
- Reviewers overwhelmed
- "Can you split this into smaller PRs?"
- Resubmit in pieces

**Time Lost:** 1-2 days

**Good Pattern:**
- Focus on fixing the bug only
- Small, reviewable diff (< 400 lines)
- Clear, single purpose
- Reviewers can review quickly
- Merged

**Time Saved:** 1 day

---

## Pitfall #8: Not Responding to Reviews

**Bad Pattern:**
- Submit PR
- Reviewer requests changes
- Don't respond for 2 days
- Reviewer moves on
- PR stalls
- Eventually closed as stale

**Result:** PR abandoned, time wasted

**Good Pattern:**
- Submit PR
- Reviewer requests changes
- Respond within 2 hours
- Make requested changes
- Push update
- Comment on PR
- Reviewer responds
- Merged

**Result:** PR merged in 1-2 review cycles

---

## Summary: The Speed Formula

**Fast PR = (Research + Tests + Conventions + Communication) × Quick Responses**

- **Research**: 2-3 hours upfront saves 1-2 days later
- **Tests**: 1 hour upfront saves 1 day of back-and-forth
- **Conventions**: 30 minutes studying patterns saves 4-8 hours of style fixes
- **Communication**: 15 minutes writing clear description saves 1 day of clarification
- **Quick Responses**: Responding within hours vs days keeps momentum

**Total Time Saved:** 3-5 days per PR

**Result:** Ship 3-5x faster, get 3-5x more PRs merged