# jstack

The master copy of my agent skills. Each skill is a folder under `skills/` with a `SKILL.md` (standard Agent Skills format), so it works in:

| Harness | Reads from |
|---|---|
| Claude Code | `~/.claude/skills` (symlinks) |
| Codex | `~/.agents/skills` (symlinks) |
| Copilot CLI / VS Code agent mode | `~/.claude/skills`, `~/.agents/skills` (symlinks) |
| Claude desktop app | this repo as a plugin marketplace, installed from GitHub |
| GitHub Copilot app | this repo as a plugin marketplace, installed from GitHub |

## Setup

```sh
./scripts/link.sh
```

This symlinks each skill into `~/.claude/skills` and `~/.agents/skills`. Running it again is safe, and it never overwrites a real folder that has the same name.

## Day to day

- **Edit a skill:** change the file in `skills/`. Every local harness sees the change at its next session, because they read through the symlinks.
- **Add a skill:** create `skills/<name>/SKILL.md`, then run `./scripts/link.sh`.
- **Remove a skill:** delete its folder, then run `./scripts/link.sh --prune`.

For the desktop apps, also bump `version` in both `.claude-plugin/plugin.json` and `.github/plugin/plugin.json`, then push.

## Claude desktop app

The desktop app doesn't read local files. Instead, this repo is a plugin marketplace (`.claude-plugin/marketplace.json`) with one plugin, `jstack`, which contains every skill in `skills/`.

1. Push this repo to GitHub.
2. In the desktop app, add a plugin marketplace from GitHub: `Jason-Wang1245/skills`.
3. Install the `jstack` plugin.

To ship changes: bump `version` in `.claude-plugin/plugin.json` (and `.github/plugin/plugin.json`), push, then update the marketplace in the app.

Skills installed as a plugin get a namespace prefix (for example `jstack:ask`).

**Don't** install the plugin in Claude Code too: the symlinks already provide the skills, and you'd get every skill twice (`ask` and `jstack:ask`).

Check the manifests with `claude plugin validate .`.

## GitHub Copilot app

Copilot reads its marketplace from `.github/plugin/`. Those files are copies of the ones in `.claude-plugin/`, so keep the two folders in sync. The only field that changes in practice is `version`.

1. Push this repo to GitHub.
2. In the Copilot app, open **Customize**, click the marketplace settings control next to the marketplace dropdown, and add `Jason-Wang1245/skills`.
3. Find `jstack` under **Browse** and install it.

From Copilot CLI, run `copilot plugin marketplace add Jason-Wang1245/skills`, then `copilot plugin install jstack@jstack`.

Copilot doesn't prefix plugin skills with the plugin name. It deduplicates skills by `name`, and personal skills win. So if `link.sh` has already put these skills in `~/.agents/skills` or `~/.claude/skills`, those copies are the ones Copilot uses.
