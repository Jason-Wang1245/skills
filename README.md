# skills

The master copy of my agent skills. Each skill is a folder under `skills/` with a `SKILL.md` (standard Agent Skills format), so it works in:

| Harness | Reads from |
|---|---|
| Claude Code | `~/.claude/skills` |
| Codex | `~/.agents/skills` |
| Copilot CLI / VS Code agent mode | `~/.claude/skills`, `~/.agents/skills` |
| Claude desktop app | your claude.ai account (upload a zip) |

## Setup

```sh
./scripts/link.sh
```

This symlinks each skill into `~/.claude/skills` and `~/.agents/skills`. Running it again is safe, and it never overwrites a real folder that has the same name.

## Day to day

- **Edit a skill:** change the file in `skills/`. Every local harness sees the change at its next session, because they read through the symlinks.
- **Add a skill:** create `skills/<name>/SKILL.md`, then run `./scripts/link.sh`.
- **Remove a skill:** delete its folder, then run `./scripts/link.sh --prune`.

## Claude desktop app

The desktop app loads skills from your claude.ai account, not from local files, so you have to push changes to it by hand:

```sh
./scripts/package.sh <name>   # writes dist/<name>.zip
```

Then upload the zip under Settings → Capabilities → Skills, replacing the old version.
