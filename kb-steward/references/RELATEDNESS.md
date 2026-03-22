# Relatedness linking (lightweight)

Goal: link 0–3 truly related notes.

## Method
1) Extract 3–8 keywords from title/source.
2) `rg -i -l '<kw1>|<kw2>|...' <kbRoot>/10-Projects <kbRoot>/30-Research <kbRoot>/20-Areas`
3) Add best matches to `related_docs` as wikilinks.

## Guardrails
- Do not create new notes just to link.
- If nothing matches, leave empty.
