---
name: yage-writer
description: Write yage.ai-style deep tech analysis (深度拆解/Deep News) from source material, or audit a draft against the pattern. Triggers - "yage 风格", "深度拆解文章", "deep news 写法", "按 yage 模板写".
compatibility: OpenClaw
metadata: {author: RadonX, version: "1.0"}
---

# yage-writer

双层写作系统：稳定系统层模板 + 极短每篇 prompt。禁止把系统模板内联进每篇指令。

## Interface
`/yage-writer <mode> [input]` — modes: outline | write | audit. Default: outline.
Input: URLs / 粘贴素材（write、outline）或草稿（audit）。

## Parsing (hard)
首 token 必须是三个 mode 之一；否则显示 help 并要求重述。

## Routing
- outline → SYSTEM-TEMPLATE.md + GENRES.md
- write → SYSTEM-TEMPLATE.md + GENRES.md + FRAMEWORK-ACTION.md + QC.md（全量）
- audit → QC.md + SYSTEM-TEMPLATE.md
- help → HELP.md

## Guardrails
1. 承重数字/引语必须可溯源到素材；无法核实 → 标"未核验"，禁止编造。
2. 框架来源层级：借源 > 复用自己 > 注入（见 FRAMEWORK-ACTION.md）。注入框架必须过压力测试，否则显式自称"镜头"。
3. 结尾必须是可带走的工具（阶梯/清单/情景树/金丝雀指标），不许以观点收尾。
4. 模型免费提供的修辞（不是A是B、对称计数、2x2）不写进指令——指令只写策略（算账/纠偏/边界）。
5. 默认输出到对话；仅明确要求时写文件。
