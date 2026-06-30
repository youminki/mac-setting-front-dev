#!/bin/bash
# 공통 헬퍼 — setup.sh에서 먼저 source됨

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }
step()    { echo -e "\n${BOLD}━━━ $1 ━━━${NC}"; }

brew_install() {
  local name="${1%%#*}"; name="${name//[[:space:]]/}"
  if brew list "$name" &>/dev/null; then
    success "$name 이미 설치됨"
  else
    log "$name 설치 중..."
    brew install "$name" && success "$name 설치 완료" || warn "$name 설치 실패 (건너뜀)"
  fi
}

cask_install() {
  local name="${1%%#*}"; name="${name//[[:space:]]/}"
  if brew list --cask "$name" &>/dev/null; then
    success "$name 이미 설치됨"
  else
    log "$name 설치 중..."
    brew install --cask "$name" && success "$name 설치 완료" || warn "$name 설치 실패 (건너뜀)"
  fi
}

BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

backup_and_copy() {
  local src="$1" dest="$2"
  if [[ -f "$dest" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp "$dest" "$BACKUP_DIR/$(basename "$dest")"
    warn "기존 $(basename "$dest") → $BACKUP_DIR 백업"
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  success "$(basename "$dest") 적용 완료"
}
