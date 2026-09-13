# Description criteria (from the OpenAI GPT-6 Astra article)

A good description = <what it produces> + <precise trigger>. Test: could a
model deciding "which skill, if any" pick correctly from this line alone?

1. **Lead with function, not marketing.** Delete vision statements ("give
   your agent eyes to see the entire internet"), philosophy, emoji pitches.
2. **Trigger = a concrete event, not a topic.** "Use when adding/changing a
   migration" ✓. "Use when working with databases" ✗ (fires on every touch).
3. **One sentence per distinct trigger branch, in the first 60 chars** where
   possible; total under ~160 bytes.
4. **No capability inventories.** A list of 10 nouns means nothing narrows.
   Keep at most 2-3 example intents.
5. **Resolve overlap by narrowing, not competing.** If two skills cover the
   same territory, each keeps only its differentiating trigger.
6. **State scope limits when they prevent misfires** ("Description-only in
   v0.1" style), not as filler.
7. **Translate user phrases → triggers** when users invoke in Chinese
   ('优化skill', '白话说' …). Match the language users actually use.

Bad→Good pattern from the article:
- Bad: "Create and validate Postgres schema migrations. Use when working
  with databases, queries, models, or persistence."
- Good: "Create and validate Postgres schema migrations. Use when adding or
  changing a migration, or reviewing its rollout."
