#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

# homebrew/cask-fonts tap은 Homebrew 4.x부터 불필요 (homebrew-cask에 통합됨)

FONTS=(
  "font-meslo-lg-nerd-font  # MesloLGS NF - oh-my-zsh 아이콘/테마 필수"
  "font-d2coding             # D2Coding - 한글 코딩 폰트"
)

for font in "${FONTS[@]}"; do
  cask_install "$font"
done
