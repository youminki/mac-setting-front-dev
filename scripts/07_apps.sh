#!/bin/bash

APPS=(
  "ghostty"              # 터미널
  "cursor"               # AI 코드 에디터
  "google-chrome"        # 브라우저
  "arc"                  # 브라우저 (개발자 친화적)
  "rectangle"            # 윈도우 매니저 (단축키로 창 크기 조절)
  "raycast"              # Spotlight 대체 (런처 + 스니펫 + 클립보드)
  "docker"               # 컨테이너
  "figma"                # 디자인 협업
  "postman"              # API 테스트
)

for app in "${APPS[@]}"; do
  name="${app%%#*}"
  name="${name//[[:space:]]/}"
  if brew list --cask "$name" &>/dev/null; then
    success "$name 이미 설치됨"
  else
    log "$name 설치 중..."
    brew install --cask "$name" && success "$name 설치 완료" \
      || warn "$name 설치 실패 (건너뜀)"
  fi
done
