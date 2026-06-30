#!/bin/bash

if xcode-select -p &>/dev/null; then
  success "Xcode Command Line Tools 이미 설치됨"
else
  log "Xcode Command Line Tools 설치 중... (팝업 창에서 설치 클릭)"
  xcode-select --install
  # 설치 완료 대기
  until xcode-select -p &>/dev/null; do sleep 5; done
  success "Xcode Command Line Tools 설치 완료"
fi
