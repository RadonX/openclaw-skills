---
title: "github-issue-methodology context (source-to-notes)"
date: "2026-03-18"
source: "session-logs"
inputs:
  - "artifacts/github-issue-methodology/context/2026-03-18_session-full-history.md"
models_observed:
  - "Model switched to gemini-local/gemini-2.5-flash."
  - "Model switched to gemini-local/gemini-2.5-flash.\nSystem: [2026-02-24 00:54:45 PST] Model switched to gemini-local/gemini-2.5-pro.\n\nConversation info (untrusted metadata):\n```json\n{\n  "message_id": "2224",\n  "sender_id": "8245211057",\n  "conversation_label": "钛金之星 id:-1003792208107 topic:1010",\n  "sender": "8245211057",\n  "group_subject": "钛金之星",\n  "is_forum": true\n}\n```\n\nSender (untrusted metadata):\n```json\n{\n  "label": "磨坊主 大人",\n  "name": "磨坊主 大人"\n}\n```\n\n行，你来扫描吧，可以按照 Git History 作为参考。"
  - "Model switched to gemini-local/gemini-2.5-pro."
  - "Model switched to gemini-local/gemini-2.5-pro`  "
  - "Model switched to google-antigravity/gemini-3-flash."
  - "Model: ...`"
  - "Model: ...`、`Updated: YYYY-MM-DD`"
  - "Model: ...`、`Updated: YYYY-MM-DD`\n- 必须包含两个段落（顺序不强制，但都要有）：\n  - `Goal:` 单行\n  - `Invariants:` 后面是 `- ` 列表\n\n输出永远规范化成：\n```md\n# <title>\n\nModel: <model>\nUpdated: <date>\n\n## Goal\n...\n\n## Target state (invariants)\n- ...\n```\n\n---\n\n## File tree\n```\nintent-writer/\n  SKILL.md\n  references/\n    HELP.md\n    DEFAULT.md\n    APPLY.md\n```\n\n---\n\n## `intent-writer/SKILL.md`（router，短）\n```markdown\n---\nname: intent-writer\ndescription: Produce a minimal INTENT.md from a short spec block (Goal + Invariants). Interface is 1 path argument + text body. Enforces header block (Title/Model/Updated) and minimal sections.\ncompatibility: OpenClaw\nmetadata:\n  author: skill-distiller-gemini\n  version: "1.0"\n---\n\n# intent-writer\n\n## Interface\n- `/intent-writer help`\n- `/intent-writer propose <path-or-dir> <spec-block>`\n- `/intent-writer apply <path-or-dir> <spec-block>`\n\n## Parsing rules (hard)\n- Subcommand required: `help|propose|apply`.\n- `<path-or-dir>` required for `propose|apply`.\n- The remainder of the message is `<spec-block>` (freeform text).\n- `<spec-block>` must contain:\n  - `Goal:` (single line)\n  - `Invariants:` followed by one or more `- ...` bullets\n- Optional in `<spec-block>`:\n  - `# <title>` line\n  - `Model: ...`\n  - `Updated: YYYY-MM-DD`\n\n## Which references to read\n- Always: `references/DEFAULT.md`\n- If `help`: also read `references/HELP.md`\n- If `apply`: also read `references/APPLY.md`\n\n## Guardrails (intent discipline)\n- Output must be minimal: header + Goal + Target state (invariants). No runbooks/procedures.\n- Invariants should be implementation-agnostic unless explicitly stated in the input.\n- Proposal-first by default; never write without `apply` or explicit user request.\n```\n\n---\n\n## `intent-writer/references/DEFAULT.md`\n```markdown\n# DEFAULT (propose)\n\n## Path resolution\n- If argument is a directory, destination is `<dir>/INTENT.md`.\n- If argument is a file path:\n  - if it ends with `.md`, write exactly there\n  - otherwise treat it as a directory and append `/INTENT.md`\n\n## Spec parsing (minimal)\nExtract:\n- title:\n  - from a leading `# ...` line if present\n  - else infer from destination parent folder basename, e.g. `<name> stow package`\n- model:\n  - from `Model:` if present, else default `gpt-5.2`\n- updated:\n  - from `Updated:` if present, else today (local date)\n- goal:\n  - value after `Goal:`\n- invariants:\n  - bullets under `Invariants:` (`- ...`)\n\n## Output format (fixed)\nRender exactly:\n\n```md\n# <title>\n\nModel: <model>\nUpdated: <YYYY-MM-DD>\n\n## Goal\n<goal>\n\n## Target state (invariants)\n- <inv1>\n- <inv2>\n...\n```\n\n## Behavior\n- Print resolved absolute destination path.\n- Print full content.\n- Do not write.\n```\n\n---\n\n## `intent-writer/references/APPLY.md`\n```markdown\n# APPLY (writes)\n\n- Apply the same parsing/output as DEFAULT.md.\n- Before writing:\n  - print absolute destination path\n  - print full file content\n- Then write/overwrite the destination file.\n- Do not run git commit unless user explicitly asks.\n```\n\n---\n\n## `intent-writer/references/HELP.md`\n```markdown\n# intent-writer help\n\nWrite an INTENT.md from a short spec block.\n\nExample:\n\n/intent-writer propose ~/repo/dotfiles/zsh\n# zsh stow package\nModel: gpt-5.2\nUpdated: 2026-02-13\n\nGoal: Manage Zsh via GNU Stow under modern XDG, with secrets kept out of git.\nInvariants:\n- Only $HOME artifact: ~/.zshenv → stow-managed.\n- Secrets: optional ~/.config/secrets/zsh.env (never in git).\n- Interactive config: modular + deterministic load order.\n```\n\n---\n\n两个确认点（不涉及实现细节，只是边界）：\n1) `Goal:` 是否允许多行？我建议 **单行**（强迫极简）。  \n2) `Updated:` 如果没给，是用本地日期（America/Los_Angeles）可以吗？\n\n你说 “apply” 我就把这个 skill 写到 `~/repo/config/openclaw/skills/intent-writer/`。"
  - "Model: <model>"
  - "Model: <model>\n  Updated: <YYYY-MM-DD>\n  ```\n  (and *not* as a single-line title; and no extra Audience/Author lines)\n- Prefer **implementation-agnostic** invariants when you chose A:\n  - “interactive config is modularized; deterministic ordering required”\n  - avoid hardcoding `conf.d` / `--no-folding` in the intent\n\n### Final accepted shape (ground truth)\n- Ultra-short `INTENT.md` with:\n  - the 3-line header block (title + Model + Updated)\n  - one “Goal”\n  - a concise “Target state (invariants)” list, written idiomatically\n\n---\n\n## Proposed file tree\n\n```\n~/repo/config/openclaw/skills/intent-md/\n  SKILL.md\n  references/\n    HELP.md\n    FORMAT.md\n    APPLY.md\n```\n\n---\n\n## `intent-md/SKILL.md`\n\n```markdown\n---\nname: intent-md\ndescription: Create/refresh a minimal, LLM-oriented INTENT.md for a dotfiles subpackage (e.g. zsh stow package). Enforces the exact header block format and keeps only minimal goal + invariants (implementation-agnostic).\ncompatibility: OpenClaw\nmetadata:\n  author: skill-distiller (from session history)\n  version: "1.0"\n---\n\n# intent-md\n\nGenerate a **minimal** `INTENT.md` intended for an LLM operator (not a human runbook).\n\n## Interface\n\n- `/intent-md help`\n- `/intent-md propose <package> [--model <model>] [--updated <YYYY-MM-DD>]`\n- `/intent-md apply <package> [--model <model>] [--updated <YYYY-MM-DD>]`\n\nDefaults:\n- `--model gpt-5.2`\n- `--updated <today>` (local date)\n\n## Hard parsing rules\n\n- First token after `/intent-md` must be one of: `help|propose|apply`.\n- `<package>` is required for `propose|apply`.\n- Unknown flags → show help and stop.\n\n## References to read (routing)\n\n- Always read: `references/FORMAT.md`\n- If `help`: read `references/HELP.md`\n- If `apply`: read `references/APPLY.md`\n\n## Output constraints (must follow)\n\n- The header format is **exactly**:\n\n  ```\n  # <package> stow package\n\n  Model: <model>\n  Updated: <YYYY-MM-DD>\n  ```\n\n- Do **not** include: Audience/Author/persona lines, long explanations, step-by-step runbooks.\n- Keep body minimal: `## Goal` + `## Target state (invariants)` only.\n- Invariants must be **implementation-agnostic** unless user explicitly requests specifics.\n\n## Safety\n\n- Default mode is **proposal-only**.\n- Never write/edit files unless explicitly invoked with `apply` or user explicitly says “apply/write it”.\n- Before applying, print:\n  - absolute destination path\n  - full file content\n  - ask for confirmation if user did not explicitly request apply.\n```\n\n---\n\n## `intent-md/references/HELP.md`\n\n```markdown\n# intent-md — Help\n\n## What it does\nCreates a minimal `INTENT.md` for a dotfiles subpackage (e.g. `zsh/`) that is meant to guide an LLM operator.\n\n## Commands\n\n### Propose\n`/intent-md propose <package> [--model gpt-5.2] [--updated YYYY-MM-DD]`\n\nOutputs:\n- destination path: `~/repo/dotfiles/<package>/INTENT.md`\n- full proposed content\n\n### Apply\n`/intent-md apply <package> [--model gpt-5.2] [--updated YYYY-MM-DD]`\n\nWrites the file (with confirmation rules in APPLY.md).\n\n## Notes\n- Minimal means: no runbook steps; only goal + invariants.\n- Implementation-agnostic means: describe constraints, not the particular mechanism (unless requested).\n```\n\n---\n\n## `intent-md/references/FORMAT.md`\n\n```markdown\n# INTENT.md format (minimal, LLM-oriented)\n\n## Header (exact)\nMust be:\n\n```md\n# <package> stow package\n\nModel: <model>\nUpdated: <YYYY-MM-DD>\n```\n\nNo other header metadata.\n\n## Body (minimal)\nOnly two sections:\n\n```md\n## Goal\n<one sentence>\n\n## Target state (invariants)\n- <short bullets>\n```\n\n### Style rules\n- Concise, idiomatic bullets.\n- Prefer invariants over procedures.\n- Avoid pinning to a particular layout (`conf.d`, `--no-folding`, etc.) unless user explicitly asks.\n```\n\n---\n\n## `intent-md/references/APPLY.md`\n\n```markdown\n# Apply rules (writes)\n\n## Default behavior\nProposal-first.\n\n## Destination\nWrite to:\n`~/repo/dotfiles/<package>/INTENT.md`\n\n## Before writing\n- Print the absolute destination path.\n- Print the full content to be written.\n- If the user did not explicitly request apply, ask for confirmation.\n\n## After writing (optional if repo is git)\n- Show `git diff` for the changed file.\n- Commit only if the user asked to commit.\n```\n\n---\n\n## Open questions (only if you want to refine)\n1) Should the skill *also* update `Model:` automatically from the runtime model, or keep the default `gpt-5.2` unless overridden?\n2) Should the destination always be `~/repo/dotfiles/<package>/INTENT.md`, or allow `--repo <path>`?\n\nIf you say “apply this skill”, I’ll write these files under `~/repo/config/openclaw/skills/intent-md/` (proposal-first rules still apply unless you explicitly say apply)."
  - "Model: <model>\nUpdated: <YYYY-MM-DD>\n```\n\n## Body (required, minimal)\n\n```md\n## Goal\n<single sentence>\n\n## Target state (invariants)\n- <bullet 1>\n- <bullet 2>\n...\n```\n\n## Style constraints\n\n- Keep to the minimum needed to infer the target.\n- Prefer invariants over procedures.\n- Avoid hardcoding a particular implementation unless the user explicitly includes it as an invariant.\n```\n\n---\n\n## `intent-writer/references/PROPOSE.md`\n\n```markdown\n# Propose mode\n\nGiven inputs (path, title, model, updated, goal, invariants):\n- Render the INTENT.md content exactly per FORMAT.md.\n- Print the resolved absolute destination path.\n- Output the full file content (no diffs unless requested).\n- Do not write files.\n```\n\n---\n\n## `intent-writer/references/APPLY.md`\n\n```markdown\n# Apply mode (writes)\n\n## Safety\n\n- Print the resolved absolute destination path.\n- Print the full content to be written.\n- If the user invoked `apply`, proceed to write without an extra confirmation (they already opted in).\n- If the user asked conversationally (“write it”) without `apply`, ask for confirmation.\n\n## Git (optional)\n\nIf the destination is inside a git repo:\n- show `git diff` after writing\n- do not commit unless the user explicitly asks\n```\n\n---\n\n## `intent-writer/references/HELP.md`\n\n```markdown\n# intent-writer help\n\n## Commands\n\n### propose\nCreate an INTENT.md proposal without writing.\n\n### apply\nWrite INTENT.md to disk (safe, path-printed, content-printed).\n\n## Example\n\n/intend-writer propose ~/repo/dotfiles/zsh/INTENT.md \\\n  --title "zsh stow package" \\\n  --model "gpt-5.2" \\\n  --updated "2026-02-13" \\\n  --goal "Manage Zsh via GNU Stow under modern XDG, with secrets kept out of git." \\\n  --invariant "Only $HOME artifact: ~/.zshenv → stow-managed." \\\n  --invariant "Secrets: optional ~/.config/secrets/zsh.env (never in git)."\n```\n\n---\n\n### One clarification (to avoid another mismatch)\nDo you want the skill to **default `<path>`** to `~/repo/dotfiles/<package>/INTENT.md` when you pass a package name instead of a path, or should it always require an explicit path?\n\nIf you say “apply the skill”, I’ll write the skill files into `~/repo/config/openclaw/skills/intent-writer/`."
  - "Model: <provider/model>`，或系统显式 “Model switched to …”"
  - "Model: gpt-5.2"
  - "Model: gpt-5.2 / Updated: 2026-02-13`）就是你说的那个最小标头语义，对齐 OK。"
  - "Model: gpt-5.2 Updated: 2026-02-13"
  - "Model: gpt-5.2 Updated: 2026-02-13 2. Current ## Target state (invariants) section can be more concise idiomatic"
  - "Model: gpt-5.2 Updated: 2026-02-13 2. seems you also inferred something that are not told by me directly. can you just explain?"
  - "Model: gpt-5.2 Updated: 2026-02-13`"
  - "Model: gpt-5.2\nUpdated: 2026-02-13""
  - "Model: gpt-5.2\nUpdated: <YYYY-MM-DD>\n\n## Goal\n...\n\n## Target state (invariants)\n- ...\n```\n\n### Non-interaction rule\n- 默认**不提问**。标题/Goal/不变量都从 session 推断。\n- 只有在“无法从 session 得到任何约束/主题”的极端情况下，才返回一个最小错误提示（而不是追问）。\n\n---\n\n## File tree\n```\nintent-writer/\n  SKILL.md\n  README.md\n  references/\n    HELP.md\n    DEFAULT.md\n    EXTRACTION.md\n```\n\n---\n\n## `intent-writer/SKILL.md` (router, short)\n\n```markdown\n---\nname: intent-writer\ndescription: Distill the current session into a minimal INTENT.md (Goal + Target state invariants). Zero-arg. No file writes. No questions by default.\ncompatibility: OpenClaw\nmetadata:\n  author: skill-distiller-gemini\n  version: "1.0"\n  openclaw:\n    emoji: "🧭"\n---\n\n# intent-writer\n\n## Interface\n- `/intent-writer` (default)\n- `/intent-writer help`\n\n## Parsing rules (hard)\n- If the first token is `help`, show help.\n- Otherwise treat the entire invocation as DEFAULT.\n\n## References to read\n- Always: `references/DEFAULT.md` + `references/EXTRACTION.md`\n- If `help`: also `references/HELP.md`\n\n## Guardrails (intent discipline)\n- Output must be minimal: header + `## Goal` + `## Target state (invariants)` only.\n- No procedures/runbooks. No implementation details unless explicitly demanded by the user in-session.\n- Zero-arg. No file writes.\n- Prefer not to ask; only emit an error if session content is insufficient.\n```\n\n---\n\n## `intent-writer/references/DEFAULT.md`\n\n```markdown\n# DEFAULT\n\n## Source\nUse the current session history as the only input.\n\n## Output format (fixed)\nRender exactly:\n\n```md\n# <title>\n\nModel: gpt-5.2\nUpdated: <YYYY-MM-DD>\n\n## Goal\n<one sentence>\n\n## Target state (invariants)\n- ...\n```\n\n## Defaults (no asking)\n- `Model:` default `gpt-5.2`\n- `Updated:` default local date `YYYY-MM-DD`\n- `<title>` inferred from the active topic; fallback: `intent`\n- Goal is one sentence.\n- Invariants: keep only the constraints that would cause user rejection if violated.\n```\n\n---\n\n## `intent-writer/references/EXTRACTION.md`\n\n```markdown\n# Extraction rules (session → intent)\n\n## Topic → Title\nInfer the most recent sustained thread; title should be short and concrete.\nNo questions; pick the best guess.\n\n## Goal\nOne sentence: what artifact/outcome the human wanted from the interaction.\n\n## Invariants\nExtract from user corrections/constraints, especially:\n- “too specific” → make it implementation-agnostic\n- “too many args” → zero/low-arg interface\n- “INTENT is for LLM” → minimal spec, no runbook\n- exact formatting constraints (header block, allowed sections)\n\nKeep 5–9 bullets; drop anything that is merely “nice to have”.\n\n## Anti-bloat rule\nIf a line reads like instructions, delete it or rewrite it as an invariant.\n```\n\n---\n\n## `intent-writer/README.md` (human-facing, tiny)\n\n```markdown\n# intent-writer\n\nGenerates a minimal `INTENT.md` by distilling the current session into:\n- a one-sentence Goal\n- a short list of invariants\n\nZero-arg. No file writes. Minimal output only.\n```\n\n---\n\n如果你点头“apply skill”，我就把这套文件写到：\n`~/repo/config/openclaw/skills/intent-writer/`\n\n你如果还想更极致（连 `/intent-writer help` 都不要，只保留 `/intent-writer`），也可以。"
  - "Model: gpt-5.2\nUpdated: <YYYY-MM-DD>\n\n## Goal\n...\n\n## Target state (invariants)\n- ...\n```\n\n### Safety\n- propose：只打印 path + 全文，不写\n- apply：打印 path + 全文，然后写入（不自动 git commit）\n\n---\n\n如果你认可这个 one-arg 版本，我就按 `skill-distiller-gemini` 的结构再给出最终的文件树+内容（SKILL.md router + references/），然后你一句 “apply” 我再写到 `~/repo/config/openclaw/skills/intent-writer/`。"
  - "Model: gpt-5.2\nUpdated: <YYYY-MM-DD>\n\n## Goal\n<one sentence>\n\n## Target state (invariants)\n- ...\n```\n\n## Behavior\n- Print resolved absolute destination path.\n- Print full content.\n- Do not write.\n```\n\n---\n\n## `intent-writer/references/EXTRACTION.md` (关键：从 session 抽取)\n```markdown\n# Extraction rules (session → intent)\n\n## What to extract\n1) Topic/title\n- Use `--topic` if provided.\n- Else infer from the most recent sustained thread.\n\n2) Goal (one sentence)\n- What artifact are we trying to create and why?\n- Keep it outcome-oriented, not procedural.\n\n3) Invariants (bullets)\nExtract primarily from user corrections and constraints, e.g.:\n- “too specific” → make it domain-agnostic\n- “too many args” → minimal interface\n- “INTENT is for LLM” → no runbook steps\n- exact header formatting requirements\n- safety boundaries (“proposal-first”, etc.) only if user demanded it\n\n## What NOT to include\n- Step-by-step instructions\n- Implementation details that were not explicitly required\n- “We intentionally …” narrative rationale\n\n## Selection heuristic\nKeep only invariants that, if violated, would make the user reject the result.\nPrefer 5–9 bullets.\n```\n\n---\n\n## `intent-writer/references/APPLY.md`\n```markdown\n# APPLY (writes)\n\n- Use the same extraction + rendering as DEFAULT.\n- Before writing: print absolute path + full content.\n- Then write/overwrite the destination.\n- Do not commit unless user explicitly asks.\n```\n\n---\n\n## Key question（为了真的按 “from the session” 做到位）\n你说的“session”是：\n- A) **当前这个会话**（就是我们这条 Telegram thread 的上下文）\n- B) 指定一个 sessionKey（跨会话 distill，需要 `sessions_history`）\n\n如果是 A（我默认），我就能把 skill 设计为：直接读取当前 session history。  \n你确认 A 吗？确认后我再把这个 skill 变成最终版本并（如果你说 apply）写入到 `~/repo/config/openclaw/skills/intent-writer/`。"
  - "Model: openai-codex...` 那套都没了），INTENT 顶部就是你要的 block："
  - "Model: openai-codex/gpt-5.2"
  - "Model: openai-codex/gpt-5.2 Updated: 2026-02-13 。 squash 一下这些愚蠢的 INTENT header commits"
  - "Model: openai-codex/gpt-5.2 · ...`  "
  - "Model: openai-codex/gpt-5.2 · 🔑 oauth (openai-codex:default)\n🧮 Tokens: 793 in / 797 out\n🗄️ Cache: 99% hit · 109k cached, 0 new\n📚 Context: 1.6k/272k (1%) · 🧹 Compactions: 0\n📊 Usage: 5h 100% left ⏱4h 59m · Week 53% left ⏱9h 31m\n🧵 Session: agent:main:telegram:group:-1003792208107:topic:1010 • updated just now\n⚙️ Runtime: direct · Think: low · elevated\n👥 Activation: always · 🪢 Queue: collect (depth 0)""
