---
title: "github-issue-methodology context (session logs derived)"
date: "2026-03-18"
source: "session-logs"
sessions_indexed_count: 5
---

## Source: 41bb6f53-7830-44fc-938c-73362aa7f6cc-topic-1010.jsonl

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
7507- create mode 100644 artifacts/cloudflare-browser-rendering/context/2026-03-18_git-history.md
7508- create mode 100644 artifacts/commit-message/context/2026-03-18_git-history.md
7509: create mode 100644 artifacts/github-issue-methodology/context/2026-03-18_git-history.md
7510- create mode 100644 artifacts/handoff/context/2026-03-18_git-history.md
7511- create mode 100644 artifacts/intent-writer/context/2026-03-18_git-history.md
7512- create mode 100644 artifacts/kb-steward-companion/context/2026-03-18_git-history.md
--
7668-bindings-simplifier
7669-cloudflare-browser-rendering
7670-commit-message
7671:github-issue-methodology
7672-handoff
7673-intent-writer
7674-kb-steward
--
7681--rw-------@ 1 ruonan  staff  490 Mar 18 03:37 artifacts/bindings-simplifier
7682-cloudflare-browser-rendering
7683-commit-message
7684:github-issue-methodology
7685-handoff
7686-intent-writer
7687-kb-steward
--
7691-[toolResult] artifacts/bindings-simplifier
7692-cloudflare-browser-rendering
7693-commit-message
7694:github-issue-methodology
7695-handoff
7696-intent-writer
7697-kb-steward
--
7717-artifacts/bindings-simplifier
7718-cloudflare-browser-rendering
7719-commit-message
7720:github-issue-methodology
7721-handoff
7722-intent-writer
7723-kb-steward
--
7729-artifacts/bindings-simplifier
7730-cloudflare-browser-rendering
7731-commit-message
7732:github-issue-methodology
7733-handoff
7734-intent-writer
7735-kb-steward
--
7744-artifacts/skill-distiller/context
7745-artifacts/kb-steward
7746-artifacts/kb-steward/context
7747:artifacts/github-issue-methodology
7748:artifacts/github-issue-methodology/context
7749-artifacts/source-to-notes
7750-artifacts/source-to-notes/context
7751-artifacts/skill-distiller-gemini
--
7758-[toolResult] artifacts/bindings-simplifier
7759-cloudflare-browser-rendering
7760-commit-message
7761:github-issue-methodology
7762-handoff
7763-intent-writer
7764-kb-steward

## Source: ac2fffe8-c925-4e32-a430-25f2281c32a9-topic-39.jsonl

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

