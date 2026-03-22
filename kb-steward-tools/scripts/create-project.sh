#!/bin/bash
# Create a new project in the active directory

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Vault path (auto-discover)
VAULT_PATH="${KB_STEWARD_VAULT:-$HOME/.openclaw/shared/knowledge/claw-config}"
PROJECTS_DIR="$VAULT_PATH/10-Projects"
ACTIVE_DIR="$PROJECTS_DIR/🔄 active"

# Functions
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Validate vault
if [ ! -d "$VAULT_PATH" ]; then
  error "Vault not found at: $VAULT_PATH"
fi

if [ ! -d "$ACTIVE_DIR" ]; then
  error "Active directory not found at: $ACTIVE_DIR"
fi

# Parse arguments
if [ $# -lt 2 ]; then
  error "Usage: $0 \"Project Name\" \"area/category\" [priority]\nExample: $0 \"ClawPort Skills\" \"area/skills\" 1"
fi

PROJECT_NAME="$1"
AREA_TAG="$2"
PRIO="${3:-2}"

# Sanitize project name (convert to folder-safe name)
FOLDER_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -d '[:punct:]')

# Create project directory
PROJECT_DIR="$ACTIVE_DIR/$FOLDER_NAME"
if [ -d "$PROJECT_DIR" ]; then
  error "Project already exists: $FOLDER_NAME"
fi

info "Creating project: $PROJECT_NAME"
mkdir -p "$PROJECT_DIR/tasks"
mkdir -p "$PROJECT_DIR/references"

# Get current date
CREATED_DATE=$(date +%Y-%m-%dT%H:%M:%S.000Z)
UPDATED_DATE=$CREATED_DATE

# Create PROJECT.md
cat > "$PROJECT_DIR/PROJECT.md" <<EOF
---
title: $PROJECT_NAME
status: active
prio: $PRIO
tags:
  - $AREA_TAG
created: $CREATED_DATE
updated: $UPDATED_DATE
---

## 目标

简要描述项目的目标。

## 背景

为什么需要这个项目？解决什么问题？

## 任务列表

- [ ] 任务 1
- [ ] 任务 2
- [ ] 任务 3

## 验收标准

- ✅ 标准 1
- ✅ 标准 2
- ✅ 标准 3

## 预期成果

描述项目完成后会产出什么。

## 风险与注意事项

列出可能的风险和注意事项。

## 参考资料

- 相关文档链接
- 外部资源链接
EOF

info "✅ Created: $PROJECT_DIR/PROJECT.md"

# Create tasks README
cat > "$PROJECT_DIR/tasks/README.md" <<EOF
# Tasks - $PROJECT_NAME

在这个目录下创建任务文件。

## 创建任务

使用以下命令创建任务：

\`\`\`bash
scripts/create-task.sh "$FOLDER_NAME" "Task Name" "1-2h" 1
\`\`\`
EOF

info "✅ Created: $PROJECT_DIR/tasks/README.md"

info ""
info "🎉 Project created successfully!"
info ""
info "Next steps:"
info "  1. Edit PROJECT.md to add your goals and tasks"
info "  2. Create tasks with: scripts/create-task.sh \"$FOLDER_NAME\" \"Task Name\" \"1-2h\" 1"
info "  3. Start working on your project!"
info ""
