#!/bin/bash

PACKAGES=(
  zsh-autosuggestions    # 명령어 자동완성 제안
  zsh-syntax-highlighting # 문법 하이라이팅
  fzf                    # 퍼지 검색 (Ctrl+R, Ctrl+T)
  zoxide                 # 스마트 cd (z 명령어)
  eza                    # 컬러 + 아이콘 ls 대체
  bat                    # 문법 하이라이팅 cat 대체
  tmux                   # 터미널 멀티플렉서
  gh                     # GitHub CLI
  jq                     # JSON 처리
  pnpm                   # 빠른 npm 대체 패키지 매니저
  wget                   # 파일 다운로드
)

for pkg in "${PACKAGES[@]}"; do
  name="${pkg%%#*}"          # 주석 제거
  name="${name//[[:space:]]/}" # 공백 제거
  if brew list "$name" &>/dev/null; then
    success "$name 이미 설치됨"
  else
    log "$name 설치 중..."
    brew install "$name"
    success "$name 설치 완료"
  fi
done
