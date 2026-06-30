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
