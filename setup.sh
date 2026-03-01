#!/usr/bin/env bash
#
# DeepFlow Labs Claude Code Setup
#
# Run this once to install everything you need for Claude Code across all
# DeepFlow Labs repositories. After this, every `claude` session has access to
# team skills, MCP servers, and recommended plugins.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/deepflow-labs/ai-skills/main/setup.sh | bash
#   — or —
#   ./setup.sh
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No color

print_header() {
  echo ""
  echo -e "${BOLD}${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${BOLD}${PURPLE}  DeepFlow Labs Claude Code Setup${NC}"
  echo -e "${BOLD}${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
}

print_step() {
  echo -e "${BOLD}${CYAN}[$1/$TOTAL_STEPS]${NC} ${BOLD}$2${NC}"
}

print_install() {
  echo -e "  ${BLUE}→${NC} $1"
}

print_success() {
  echo -e "  ${GREEN}✔${NC} $1"
}

print_skip() {
  echo -e "  ${YELLOW}⊘${NC} $1 (already installed)"
}

print_warn() {
  echo -e "  ${YELLOW}!${NC} $1"
}

print_error() {
  echo -e "  ${RED}✘${NC} $1"
}

TOTAL_STEPS=4

# ─────────────────────────────────────────────────
# Preflight check
# ─────────────────────────────────────────────────

print_header

if ! command -v claude &> /dev/null; then
  print_error "Claude Code CLI not found."
  echo ""
  echo -e "  Install it first:"
  echo -e "    ${BOLD}brew install claude-code${NC}"
  echo -e "    — or —"
  echo -e "    ${BOLD}npm install -g @anthropic-ai/claude-code${NC}"
  echo ""
  exit 1
fi

CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
echo -e "  Claude Code: ${GREEN}${CLAUDE_VERSION}${NC}"
echo ""

# ─────────────────────────────────────────────────
# Step 1: Marketplace
# ─────────────────────────────────────────────────

print_step 1 "Adding DeepFlow Labs marketplace"

if claude plugin marketplace list 2>/dev/null | grep -q "deepflow-labs-tools"; then
  print_skip "deepflow-labs-tools marketplace"
else
  print_install "deepflow-labs/ai-skills"
  claude plugin marketplace add deepflow-labs/ai-skills
  print_success "Marketplace added"
fi

echo ""

# ─────────────────────────────────────────────────
# Step 2: Team plugin
# ─────────────────────────────────────────────────

print_step 2 "Installing DeepFlow Labs team plugin"

if claude plugin list 2>/dev/null | grep -q "deepflow-labs-tools@deepflow-labs-tools"; then
  print_skip "deepflow-labs-tools"
else
  print_install "deepflow-labs-tools@deepflow-labs-tools"
  claude plugin install deepflow-labs-tools@deepflow-labs-tools
  print_success "Team plugin installed (skills + MCP servers)"
fi

echo ""

# ─────────────────────────────────────────────────
# Step 3: Official plugins
# ─────────────────────────────────────────────────

print_step 3 "Installing recommended official plugins"

OFFICIAL_PLUGINS=(
  "github@claude-plugins-official"
  "commit-commands@claude-plugins-official"
  "pr-review-toolkit@claude-plugins-official"
  "code-review@claude-plugins-official"
  "code-simplifier@claude-plugins-official"
  "feature-dev@claude-plugins-official"
  "skill-creator@claude-plugins-official"
  "hookify@claude-plugins-official"
  "explanatory-output-style@claude-plugins-official"
)

INSTALLED_PLUGINS=$(claude plugin list 2>/dev/null || echo "")

for plugin in "${OFFICIAL_PLUGINS[@]}"; do
  short_name="${plugin%%@*}"
  if echo "$INSTALLED_PLUGINS" | grep -q "$plugin"; then
    print_skip "$short_name"
  else
    print_install "$short_name"
    claude plugin install "$plugin" || print_warn "Failed to install $short_name — install manually later"
  fi
done

echo ""

# ─────────────────────────────────────────────────
# Step 4: Summary
# ─────────────────────────────────────────────────

print_step 4 "Setup complete"

echo ""
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}  You're all set!${NC}"
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Team skills available:${NC}"
echo -e "    /deepflow-labs-tools:review-skill"
echo ""
echo -e "  ${BOLD}MCP servers bundled:${NC}"
echo -e "    Linear (project management)"
echo -e "    Clerk (authentication)"
echo -e "    Convex (backend)"
echo -e "    Vercel (deployment)"
echo -e "    Playwright (browser automation)"
echo ""
echo -e "  ${BOLD}Next steps:${NC}"
echo -e "    1. Run ${CYAN}claude${NC} in any DeepFlow Labs repo"
echo -e "    2. Authenticate Linear, Clerk, and Vercel when prompted (first time only)"
echo -e "    3. Log in to Convex: ${CYAN}npx convex login${NC} (if not already logged in)"
echo ""
echo -e "  ${BOLD}${YELLOW}Enable auto-updates (recommended):${NC}"
echo -e "    Inside Claude Code, run ${CYAN}/plugin${NC} → Marketplaces → deepflow-labs-tools → Enable auto-update"
echo -e "    This ensures you automatically get new skills and improvements."
echo ""
