#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

if [[ -d "$HOME/.nvm" ]]; then
  success "nvm 이미 설치됨"
else
  log "nvm 설치 중..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  success "nvm 설치 완료"
fi

# nvm 로드 후 Node.js LTS 설치
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if command -v node &>/dev/null; then
  success "Node.js 이미 설치됨 ($(node -v))"
else
  log "Node.js LTS 설치 중..."
  nvm install --lts
  nvm use --lts
  nvm alias default node
  success "Node.js LTS 설치 완료 ($(node -v))"
fi
