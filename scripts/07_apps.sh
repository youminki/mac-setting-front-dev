#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

APPS=(
  "ghostty       # 터미널"
  "visual-studio-code # 코드 에디터"
  "claude        # Claude 데스크톱 앱 (LLM)"
  "claude-code   # Claude Code CLI (터미널 AI 코딩)"
  "google-chrome # 브라우저"
  "arc           # 개발자 친화적 브라우저"
  "rectangle     # 윈도우 매니저"
  "raycast       # Spotlight 대체 (런처 + 클립보드)"
  "docker        # 컨테이너"
  "figma         # 디자인 협업"
  "postman       # API 테스트"
  "tableplus     # DB GUI 클라이언트"
)

for app in "${APPS[@]}"; do
  cask_install "$app"
done
