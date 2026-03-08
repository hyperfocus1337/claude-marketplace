# claude-marketplace

Personal Claude Code plugins, skills, and integration docs — a self-hosted marketplace for AI tooling configuration.

## Structure

```
.
├── .claude/          # Portable Claude Code config (commands, skills, CLAUDE.md)
├── .claude-plugin/   # Marketplace plugin registry (marketplace.json)
└── docs/             # Integration guides and setup instructions
```

## Contents

### `.claude/`

Portable Claude Code configuration — commands, skills, and a global `CLAUDE.md` — designed to be symlinked into any project. See [`.claude/README.md`](.claude/README.md) for the full breakdown.

### `.claude-plugin/`

The marketplace plugin registry (`marketplace.json`) that defines this repo as a Claude Code plugin source, enabling `claude plugin marketplace add` to pull from it.

### `docs/`

Platform-specific MCP server setup guides and plugin installation references. See [`docs/README.md`](docs/README.md) for the full breakdown.
