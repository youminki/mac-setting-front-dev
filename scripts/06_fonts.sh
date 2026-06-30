#!/bin/bash

FONTS=(
  "font-meslo-lg-nerd-font  # MesloLGS NF - oh-my-zsh 아이콘/테마 필수"
  "font-d2coding             # D2Coding - 한글 코딩 폰트"
)

for font in "${FONTS[@]}"; do
  cask_install "$font"
done
