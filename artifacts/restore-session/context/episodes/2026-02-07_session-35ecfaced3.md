---
title: "Restore Session Skill Creation"
date: "2026-02-07"
skill: "handoff"
session_opaque: "35ecfaced3"
models_observed: ["unknown"]
triggers:
  - "Session corruption/pollution requiring rollback"
  - "Need to document restore-session process as a skill"
decisions:
  - "Create new 'restore-session' skill in workspace to guide safe session rollback"
  - "Emphasize /new before fork to solve updatedAt timestamp conflict"
  - "Script should set updatedAt to 10 minutes ago (not 45-second delay)"
evolution_links:
  commits: []
  changes:
    - "This episode is NOT about handoff skill evolution"
    - "Primary topic: restore-session skill creation for session rollback"
    - "User invoked /handoff command but only to check status, not to discuss handoff mechanics"
    - "No handoff-related constraints, decisions, or model signals in transcript"
    - "No relevant handoff commits around the episode date (Feb 7, 2026)"
source_refs:
  - "restore-session.sh script at ~/.openclaw/scripts/restore-session.sh"
  - "Skill location: ~/.openclaw/workspace-main/skills/restore-session/SKILL.md"
---

## Summary

User requested creation of a new skill to document the session restoration process after experiencing session corruption. The existing `restore-session.sh` script only supported main session override, but user needed it for a Telegram topic session (`agent:claw-config:telegram:group:-1003797724681:topic:214`). Agent created a comprehensive `restore-session` skill explaining the原理, risks, and the required mechanics.

## Decisions / Constraints (Human)

1. **Create skill in own workspace** - "我想要你在自己的workspace 里制作一个新skill ，关于restore session"
2. **Document risks clearly** - "你也知道这是个有风险的操作，因此该skill需要讲清楚该操作如何做，原理是什么"
3. **Three specific requirements:**
   - Add CONTRIBUTING prompt for future maintainers
   - Remind users to run script in a `/new` session
   - Consider adding 45-second delay argument to ensure session is re-read from disk

## Decisions / Actions (Assistant)

1. **Created restore-session skill** at `~/.openclaw/workspace-main/skills/restore-session/SKILL.md`
2. **Explained /new + fork mechanism:**
   - `/new` creates fresh session with `updatedAt = NOW`
   - Fork overwrites `.jsonl` content without touching `sessions.json`
   - Combined: prevents fresh session reset bug
3. **Revised 45-second delay approach:**
   - Did NOT add delay argument to script
   - Instead: script sets `updatedAt` to "10 minutes ago"
   - Rationale: `/new` already creates new process; disk-based overwrite doesn't depend on process state
4. **Included comprehensive sections:**
   - Safety warnings
   - Core principles (why `/new` is required)
   - Complete workflow
   - Script explanation
   - Troubleshooting
   - CONTRIBUTING guidance for maintainers

## Model Signals

- **No explicit model signals in transcript**
- User mentioned: "你可能不知道，但其实我刚刚用旧会话覆盖你之前的对话。只是说覆盖后，激活了compact，所以你现在跟你的旧会话不完全一致" - suggesting context was lost/truncated during the session

## Key Quotes

1. "你自己的 session 坏掉了，需要覆盖当前session | c36b85be-0937-46ca-95e2-7d89eba0e8df <br> Topic: 214 | 🔴 POLLUTED | 🟡 orphan"

2. "见这个 ~/.openclaw/scripts/restore-session.sh ，但这个只支持 override main , 但你是 :telegram:group:-1003797724681:topic:214 。 你得更新一下它"

3. "我想要你在自己的workspace 里制作一个新skill ，关于restore session 。你也知道这是个有风险的操作，因此该skill需要讲清楚该操作如何做，原理是什么"

4. "你可能不知道，但其实我刚刚用旧会话覆盖你之前的对话。只是说覆盖后，激活了compact，所以你现在跟你的旧会话不完全一致"

5. User asked about three additions: "1. 代码内补充 CONTRIBUTING prompt 以保证下一位agent 正确维护 2. Skill正文提醒用户在 new session 中跑该脚本 3. 是否直接在脚本中提供arg ，强制延时45秒后执行以保证session一定会被从磁盘中再次读取？"

6. Agent's explanation of /new + fork: "| /new | Gateway 创建全新 session → updatedAt = NOW → 绝对 fresh | | Fork | 覆盖 .jsonl 内容 → sessions.json 不动 → updatedAt 仍是 NOW | 下次请求： • updatedAt 距今几分钟 → fresh: true → 不会 reset ✅"

7. "一句话总结 /new 解决了 updatedAt 时间戳问题，Fork 只负责植入内容。"

## Relation to skill evolution

**This episode is NOT about handoff skill evolution.**

While the user invoked `/handoff@claw_config_bot` during the session, this was only to check status on a different matter. The actual conversation and decisions were entirely about:

1. Session corruption and rollback mechanics
2. Creating a new `restore-session` skill
3. Understanding how `/new` + fork avoid fresh session bugs
4. When to set `updatedAt` timestamps for session restoration

There is **no discussion** in the transcript about:
- Handoff CLI design or parsing rules
- Handoff document structure or vault layout
- Handoff subcommands (load, know)
- Handoff safety principles or propose-first patterns
- Handoff output contracts or YAML frontmatter

The candidate commits provided (from Feb 4, 2026) document handoff CLI refactoring work (`/handoff load`, `/handoff know`, progressive disclosure into `references/`), but these commits are **not related** to this Feb 7 episode about session restoration.

**Conclusion:** This episode should be tracked under the `restore-session` skill evolution log, not `handoff`. No handoff commits are relevant.
