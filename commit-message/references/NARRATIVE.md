# Commit message narrative (reference)

## Core principle

A commit message is a narrative for a future human reader. Prioritize intent and impact (why), not a mechanical list of modified files (what).

## Proportionality

Match length/detail to the conceptual scale of the change.

- Small change → short message
- Large refactor → structured body

## Structure

### Subject

Use Conventional Commits:

- `type(scope): summary`
- scope = the component most affected
- summary is concise and specific

Common `type` values: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`.

### Body

1) Start with the narrative (problem/context → high-level solution).
   - Avoid boilerplate openings like "This commit introduces...".
2) Supporting details grouped by intent.
   - Use Markdown H4 headings (`#### ...`) to group conceptual changes.
   - Bullets should describe behavior/impact, not filenames.
3) Conclude with impact (what this enables/changes).

## Accuracy constraints

- The message must reflect the diff that will be committed.
- Use conversation context only to explain the *why* of the changes actually present.

## Review checklist

- Subject follows `type(scope): summary`
- No boilerplate opening
- Body grouped by intent (H4 headings) when needed
- No overlong detail for small changes
