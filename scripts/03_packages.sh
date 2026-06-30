#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

PACKAGES=(
  "zsh-autosuggestions    # 명령어 자동완성 제안"
  "zsh-syntax-highlighting # 문법 하이라이팅"
  "fzf                    # 퍼지 검색 (Ctrl+R, Ctrl+T)"
  "zoxide                 # 스마트 cd (z 명령어)"
  "eza                    # 컬러 + 아이콘 ls 대체"
  "bat                    # 문법 하이라이팅 cat 대체"
  "tmux                   # 터미널 멀티플렉서"
  "gh                     # GitHub CLI"
  "jq                     # JSON 처리"
  "pnpm                   # 빠른 패키지 매니저"
  "wget                   # 파일 다운로드"
  "ripgrep                # 빠른 grep 대체 (VS Code 내부 사용)"
  "fd                     # 빠른 find 대체 (fzf 연동)"
  "lazygit                # 터미널 Git TUI"
  "git-delta              # git diff 문법 하이라이팅"
)

for pkg in "${PACKAGES[@]}"; do
  brew_install "$pkg"
done
