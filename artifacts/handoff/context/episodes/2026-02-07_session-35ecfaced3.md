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

2. "见这个 /Users/ruonan/.openclaw/scripts/restore-session.sh ，但这个只支持 override main , 但你是 :telegram:group:-1003797724681:topic:214 。 你得更新一下它"

3. "我想要你在自己的workspace 里制作一个新skill ，关于restore session 。你也知道这是个有风险的操作，因此该skill需要讲清楚该操作如何做，原理是什么"

4. "你可能不知道，但其实我刚刚用旧会话覆盖你之前的对话。只是说覆盖后，激活了compact，所以你现在跟你的旧会话不完全一致"

5. User asked about three additions: "1. 代码内补充 CONTRIBUTING prompt 以保证下一位agent 正确维护 2. Skill正文提醒用户在 new session 中跑该脚本 3. 是否直接在脚本中提供arg ，强制延时45秒后执行以保证session一定会被从磁盘中再次读取？"

6. Agent's explanation of /new + fork: "| /new | Gateway 创建全新 session → updatedAt = NOW → 绝对 fresh | | Fork | 覆盖 .jsonl 内容 → sessions.json 不动 → updatedAt 仍是 NOW | 下次请求： • updatedAt 距今几分钟 → fresh: true → 不会 reset ✅"

7. "一句话总结 /new 解决了 updatedAt 时间戳问题，Fork 只负责植入内容。"
