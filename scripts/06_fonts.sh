#!/bin/bash

# Nerd Font 탭 추가
if ! brew tap | grep -q "homebrew/cask-fonts"; then
  brew tap homebrew/cask-fonts 2>/dev/null || true
fi

FONTS=(
  font-meslo-lg-nerd-font   # MesloLGS NF - oh-my-zsh 아이콘/테마 필수
  font-d2coding              # D2Coding - 한글 코딩 폰트
)

for font in "${FONTS[@]}"; do
  name="${font%%#*}"
  name="${name//[[:space:]]/}"
  if brew list --cask "$name" &>/dev/null; then
    success "$name 이미 설치됨"
  else
    log "$name 설치 중..."
    brew install --cask "$name"
    success "$name 설치 완료"
  fi
done
