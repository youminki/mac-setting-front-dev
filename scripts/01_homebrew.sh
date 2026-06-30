#!/bin/bash

if command -v brew &>/dev/null; then
  success "Homebrew 이미 설치됨 ($(brew --version | head -1))"
else
  log "Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon / Intel 경로 분기
  if [[ -f /opt/homebrew/bin/brew ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  success "Homebrew 설치 완료"
fi