---

## Summary
(auto) Historical session context extracted for github-issue-methodology. See the raw extract for complete text.

## Excerpts (hits)
---
title: "github-issue-methodology context (historical session logs snippets)"
date: "2026-03-18"
source: "session-logs"
note: "Oldest 3 + newest 3 sessions mentioning this skill (file names redacted in frontmatter)."
sessions_indexed_count: 6
---

## Source: (redacted)

498-lrwxr-xr-x@  1 ruonan  staff    95 Feb 23 14:03 bindings-simplifier -> /Users/ruonan/repo/config/openclaw/public/openclaw-agent-claw-config/skills/bindings-simplifier
499-drwxr-xr-x@  3 ruonan  staff    96 Feb  8 16:05 bird
500-drwxr-xr-x@  4 ruonan  staff   128 Feb  6 22:57 gateway-healthcheck
501:drwxr-xr-x@  5 ruonan  staff   160 Mar  2 16:10 github-issue-methodology
502-lrwxr-xr-x@  1 ruonan  staff    52 Feb 11 01:44 kb-steward -> /Users/ruonan/repo/config/openclaw/skills/kb-steward
503-lrwxr-xr-x@  1 ruonan  staff    58 Feb 23 11:32 kb-steward-tools -> /Users/ruonan/repo/config/openclaw/skills/kb-steward-tools
504-drwxr-xr-x@  3 ruonan  staff    96 Feb  3 17:24 openclaw-source-of-truth
--
1195-	memory/2026-03-11.md
1196-	memory/2026-03-12.md
1197-	reports/
1198:	skills/github-issue-methodology/
1199-	skills/upgrade-guardian
1200-	tmp/actionable_task_list.sh
1201-	tmp/issue_body.md
--
1626-	../workspace-claw-config/memory/2026-03-11.md
1627-	../workspace-claw-config/memory/2026-03-12.md
1628-	../workspace-claw-config/reports/
1629:	../workspace-claw-config/skills/github-issue-methodology/
1630-	../workspace-claw-config/skills/upgrade-guardian
1631-	../workspace-claw-config/tmp/actionable_task_list.sh
1632-	../workspace-claw-config/tmp/issue_body.md
--
2531-?? workspace-claw-config/memory/2026-03-12.md
2532-?? workspace-claw-config/reports/
2533-?? workspace-claw-config/skills/config-workflow/
2534:?? workspace-claw-config/skills/github-issue-methodology/
2535-?? workspace-claw-config/skills/upgrade-guardian
2536-?? workspace-claw-config/tmp/actionable_task_list.sh
2537-?? workspace-claw-config/tmp/issue_body.md
--
2632-	../workspace-claw-config/memory/2026-03-12.md
2633-	../workspace-claw-config/reports/
2634-	../workspace-claw-config/skills/config-workflow/
2635:	../workspace-claw-config/skills/github-issue-methodology/
2636-	../workspace-claw-config/skills/upgrade-guardian
2637-	../workspace-claw-config/tmp/actionable_task_list.sh
2638-	../workspace-claw-config/tmp/issue_body.md
--
2743-	../workspace-claw-config/memory/2026-03-12.md
2744-	../workspace-claw-config/reports/
2745-	../workspace-claw-config/skills/config-workflow/
2746:	../workspace-claw-config/skills/github-issue-methodology/
2747-	../workspace-claw-config/skills/upgrade-guardian
2748-	../workspace-claw-config/tmp/actionable_task_list.sh
2749-	../workspace-claw-config/tmp/issue_body.md
--
3139-	../workspace-claw-config/memory/2026-03-12-1841.md
3140-	../workspace-claw-config/memory/2026-03-12.md
3141-	../workspace-claw-config/reports/
3142:	../workspace-claw-config/skills/github-issue-methodology/
3143-	../workspace-claw-config/skills/upgrade-guardian
3144-	../workspace-claw-config/tmp/actionable_task_list.sh
3145-	../workspace-claw-config/tmp/issue_body.md
--
3326-	../workspace-claw-config/memory/2026-03-12-1841.md
3327-	../workspace-claw-config/memory/2026-03-12.md
3328-	../workspace-claw-config/reports/
3329:	../workspace-claw-config/skills/github-issue-methodology/
3330-	../workspace-claw-config/skills/upgrade-guardian
3331-	../workspace-claw-config/tmp/actionable_task_list.sh
3332-	../workspace-claw-config/tmp/issue_body.md

