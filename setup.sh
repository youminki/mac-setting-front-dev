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
echo "  ║   Mac Frontend Dev Setup  v3.0.0    ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

step "1/10  Xcode Command Line Tools"
source "$SCRIPT_DIR/scripts/00_xcode.sh"

step "2/10  Homebrew"
source "$SCRIPT_DIR/scripts/01_homebrew.sh"

step "3/10  oh-my-zsh"
source "$SCRIPT_DIR/scripts/02_ohmyzsh.sh"

step "4/10  CLI 패키지"
source "$SCRIPT_DIR/scripts/03_packages.sh"

step "5/10  NVM + Node.js"
source "$SCRIPT_DIR/scripts/04_nvm.sh"

step "6/10  Dotfiles"
source "$SCRIPT_DIR/scripts/05_dotfiles.sh"

step "7/10  폰트"
source "$SCRIPT_DIR/scripts/06_fonts.sh"

step "8/10  앱 설치"
source "$SCRIPT_DIR/scripts/07_apps.sh"

step "9/10  Git 설정 + SSH 키"
source "$SCRIPT_DIR/scripts/08_git.sh"

step "10/10  VS Code / Cursor 확장프로그램 + 설정"
source "$SCRIPT_DIR/scripts/10_vscode.sh"

echo ""
warn "macOS 시스템 설정을 변경합니다 (Finder·Dock 재시작됨)"
echo -n "  계속하시겠습니까? [y/N] "
read -r answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  source "$SCRIPT_DIR/scripts/09_macos.sh"
fi

echo -e "\n${GREEN}${BOLD}✓ 모든 세팅 완료! 터미널을 재시작하거나 아래를 실행하세요:${NC}"
echo -e "  ${YELLOW}source ~/.zshrc${NC}\n"
