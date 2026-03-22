#!/usr/bin/env bash
set -euo pipefail

# lint-links.sh - related_docs link linter for kb-steward vaults
#
# Checks (frontmatter) related_docs for:
#   - broken wikilinks (no target note found)
#   - orphans (no inbound links; optionally also no outbound links)
#
# Usage:
#   ./scripts/lint-links.sh [--vault PATH] [--orphans inbound|isolated|off] [--json]

VAULT_ROOT=""
ORPHANS_MODE="inbound"   # inbound|isolated|off
AS_JSON="false"

usage() {
  cat <<'EOF'
Usage: lint-links.sh [--vault PATH] [--orphans inbound|isolated|off] [--json]

  --vault PATH       Vault root directory to scan.
  --orphans MODE     inbound  = notes with 0 inbound links (default)
                    isolated = notes with 0 inbound AND 0 outbound links
                    off      = skip orphan detection
  --json             Emit machine-readable JSON (best-effort).
EOF
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --vault)
      VAULT_ROOT="$2"; shift 2;;
    --orphans)
      ORPHANS_MODE="$2"; shift 2;;
    --json)
      AS_JSON="true"; shift;;
    -h|--help)
      usage; exit 0;;
    *)
      echo "Unknown arg: $1" >&2
      usage; exit 2;;
  esac
done

# Discover vault path automatically (best-effort)
if [[ -z "$VAULT_ROOT" ]]; then
  CANDIDATES=(
    "$HOME/.openclaw/shared/knowledge/claw-config"
    "$HOME/.openclaw/workspace-pensieve/kb"
    "/Users/ruonan/.openclaw/workspace-pensieve/kb"
  )
  for c in "${CANDIDATES[@]}"; do
    if [[ -d "$c" ]]; then
      VAULT_ROOT="$c"
      break
    fi
  done
fi

if [[ -z "$VAULT_ROOT" || ! -d "$VAULT_ROOT" ]]; then
  echo "❌ Error: Cannot find vault path" >&2
  echo "Pass --vault PATH" >&2
  exit 1
fi

python3 - "$VAULT_ROOT" "$ORPHANS_MODE" "$AS_JSON" <<'PY'
import json, os, re, sys

vault = sys.argv[1]
orphans_mode = sys.argv[2]
as_json = sys.argv[3].lower() == 'true'

md_files = []
for root, _, files in os.walk(vault):
  for fn in files:
    if fn.lower().endswith('.md'):
      md_files.append(os.path.join(root, fn))

def strip_quotes(s: str) -> str:
  s = s.strip()
  if (len(s) >= 2) and ((s[0] == s[-1] == '"') or (s[0] == s[-1] == "'")):
    return s[1:-1]
  return s

def read_frontmatter(text: str) -> str:
  if not text.startswith('---'):
    return ''
  # frontmatter ends at the next line that is exactly ---
  m = re.search(r"\n---\s*\n", text)
  if not m:
    return ''
  return text[4:m.start()+1]  # between first ---\n and \n---

# Extract title + aliases (best-effort, YAML-light)
TITLE_RE = re.compile(r'^title:\s*(.+?)\s*$', re.M)
ID_RE = re.compile(r'^id:\s*(.+?)\s*$', re.M)

def parse_names(path: str, fm: str):
  base = os.path.splitext(os.path.basename(path))[0]
  names = {base}
  m = TITLE_RE.search(fm)
  if m:
    names.add(strip_quotes(m.group(1)))
  # aliases: followed by indented list items
  if re.search(r'^aliases:\s*$', fm, re.M):
    lines = fm.splitlines()
    in_aliases = False
    for line in lines:
      if re.match(r'^aliases:\s*$', line):
        in_aliases = True
        continue
      if in_aliases:
        if re.match(r'^\s{2,}-\s+', line):
          names.add(strip_quotes(re.sub(r'^\s{2,}-\s+', '', line)))
        elif line.strip() == '':
          continue
        else:
          break
  return names

