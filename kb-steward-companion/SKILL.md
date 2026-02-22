# KB Steward Companion

**Purpose**: 轻量级知识库管理助手，快速查询和更新 Obsidian vault 中的任务和项目。

---

## 当你需要这个 skill 时

- 查询特定标签的任务（如 `area/integration`、`type/research`）
- 查看所有待办任务
- 更新任务状态（`frontmatter` 中的 `status` 字段）
- 浏览标签分类
- 创建新项目/任务笔记

---

## 核心工具

### 1. 查询任务

```bash
# 所有待办任务
skills/kb-steward-companion/scripts/todo.sh

# 按标签筛选
skills/kb-steward-companion/scripts/todo.sh area/integration
skills/kb-steward-companion/scripts/todo.sh type/research
skills/kb-steward-companion/scripts/todo.sh service/gemini-local

# 显示所有（包括已完成）
skills/kb-steward-companion/scripts/todo.sh --all
```

### 2. 浏览标签

```bash
# 所有标签分类
skills/kb-steward-companion/scripts/tags.sh

# 特定分类
skills/kb-steward-companion/scripts/tags.sh area
skills/kb-steward-companion/scripts/tags.sh type
```

### 3. Frontmatter 操作

```bash
# 读取任务状态
obsidian-cli frontmatter "项目名称" --print

# 更新状态
obsidian-cli frontmatter "项目名称" --edit --key "status" --value "done"

# 删除字段
obsidian-cli frontmatter "项目名称" --delete --key "due"

# 添加标签
obsidian-cli frontmatter "项目名称" --edit --key "tags[]" --value "area/new-tag"
```

### 4. 创建/删除笔记

```bash
# 创建项目笔记
obsidian-cli create "新项目名称" --content '---
title: "新项目名称"
status: backlog
prio: P2
created: 2026-02-21
tags:
  - area/integration
  - type/implementation
---

# 目标

## 任务列表
- [ ] 任务 1
- [ ] 任务 2
'

# 删除笔记
obsidian-cli delete "项目名称"
```

---

## 标签分类体系

### area/（领域/主题）
- `area/integration` - 第三方集成
- `area/telegram` - Telegram 相关
- `area/memory` - 记忆管理
- `area/model-serving` - 模型服务
- `area/agent-persona` - Agent 人设
- `area/workflow` - 工作流
- `area/skills` - OpenClaw skills
- `area/openclaw` - OpenClaw 核心
- `area/debugging` - 调试相关
- 等 21 个 area 标签

### type/（任务类型）
- `type/research` - 调研类
- `type/implementation` - 实现类
- `type/creation` - 创建类
- `type/done` - 已完成
- `type/automation` - 自动化
- `type/refactor` - 重构
- `type/clarification` - 澄清/分析

### service/（具体服务）
- `service/gemini-local` - Gemini Local 服务

---

## 快捷操作

### 标记任务完成

当用户说"完成某个任务"时：
1. 用 `skills/kb-steward-companion/scripts/todo.sh [tag]` 找到任务所在文件
2. 用 `skills/kb-steward-companion/scripts/status.sh "项目名称" done` 更新状态
3. 确认更新

### 按优先级查看

```bash
# 所有项目按优先级
skills/kb-steward-companion/scripts/prio.sh

# 特定优先级
skills/kb-steward-companion/scripts/prio.sh P0
skills/kb-steward-companion/scripts/prio.sh P1
```

### 进行中任务

```bash
grep -l "status: in_progress" ~/.openclaw/shared/knowledge/claw-config/10-Projects/*.md
```

---

## 配置文件

- **Vault path**: `/Users/ruonan/.openclaw/shared/knowledge/claw-config`
- **obsidian-cli 配置**: `~/Library/Application Support/obsidian-cli/preferences.json`
- **默认 vault**: `claw-config`

---

## 注意事项

1. **文件名匹配**: `obsidian-cli` 使用模糊搜索，所以文件名不需要完全精确
2. **Frontmatter 安全**: 用 `obsidian-cli` 修改 frontmatter 比用 `sed` 更安全
3. **标签格式**: 使用 `area/xxx`, `type/xxx`, `service/xxx` 的层级格式
4. **任务格式**: 使用标准的 Markdown checkbox `- [ ]` / `- [x]`
