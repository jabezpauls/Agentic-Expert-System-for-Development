#!/usr/bin/env bash
set -euo pipefail

# Agentic Expert System for Development — Claude Code Skill Installer
# Installs the expert-system skill to ~/.claude/skills/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="${SCRIPT_DIR}/.claude/skills/expert-system"
SKILL_DST="${HOME}/.claude/skills/expert-system"

# ─── Colors ───────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

echo -e "${BLUE}"
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║     Agentic Expert System for Development  v4            ║"
echo "  ║     13 Domains · 78 Perspectives · 3 Layers              ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ─── Checks ───────────────────────────────────────────────────────

if ! command -v claude &>/dev/null && [ ! -d "${HOME}/.claude" ]; then
  echo -e "${RED}✗ Claude Code not found.${NC}"
  echo "  Install it first: https://claude.ai/download"
  exit 1
fi

if [ ! -d "${SKILL_SRC}" ]; then
  echo -e "${RED}✗ Skill source not found at: ${SKILL_SRC}${NC}"
  echo "  Make sure you're running this from the repo root."
  exit 1
fi

# ─── Backup existing install ───────────────────────────────────────

if [ -d "${SKILL_DST}" ]; then
  BACKUP="${SKILL_DST}.backup.$(date +%Y%m%d_%H%M%S)"
  echo -e "${YELLOW}↺ Existing install found — backing up to:${NC}"
  echo "  ${BACKUP}"
  mv "${SKILL_DST}" "${BACKUP}"
fi

# ─── Install ──────────────────────────────────────────────────────

echo -e "${BLUE}→ Installing skill to: ${SKILL_DST}${NC}"
mkdir -p "${HOME}/.claude/skills"
cp -r "${SKILL_SRC}" "${SKILL_DST}"

# ─── Verify ───────────────────────────────────────────────────────

REQUIRED=("SKILL.md" "domains" "parliament" "memory" "initiative-compass.md")
MISSING=0
for f in "${REQUIRED[@]}"; do
  if [ ! -e "${SKILL_DST}/${f}" ]; then
    echo -e "${RED}✗ Missing: ${f}${NC}"
    MISSING=1
  fi
done

if [ "$MISSING" -eq 1 ]; then
  echo -e "${RED}Install incomplete — some files are missing.${NC}"
  exit 1
fi

DOMAIN_COUNT=$(ls "${SKILL_DST}/domains/"D*.md 2>/dev/null | wc -l)
PARLIAMENT_COUNT=$(ls "${SKILL_DST}/parliament/"Domain_*.md 2>/dev/null | wc -l)

echo ""
echo -e "${GREEN}✓ Expert System skill installed successfully!${NC}"
echo ""
echo "  Domains (compressed):  ${DOMAIN_COUNT}/13"
echo "  Parliament (full):     ${PARLIAMENT_COUNT}/13"
echo "  Memory system:         ready"
echo ""
echo "  Usage in Claude Code:"
echo -e "  ${YELLOW}/expert-system <your query>${NC}"
echo ""
echo "  Or just describe your problem — Claude will route it automatically."
echo ""
echo "  Tip: Say 'escalate' or 'full parliament' to trigger Layer 2 debate."
echo ""
