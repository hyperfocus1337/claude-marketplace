# MCP Server Locations (Desktop)

*Of all different AI tools on the system*

## Locations

### Filesystem MCP servers

Links point to files on the filesystem

| Tool               | Filesystem link                                                   |
| ------------------ | ----------------------------------------------------------------- |
| **Claude Code**    | `~/.claude.json`                                                  |
| **Claude Desktop** | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| **Cursor**         | `~/.cursor/mcp.json`                                              |
| **VS Code**        | `~/Library/Application Support/Code/User/mcp.json`                |
| **OpenAI Codex**   | `~/.codex/config.toml`                                            |
| **Gemini CLI**     | `~/.gemini/settings.json`                                         |

## Install

### Tessl

Command compiled based on official [setup](https://docs.tessl.io/reference/custom-agent-setup)
```bash
claude mcp add --scope user tessl -- tessl mcp start
```

### Context7

Official [repository](https://github.com/upstash/context7)
```bash
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp --api-key YOUR_API_KEY
```