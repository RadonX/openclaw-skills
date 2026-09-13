# Apply (write) protocol

1. Scope: user-owned skills only. Enumerate roots:
   ~/.openclaw/workspace-main/skills/, ~/repo/config/openclaw/skills/,
   ~/.agents/skills/, ~/.openclaw/skills/.
   Skip /opt/homebrew/... (bundled, overwritten on update).
2. Per skill: print `name` + old description + new description + one-line
   reason keyed to DESC_CRITERIA number.
3. After confirmation: `edit` the frontmatter description only. No body edits.
4. Git repos (e.g. ~/repo/config/openclaw/skills/): status → diff → add →
   Conventional Commit (`feat(skills): optimize descriptions …`) → push.
5. Report: N changed / M skipped (reason each).
