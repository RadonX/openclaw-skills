# Root Cause Patterns

Common failure patterns and their structural fixes.

## Table of Contents
1. Ignored Instruction
2. Overfitting to Examples
3. Wrong Architectural Layer
4. Ambiguous Scope / Missing Constraint
5. Instruction Drift (Staleness)
6. Redundancy / Contradiction

---

## 1. Ignored Instruction

**Symptom**: Agent had the right rule but didn't follow it.

**Diagnosis questions**:
- Was it buried too deep (late in the document, inside a list, in a footnote)?
- Was the imperative weak ("should" vs. "must")?
- Was it adjacent to many other rules, making it easy to skim past?

**Fix**:
- Move it earlier (before the behavior it governs)
- Strengthen modal verbs: prefer "MUST", "always", "never"
- Add a short bold callout: `**CRITICAL**: ...`
- If it applies to multiple situations, consider a dedicated section

---

## 2. Overfitting to Examples (Example-Binding)

**Symptom**: Agent behaves correctly for the given example but fails on variations.

**Root cause**: Instructions taught a specific case rather than an abstract principle.

**Fix**:
- Rewrite the rule in principle form first; add the example as a secondary illustration
- Use language like "including but not limited to", "for example"
- Ask: "Does this rule still hold if I change the example? If not, the rule is too narrow."

---

## 3. Wrong Architectural Layer

**Symptom**: Instruction placed in the wrong file; agent in a different context ignores it.

**Layer guide**:
| Layer | File | Governs |
|---|---|---|
| Identity / Values | SOUL.md | Who the agent is, core constraints |
| Behavioral rules | AGENTS.md | What the agent does, how it acts |
| Procedural mechanics | SKILL.md | How a specific task is executed |
| Reference detail | references/*.md | Lookup data, patterns, schemas |

**Fix**: Move the instruction to the correct layer. Don't duplicate across layers.

---

## 4. Ambiguous Scope / Missing Constraint

**Symptom**: Agent interprets a rule too broadly or too narrowly.

**Diagnosis**: The rule is technically true but doesn't specify its limits.

**Fix**:
- Add explicit scope: "Only applies when X", "This does not apply to Y"
- Add a counter-example: "Do NOT do Z"
- Specify what triggers the rule vs. what terminates it

---

## 5. Instruction Drift (Staleness)

**Symptom**: Old instructions no longer reflect the current system design; agent follows outdated guidance.

**Fix**:
- Remove or update the stale section
- Add changelog entry explaining the change
- If removing potentially useful context, move to a `references/` file instead of deleting

---

## 6. Redundancy / Contradiction

**Symptom**: Same rule stated in multiple places with slightly different wording; agent picks the weaker one.

**Fix**:
- Establish one authoritative location for the rule
- Remove or replace other occurrences with a pointer: "See [Section X] for authority on this"
- Ensure the authoritative version is the most complete and well-placed
