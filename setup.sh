#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"

echo -e "${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║   Mac Frontend Dev Setup  v4.0.0    ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

step " 1/11  Xcode Command Line Tools"
source "$SCRIPT_DIR/scripts/00_xcode.sh"

step " 2/11  Homebrew"
source "$SCRIPT_DIR/scripts/01_homebrew.sh"

step " 3/11  oh-my-zsh"
source "$SCRIPT_DIR/scripts/02_ohmyzsh.sh"

step " 4/11  CLI 패키지"
source "$SCRIPT_DIR/scripts/03_packages.sh"

step " 5/11  NVM + Node.js"
source "$SCRIPT_DIR/scripts/04_nvm.sh"

step " 6/11  Dotfiles"
source "$SCRIPT_DIR/scripts/05_dotfiles.sh"

step " 7/11  폰트"
source "$SCRIPT_DIR/scripts/06_fonts.sh"

step " 8/11  앱 설치"
source "$SCRIPT_DIR/scripts/07_apps.sh"

step " 9/11  Git 설정 + SSH 키"
source "$SCRIPT_DIR/scripts/08_git.sh"

step "10/11  VS Code / Cursor 확장프로그램 + 설정"
source "$SCRIPT_DIR/scripts/10_vscode.sh"

step "11/11  macOS 시스템 설정"
warn "Finder·Dock이 재시작됩니다."
echo -n "  계속하시겠습니까? [y/N] "
read -r answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  source "$SCRIPT_DIR/scripts/09_macos.sh"
else
  warn "macOS 시스템 설정 건너뜀 (나중에 ./scripts/09_macos.sh 로 실행 가능)"
fi

echo -e "\n${GREEN}${BOLD}✓ 모든 세팅 완료! 터미널을 재시작하거나 아래를 실행하세요:${NC}"
echo -e "  ${YELLOW}source ~/.zshrc${NC}\n"