def parse_related_docs(fm: str):
  # Find the related_docs block and capture list items
  lines = fm.splitlines()
  out = []
  in_block = False
  for line in lines:
    if re.match(r'^related_docs:\s*null\s*$', line):
      return []
    if re.match(r'^related_docs:\s*\[\]\s*$', line):
      return []
    if re.match(r'^related_docs:\s*$', line):
      in_block = True
      continue
    if in_block:
      # YAML list item
      m = re.match(r'^\s{2,}-\s*(.+?)\s*$', line)
      if m:
        raw = strip_quotes(m.group(1))
        # Extract wikilinks only
        for t in re.findall(r'\[\[([^\]]+)\]\]', raw):
          out.append(t.strip())
      else:
        # end of related_docs block when indentation stops or new key begins
        if line.strip() == '':
          continue
        if re.match(r'^[A-Za-z0-9_\-]+:\s*', line):
          break
        if not line.startswith(' '):
          break
  return out

# Build name index
name_to_path = {}
collisions = []
outbound = {}  # path -> list[target_name]

for path in md_files:
  try:
    with open(path, 'r', encoding='utf-8') as f:
      text = f.read()
  except Exception:
    continue
  fm = read_frontmatter(text)
  names = parse_names(path, fm)
  for n in names:
    if n in name_to_path and name_to_path[n] != path:
      collisions.append({'name': n, 'a': name_to_path[n], 'b': path})
      # keep first
    else:
      name_to_path[n] = path
  outbound[path] = parse_related_docs(fm)

# Resolve and count inbound
inbound_count = {p: 0 for p in md_files}
broken = []
resolved_edges = []

for src, targets in outbound.items():
  for t in targets:
    dst = name_to_path.get(t)
    if not dst:
      broken.append({'src': src, 'target': t})
    else:
      inbound_count[dst] = inbound_count.get(dst, 0) + 1
      resolved_edges.append((src, dst, t))

# Orphans
orphans = []
if orphans_mode != 'off':
  for p in md_files:
    in0 = inbound_count.get(p, 0) == 0
    out0 = len(outbound.get(p, [])) == 0
    if orphans_mode == 'inbound' and in0:
      orphans.append(p)
    elif orphans_mode == 'isolated' and in0 and out0:
      orphans.append(p)

# Summaries
result = {
  'vault': vault,
  'files': len(md_files),
  'edges': sum(len(v) for v in outbound.values()),
  'resolved_edges': len(resolved_edges),
  'broken_links': broken,
  'orphans': orphans,
  'name_collisions': collisions,
}

if as_json:
  print(json.dumps(result, ensure_ascii=False, indent=2))
else:
  rel = lambda p: os.path.relpath(p, vault)
  print(f"🔎 Vault: {vault}")
  print(f"📄 Files: {result['files']}")
  print(f"🔗 related_docs edges: {result['edges']} (resolved {result['resolved_edges']})")
  print("")

  if collisions:
    print(f"⚠️  Name collisions: {len(collisions)}")
    for c in collisions[:30]:
      print(f"  - {c['name']}: {rel(c['a'])}  <->  {rel(c['b'])}")
    if len(collisions) > 30:
      print(f"  … {len(collisions)-30} more")
    print("")

  if broken:
    print(f"❌ Broken wikilinks in related_docs: {len(broken)}")
    for b in broken[:60]:
      print(f"  - {rel(b['src'])}  ->  [[{b['target']}]]")
    if len(broken) > 60:
      print(f"  … {len(broken)-60} more")
    print("")
  else:
    print("✅ No broken wikilinks found in related_docs")
    print("")

  if orphans_mode != 'off':
    print(f"🧩 Orphans ({orphans_mode}): {len(orphans)}")
    for p in orphans[:60]:
      print(f"  - {rel(p)}")
    if len(orphans) > 60:
      print(f"  … {len(orphans)-60} more")
    print("")

# Exit code: non-zero if broken links exist
sys.exit(1 if broken else 0)
PY