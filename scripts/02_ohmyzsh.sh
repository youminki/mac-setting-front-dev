#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  success "oh-my-zsh 이미 설치됨"
else
  log "oh-my-zsh 설치 중..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "oh-my-zsh 설치 완료"
fi

# ── Powerlevel10k 테마 ────────────────────────────────
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ -d "$P10K_DIR" ]]; then
  success "powerlevel10k 이미 설치됨"
else
  log "powerlevel10k 설치 중..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  success "powerlevel10k 설치 완료"
fi
