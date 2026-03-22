---
title: "Skills repo metadata system (meta.yaml + decisions.yaml + durable evidence)"
date: "2026-03-18"
scope: "Define and operationalize a palimpsest-like metadata + decision-log + evidence scheme for OpenClaw skills repo; migrate away from session-pointer evidence; add artifacts/ context notes."
models_observed:
  - "openai-codex/gpt-5.2"
  - "gemini-local/gemini-2.5-flash"
  - "gemini-local/gemini-2.5-pro"
key_decisions:
  - "Adopt per-skill `meta.yaml` (contract + provenance) and `decisions.yaml` (append-only decision log) with YAML as the primary format."
  - "Use repo `~/repo/config/openclaw/skills` as the source-of-truth skills repository."
  - "Decision log policy: record only important interface/contract/behavior changes (avoid changelog noise)."
  - "Treat `meta.yaml` description as routing-only; place behavioral guardrails in SKILL.md/refs (not in description)."
  - "Add evidence to decision entries, but stop relying on `message_id` as a durable pointer; shift to artifact-backed evidence with excerpts and git references."
  - "Store durable context notes under `artifacts/` with mirrored directories; use Markdown with YAML frontmatter."
key_quotes:
  - "主要是 decision log，还有每个 skill 生成或者变更的时使用的模型。然后我 prefer YAML。 A而且 A 已经是 repo 了。"
  - "行，你来扫描吧，可以按照 Git History 作为参考。"
  - "你说得对：`message_id` 作为指针没意义（jsonl 会删）。"
  - "context notes 放在 skills repo 里，并且用 `artifacts/` 下的 mirrored dirs"
  - "从这种 status card / runtime card 里推断 possible models：按证据强度分层推断"
---

This note defines a palimpsest-like metadata system for skills: per-skill machine-readable metadata (`meta.yaml`) plus an append-only decision log (`decisions.yaml`) that records key decisions together with model provenance and durable evidence.

## Decisions

- **Per-skill metadata**
  - `meta.yaml`: stable metadata; focus on `contract` (invariants) and `provenance` (date/model/method).
  - `decisions.yaml`: append-only decisions; include durable evidence.

- **Source-of-truth repo**
  - Use `~/repo/config/openclaw/skills` as canonical.

- **Granularity**
  - Record important interface/contract/behavior changes (not a full changelog).

- **Routing vs behavior**
  - `description` in SKILL.md frontmatter is routing-only.
  - Behavior constraints live in SKILL.md guardrails / references.

## Model inference from status card

Treat model strings in runtime/status cards as evidence with tiers:
- **Observed**: explicit model strings shown for a run/segment.
- **Possible**: inferred from switches/defaults without full corroboration.

Prefer recording *observed* models; keep *possible* models separate.

## Why `message_id` is unstable

`message_id` is not durable because session logs may be deleted/rotated; the pointer is not repo-native and can’t reconstruct context later.

## Final evidence schema (durable)

For `decisions.yaml`, prefer:

```yaml
evidence:
  git:
    commit: "<hash>"
    subject: "<commit subject>"
  artifact:
    path: "artifacts/_repo/context/2026-03-18_skills-metadata-system.md"
  excerpt:
    - "<1–3 short quotes capturing the trigger>"
  summary: "<one sentence explaining why>"
  inferred_models:
    observed:
      - "<model>"
    possible:
      - "<model>"
```