## Source: (redacted)

5184-[toolResult] README.md
5185-_CONVENTIONS.yaml
5186-commit-message
5187:github-issue-methodology
5188-handoff
5189-intent-writer
5190-kb-steward
--
5963- M skill-distiller/decisions.yaml
5964- M source-to-notes/decisions.yaml
5965-?? bindings-simplifier/decisions.yaml
5966:?? github-issue-methodology/decisions.yaml
5967-[toolResult] M commit-message/decisions.yaml
5968- M handoff/decisions.yaml
5969- M intent-writer/decisions.yaml
--
5973- M skill-distiller/decisions.yaml
5974- M source-to-notes/decisions.yaml
5975-?? bindings-simplifier/decisions.yaml
5976:?? github-issue-methodology/decisions.yaml
5977-?? handoff/docs/
5978-?? intent-writer/README.md
5979-?? intent-writer/SKILL.md
--
5984---- staged ---
5985-bindings-simplifier/decisions.yaml
5986-commit-message/decisions.yaml
5987:github-issue-methodology/decisions.yaml
5988-handoff/decisions.yaml
5989-intent-writer/decisions.yaml
5990-kb-steward-companion/decisions.yaml
--
5996-[main 7728a2e] skills: regenerate decisions.yaml from git history
5997- 11 files changed, 312 insertions(+), 101 deletions(-)
5998- create mode 100644 bindings-simplifier/decisions.yaml
5999: create mode 100644 github-issue-methodology/decisions.yaml
6000- create mode 100644 kb-steward-companion/decisions.yaml
6001-7728a2e skills: regenerate decisions.yaml from git history
6002-[toolResult] == bindings-simplifier ==
--
6027-```
6028-
6029-
6030:== github-issue-methodology ==
6031-total 32
6032-drwxr-xr-x@  7 ruonan  staff   224 Mar 18 01:49 .
6033-drwxr-xr-x@ 18 ruonan  staff   576 Mar 18 01:46 ..
--
6037--rw-------@  1 ruonan  staff   569 Mar 18 01:49 decisions.yaml
6038-drwxr-xr-x@  5 ruonan  staff   160 Mar  2 16:29 references
6039----
6040:name: github-issue-methodology
6041-description: Systematic methodology for addressing GitHub issues: investigate, fix, validate, and merge PRs quickly (6-12 hours from issue to merge).
6042-compatibility: OpenClaw
6043-metadata:
--
6045-  version: "1.0"
6046----
6047-
6048:# github-issue-methodology
6049-
6050-Comprehensive methodology for investigating, fixing, and validating GitHub issues in any open-source project. Emphasizes autonomous research, exploration of existing patterns, and comprehensive testing to ship quality fixes quickly.
6051-
6052-## Interface
6053-
6054:- `/github-issue-methodology help`
6055:- `/github-issue-methodology investigate <issue-url> [--project <path>]`
6056:- `/github-issue-methodology workflow [--step <all|investigate|implement|validate|submit>]`
6057:- `/github-issue-methodology review <pr-url>` (audit your own PR before submission)
6058-
6059-
6060-== kb-steward-companion ==
--
6090-?? intent-writer/references/
6091-?? kb-steward-tools/scripts/lint-links.sh
6092-[toolResult] wrote bindings-simplifier/meta.yaml
6093:wrote github-issue-methodology/meta.yaml
6094-wrote kb-steward-companion/meta.yaml
6095-[main d7ee9f1] skills: add meta.yaml for remaining skills
6096- 3 files changed, 54 insertions(+)
6097- create mode 100644 bindings-simplifier/meta.yaml
6098: create mode 100644 github-issue-methodology/meta.yaml
6099- create mode 100644 kb-steward-companion/meta.yaml
6100-d7ee9f1 skills: add meta.yaml for remaining skills
6101-[assistant] 对，stub 不够“精确”。我已经把 `decisions.yaml` **改成逐 commit 的精确轨迹**（每条 decision 都带 commit hash 作为来源），不再是我“根据当前状态脑补”的三条模板。
--
6115-- `7728a2e skills: regenerate decisions.yaml from git history`
6116-
6117-3) **顺手补齐漏掉的 meta**
6118:因为重建 decisions 时发现 repo 里还有 3 个 skill 之前没生成 meta（`bindings-simplifier / github-issue-methodology / kb-steward-companion`），我已补上它们的 `meta.yaml`，否则 decision log 孤零零挂着不好用：
6119-
6120-- `d7ee9f1 skills: add meta.yaml for remaining skills`
6121-
--
6646-      timestamp: "2026-03-18T08:48:26.720000+00:00"
6647-[toolResult] M bindings-simplifier/decisions.yaml
6648- M commit-message/decisions.yaml
6649: M github-issue-methodology/decisions.yaml
6650- M handoff/decisions.yaml
6651- M intent-writer/decisions.yaml
6652- M kb-steward-companion/decisions.yaml
--
6656- M skill-distiller/decisions.yaml
6657-bindings-simplifier/decisions.yaml
6658-commit-message/decisions.yaml
6659:github-issue-methodology/decisions.yaml
6660-handoff/decisions.yaml
6661-intent-writer/decisions.yaml
6662-kb-steward-companion/decisions.yaml
--
6985-artifacts/skill-distiller/context
6986-artifacts/kb-steward
6987-artifacts/kb-steward/context
6988:artifacts/github-issue-methodology
6989:artifacts/github-issue-methodology/context
6990-artifacts/source-to-notes
6991-artifacts/source-to-notes/context
6992-artifacts/skill-distiller-gemini
--
7200-        - "gemini-local/gemini-2.5-pro"
7201- M bindings-simplifier/decisions.yaml
7202- M commit-message/decisions.yaml
7203: M github-issue-methodology/decisions.yaml
7204- M handoff/decisions.yaml
7205- M intent-writer/decisions.yaml
7206- M kb-steward-companion/decisions.yaml
--
7479-A  artifacts/bindings-simplifier/context/2026-03-18_git-history.md
7480-A  artifacts/cloudflare-browser-rendering/context/2026-03-18_git-history.md
7481-A  artifacts/commit-message/context/2026-03-18_git-history.md
7482:A  artifacts/github-issue-methodology/context/2026-03-18_git-history.md
7483-A  artifacts/handoff/context/2026-03-18_git-history.md
7484-A  artifacts/intent-writer/context/2026-03-18_git-history.md
7485-A  artifacts/kb-steward-companion/context/2026-03-18_git-history.md
--
7490-A  artifacts/source-to-notes/context/2026-03-18_git-history.md
7491-M  bindings-simplifier/decisions.yaml
7492-M  commit-message/decisions.yaml
7493:M  github-issue-methodology/decisions.yaml
7494-M  handoff/decisions.yaml
7495-M  intent-writer/decisions.yaml
7496-M  kb-steward-companion/decisions.yaml
--
7506- create mode 100644 artifacts/bindings-simplifier/context/2026-03-18_git-history.md
