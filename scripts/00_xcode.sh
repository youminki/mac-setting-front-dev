#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

if xcode-select -p &>/dev/null; then
  success "Xcode Command Line Tools 이미 설치됨"
else
  log "Xcode Command Line Tools 설치 중... (팝업 창에서 설치 클릭)"
  xcode-select --install
  # 설치 완료 대기
  until xcode-select -p &>/dev/null; do sleep 5; done
  success "Xcode Command Line Tools 설치 완료"
fi

# ── Rosetta 2 (Apple Silicon 전용) ────────────────────
# 일부 x86 전용 앱/도구가 요구 — 깡통 맥에는 없으므로 미리 설치
if [[ "$(uname -m)" == "arm64" ]]; then
  if /usr/bin/pgrep -q oahd; then
    success "Rosetta 2 이미 설치됨"
  else
    log "Rosetta 2 설치 중..."
    softwareupdate --install-rosetta --agree-to-license \
      && success "Rosetta 2 설치 완료" \
      || warn "Rosetta 2 설치 실패 (건너뜀)"
  fi
fi
