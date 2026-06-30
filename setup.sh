#!/bin/bash
set -e

# ── 색상 ──────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }
step()    { echo -e "\n${BOLD}━━━ $1 ━━━${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║   Mac Frontend Dev Setup  v1.0.0    ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

step "1/5  Homebrew"
source "$SCRIPT_DIR/scripts/01_homebrew.sh"

step "2/5  oh-my-zsh"
source "$SCRIPT_DIR/scripts/02_ohmyzsh.sh"

step "3/5  CLI 패키지"
source "$SCRIPT_DIR/scripts/03_packages.sh"

step "4/5  NVM + Node.js"
source "$SCRIPT_DIR/scripts/04_nvm.sh"

step "5/5  Dotfiles"
source "$SCRIPT_DIR/scripts/05_dotfiles.sh"

echo -e "\n${GREEN}${BOLD}✓ 세팅 완료! 터미널을 재시작하거나 아래를 실행하세요:${NC}"
echo -e "  ${YELLOW}source ~/.zshrc${NC}\n"
