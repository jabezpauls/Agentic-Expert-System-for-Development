#!/usr/bin/env bash
set -euo pipefail

# Agentic Expert System for Development — Claude Code Skill Installer
# Installs the expert system as a global Claude Code skill at ~/.claude/skills/
#
# After install, use /expert-system in any Claude Code session.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="${HOME}/.claude/skills/expert-system"

echo "Installing Agentic Expert System as Claude Code skill..."
echo ""

# Create skill directories
mkdir -p "${SKILL_DIR}/domains"
mkdir -p "${SKILL_DIR}/knowledge-vault"
mkdir -p "${SKILL_DIR}/custom-agents"
mkdir -p "${SKILL_DIR}/workflows"

# Copy SKILL.md (the main skill definition)
cp "${SCRIPT_DIR}/.claude/skills/expert-system/SKILL.md" "${SKILL_DIR}/SKILL.md"

# Copy domain files (full content, not symlinks)
cp "${SCRIPT_DIR}"/Domain_*.md "${SKILL_DIR}/domains/"

# Copy knowledge vault templates
cp "${SCRIPT_DIR}"/Knowledge-Vault/*.md "${SKILL_DIR}/knowledge-vault/"

# Copy custom agent templates
cp "${SCRIPT_DIR}"/Custom-Agents/*.md "${SKILL_DIR}/custom-agents/"

# Copy workflow files
cp "${SCRIPT_DIR}"/agents/workflows/*.md "${SKILL_DIR}/workflows/"

# Fix line endings (CRLF -> LF) for YAML frontmatter parsing
find "${SKILL_DIR}" -name "*.md" -exec sed -i 's/\r$//' {} +

echo "Installed to: ${SKILL_DIR}/"
echo ""
echo "  SKILL.md         (handler + routing logic)"
echo "  domains/         (13 domain agent files)"
echo "  knowledge-vault/ (initiative compass, user model)"
echo "  custom-agents/   (registry + template)"
echo "  workflows/       (expert system, librarian, session planning)"
echo ""
echo "Usage: Type /expert-system in any Claude Code session"
echo ""
echo "To uninstall: rm -rf ${SKILL_DIR}"
echo ""
echo "Done."
