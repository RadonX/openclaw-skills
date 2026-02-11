# Source ingestion decision tree

## X / Twitter
Prefer `bird read <url>`.
If cookies missing → ask user to log in or paste content.

## Feishu doc
Prefer browser `profile=openclaw`:
- open URL
- snapshot
If login required → ask for exported text/PDF.

## GitHub repo
- Use `web_fetch` for README
- If directory listing needed: GitHub API `contents/`
Capture: what it is + quick start + key files.

## WeChat mp.weixin
Often unreachable from isolated environment. Fallback:
- ask user to export PDF / paste content.
