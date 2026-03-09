### Code Intelligence

Prefer LSP over Grep/Glob/Read for code navigation:

- `goToDefinition` / `goToImplementation` to jump to source
- `findReferences` to see all usages across the codebase
- `workspaceSymbol` to find where something is defined
- `documentSymbol` to list all symbols in a file
- `hover` for type info without reading the file
- `incomingCalls` / `outgoingCalls` for call hierarchy

Before renaming or changing a function signature, use `findReferences` to find all call sites first.

Use Grep/Glob only for text/pattern searches (comments, strings, config values) where LSP doesn't help.

After writing or editing code, check LSP diagnostics before moving on. Fix any type errors or missing imports immediately.

### ast-grep

Use ast-grep (via `/ast-grep` skill) for structural pattern search:

- Finding all usages of a pattern across the codebase (e.g. all `for` loops calling `.append()`)
- Identifying missing annotations, decorators, or structural anti-patterns
- Cross-language searches where LSP has no coverage
- Prefer over Grep when the target is a code structure, not a string

### jcodemunch MCP

Use jcodemunch for codebase orientation and bulk symbol lookup:

- `index_folder` once per project before using other tools (stored in `~/.code-index/`)
- `get_file_tree` / `get_repo_outline` to understand project structure without reading files
- `search_symbols` to find a symbol by name when you don't know its location
- `get_file_outline` to see all symbols in a file without reading its full content
- `search_text` for full-text search as a last resort if LSP and Grep fall short

Tool selection order for code navigation:

1. LSP — semantic lookups (definitions, references, types, call hierarchy)
2. jcodemunch — orientation, symbol discovery, bulk structure overview
3. ast-grep — structural pattern matching across the codebase
4. Grep/Glob — plain text / config / comment searches
