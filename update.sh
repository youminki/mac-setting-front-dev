#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"

echo -e "${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║   Mac Frontend Dev Setup — 업데이트  ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

step "1/5  Homebrew 업데이트"
brew update && brew upgrade && brew cleanup --prune=all
success "Homebrew 업데이트 완료"

step "2/5  oh-my-zsh 업데이트"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  zsh -i -c "omz update --unattended" 2>/dev/null || warn "oh-my-zsh 업데이트 실패 (건너뜀)"
  success "oh-my-zsh 업데이트 완료"
else
  warn "oh-my-zsh가 설치되어 있지 않아요"
fi

step "3/5  Powerlevel10k 업데이트"
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ -d "$P10K_DIR/.git" ]]; then
  git -C "$P10K_DIR" pull --ff-only
  success "Powerlevel10k 업데이트 완료"
else
  warn "Powerlevel10k가 설치되어 있지 않아요 (./scripts/02_ohmyzsh.sh 실행)"
fi

step "4/5  npm 전역 패키지 업데이트"
if command -v npm &>/dev/null; then
  npm update -g 2>/dev/null && success "npm 전역 패키지 업데이트 완료" || warn "npm 업데이트 실패"
else
  warn "npm이 설치되어 있지 않아요"
fi

step "5/5  VS Code 확장 업데이트"
if command -v code &>/dev/null; then
  log "설치된 확장 업데이트 중..."
  code --list-extensions | while read -r ext; do
    code --install-extension "$ext" --force &>/dev/null \
      && success "$ext" \
      || warn "$ext 업데이트 실패 (건너뜀)"
  done
else
  warn "VS Code CLI(code)를 찾을 수 없어요"
fi

echo -e "\n${GREEN}${BOLD}✓ 업데이트 완료!${NC}"
echo -e "  터미널을 재시작하거나 ${YELLOW}source ~/.zshrc${NC} 를 실행하세요.\n"
