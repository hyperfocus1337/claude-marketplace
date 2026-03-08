# Integrating Claude Commands and Skills

This repository ships a `.claude/` directory containing slash commands, skills, and a global `CLAUDE.md`. There are three main ways to consume them in an existing Claude Code installation — choose whichever fits your workflow.

## Prerequisites

Clone the repo to a stable location on your machine first:

```bash
git clone https://github.com/your-org/claude-marketplace ~/repos/claude-marketplace
```

All three approaches below reference this clone. Keeping it up to date is always just:

```bash
git -C ~/repos/claude-marketplace pull
```

---

## Approach 1: Symlink into `~/.claude`

Symlink the individual subdirectories and files from the clone into your global `~/.claude` folder. Claude Code picks them up automatically on every session with no further configuration.

```bash
# Create ~/.claude if it doesn't exist yet
mkdir -p ~/.claude/commands ~/.claude/skills

# Commands
ln -s ~/repos/claude-marketplace/.claude/commands ~/.claude/commands/marketplace

# Skills
ln -s ~/repos/claude-marketplace/.claude/skills ~/.claude/skills/marketplace

# CLAUDE.md — merge manually if you already have one, or symlink directly
ln -s ~/repos/claude-marketplace/.claude/CLAUDE.md ~/.claude/CLAUDE.md
```

> **Note on CLAUDE.md:** If you already have a `~/.claude/CLAUDE.md`, symlink would overwrite your existing file. Instead, append the contents manually or use an `@import` directive if your version of Claude Code supports it.

**Best for:** users who want permanent, zero-friction global integration and are comfortable managing symlinks.

---

## Approach 2: `--add-dir` flag

Pass the repository root (or `.claude/` path directly) to Claude Code at launch. Commands and skills inside the `.claude/` subfolder of the given directory are loaded for that session.

```bash
claude --add-dir ~/repos/claude-marketplace
```

To avoid typing the flag every time, add a shell alias:

```bash
# ~/.zshrc or ~/.bashrc
alias claude='claude --add-dir ~/repos/claude-marketplace'
```

Multiple directories can be stacked:

```bash
claude --add-dir ~/repos/claude-marketplace --add-dir ~/repos/my-other-plugin
```

**Best for:** testing a new set of commands before committing to a permanent setup, or using the commands only in specific contexts.

---

## Approach 3: `addDirs` in config

Add the repository path to your Claude Code configuration file (`~/.claude.json`). This is the persistent equivalent of the `--add-dir` flag — no shell aliases or symlinks required.

```json
{
  "addDirs": ["/home/you/repos/claude-marketplace"]
}
```

To manage multiple repos:

```json
{
  "addDirs": [
    "/home/you/repos/claude-marketplace",
    "/home/you/repos/my-other-plugin"
  ]
}
```

Claude Code reads this file on startup, so changes take effect on the next launch.

**Best for:** a permanent setup where you want the commands available globally without touching the filesystem layout of `~/.claude`.

---

## Comparison

|                                   | Symlink                 | `--add-dir` flag     | `addDirs` config |
| --------------------------------- | ----------------------- | -------------------- | ---------------- |
| Persistent across sessions        | Yes                     | Only with alias      | Yes              |
| Merges into `~/.claude` structure | Yes                     | No                   | No               |
| Supports multiple repos           | Yes (multiple symlinks) | Yes (multiple flags) | Yes (array)      |
| Requires config file changes      | No                      | No                   | Yes              |
| Easy to enable/disable            | Remove symlink          | Drop the flag/alias  | Edit the array   |
| Good for testing                  | No                      | Yes                  | No               |

---

## What gets loaded

All three approaches expose the same contents from `.claude/`:

- **Commands** — slash commands available as `/namespace:command` in any Claude Code session (e.g. `/git:changelog`, `/issues:improve-issue`)
- **Skills** — on-demand reference documents Claude reads when a task requires specialised knowledge (e.g. the `gh-cli` skill)
- **CLAUDE.md** — global standing instructions injected at the start of every session

See [`.claude/README.md`](../.claude/README.md) for the full list of available commands and skills.
