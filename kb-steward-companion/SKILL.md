# kb-steward-companion

A collection of companion scripts for managing a `kb-steward` knowledge base. These are simple, focused CLI tools for querying and maintenance.

## Scripts

- **`scripts/todo.sh [tag]`**: 查询待办任务 (status != done)
- **`scripts/tags.sh [category]`**: 浏览标签分类
- **`scripts/status.sh <project> <status>`**: 快速更新项目状态
- **`scripts/prio.sh [P0-P3]`**: 按优先级查看项目
- **`scripts/tag.sh <file> --add|--remove <tag>`**: 管理笔记的标签

### `tag.sh`

```
# Add a tag
./scripts/tag.sh "path/to/note.md" --add new/tag

# Remove a tag
./scripts/tag.sh "path/to/note.md" --remove old/tag

# List tags (default action)
./scripts/tag.sh "path/to/note.md" --list
```
