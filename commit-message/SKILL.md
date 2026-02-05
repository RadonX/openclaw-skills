---
name: commit-message
description: Draft a high-quality Conventional Commit message narrative from git diffs + chat context, and optionally apply it via git commit/--amend. Use when the user asks for a commit message, wants to amend a message, or says "hg-commit"/"git commit message".
compatibility: OpenClaw with host git CLI access.
metadata:
  author: RadonX
  version: "1.0"
  openclaw:
    emoji: "📝"
---

# commit-message

Draft commit messages that explain **intent + impact** (why) and stay proportional to the diff.

## Interface

This skill is designed like a small CLI:

```
/commit-message [--apply] [--amend] [--no-verify] [--repo <path>] [--type <type>] [--scope <scope>]
```

Notes:
- Without `--apply`, this skill outputs a proposed commit message only.
- `--amend` only matters with `--apply`.
- `--repo <path>` is optional; if omitted, assume the current working directory is already inside the intended repo.

## Workflow (must follow)

1) **Locate the repo**
   - If `--repo` is provided: `cd` there.
   - Else: run `git rev-parse --show-toplevel` and use that.

2) **Understand the exact commit scope**
   - Run `git status --porcelain=v1 -b`.
   - Collect diffs:
     - Staged: `git diff --staged`
     - Unstaged (context only): `git diff`
   - If nothing is staged and `--apply` is requested: stop and ask whether to stage changes first.

3) **Use conversation context for the why**
   - Use recent chat context to explain motivation, but do not claim changes that are not present in the staged diff.

4) **Draft the message narrative**
   - Follow the reference: `references/NARRATIVE.md`.
   - Choose `type(scope)` based on the staged diff; accept explicit `--type` / `--scope` overrides.
   - Keep proportionality: small diff → short body.

5) **Output**
   - Print the proposed subject line.
   - Print the body (if needed).

6) **Optional apply (`--apply`)**
   - If `--amend`: apply via `git commit --amend` with the generated message.
   - Else: `git commit` with the generated message.
   - Use `--no-verify` only if the user asked.

## Safety rules

- Never run `git push`.
- If `--apply` is not set, do not modify the repo.
- If there are multiple repos or ambiguity about which repo to commit in, ask a clarifying question.
