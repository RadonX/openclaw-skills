# Auto-bootstrap policy

## Goal
Keep the KB usable with **zero explicit init**. Bootstrap happens implicitly in `add`.

## Assets (minimum viable)
Under kbRoot:
- `00-Inbox/README.md`
- `10-Projects/README.md`
- `10-Projects/🔄 active/README.md`
- `10-Projects/✅ completed/README.md`
- `10-Projects/💭 backlog/README.md`
- `10-Projects/📋 templates/README.md`
- `10-Projects/📋 templates/project-template.md`
- `10-Projects/📋 templates/task-template.md`
- `20-Areas/README.md`
- `30-Research/README.md`
- `99-Templates/README.md`
- `99-Templates/Project.md`, `Area.md`, `Research.md`

## Rules
- Create missing files only.
- Never overwrite user-modified README/templates.
- Only append the "Taxonomy Registry" section if missing.

## Doctor report
`doctor` should report:
- missing folders
- missing READMEs/templates
- READMEs missing Taxonomy Registry section
- **NEW**: Projects in `10-Projects/🔄 active/` without `PROJECT.md`
- **NEW**: Projects without `tasks/` or `references/` directories
