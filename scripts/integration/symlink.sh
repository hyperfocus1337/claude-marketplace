#!/usr/bin/env bash
# symlink.sh — wire .claude from the marketplace repo into ~/.claude
#
# Usage:
#   ./scripts/integration/symlink.sh
#   REPO=/path/to/your/clone ./scripts/integration/symlink.sh

set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
# Default: the directory two levels above this script (repo root).
# Override by setting REPO before running:  REPO=~/my/path ./symlink.sh
REPO="${REPO:-"$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"}"
CLAUDE_HOME="${CLAUDE_HOME:-"$HOME/.claude"}"

# ── Helpers ──────────────────────────────────────────────────────────────────
info()    { printf '\033[1;34m  →\033[0m %s\n' "$*"; }
success() { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }
warn()    { printf '\033[1;33m  !\033[0m %s\n' "$*"; }
die()     { printf '\033[1;31m  ✗\033[0m %s\n' "$*" >&2; exit 1; }

symlink() {
  local src="$1" dst="$2"
  if [[ -L "$dst" ]]; then
    warn "Already a symlink, skipping: $dst"
  elif [[ -e "$dst" ]]; then
    warn "Path exists and is not a symlink — skipping (handle manually): $dst"
  else
    ln -s "$src" "$dst"
    success "Linked $dst → $src"
  fi
}

# ── Validate repo ─────────────────────────────────────────────────────────────
[[ -d "$REPO/.claude" ]] \
  || die "Expected a .claude/ directory inside REPO='$REPO'. Set REPO to the repo root."

info "Repo:        $REPO"
info "Claude home: $CLAUDE_HOME"
echo

# ── Ensure ~/.claude structure exists ────────────────────────────────────────
mkdir -p "$CLAUDE_HOME/commands" "$CLAUDE_HOME/skills"
success "Ensured $CLAUDE_HOME/{commands,skills}/"
echo

# ── Commands ─────────────────────────────────────────────────────────────────
# Create real directories for each namespace, then symlink individual command
# files inside them — Claude Code doesn't traverse symlinked directories.
info "Linking commands..."
for group_src in "$REPO/.claude/commands"/*/; do
  [[ -d "$group_src" ]] || continue
  group="$(basename "$group_src")"
  group_dst="$CLAUDE_HOME/commands/$group"
  mkdir -p "$group_dst"
  for cmd_src in "$group_src"*.md; do
    [[ -f "$cmd_src" ]] || continue
    symlink "$cmd_src" "$group_dst/$(basename "$cmd_src")"
  done
done
echo

# ── Skills ───────────────────────────────────────────────────────────────────
info "Linking skills..."
for src in "$REPO/.claude/skills"/*/; do
  [[ -d "$src" ]] || continue
  symlink "$src" "$CLAUDE_HOME/skills/$(basename "$src")"
done
echo

# ── CLAUDE.md ────────────────────────────────────────────────────────────────
info "Linking CLAUDE.md..."
if [[ -f "$CLAUDE_HOME/CLAUDE.md" && ! -L "$CLAUDE_HOME/CLAUDE.md" ]]; then
  warn "~/.claude/CLAUDE.md already exists and is not a symlink."
  warn "Append the repo's CLAUDE.md manually to preserve your existing file:"
  warn "  cat '$REPO/.claude/CLAUDE.md' >> '$CLAUDE_HOME/CLAUDE.md'"
else
  symlink "$REPO/.claude/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
fi
echo

success "Done. Commands and skills are available globally."
info  "Keep assets up to date:  git -C '$REPO' pull"
