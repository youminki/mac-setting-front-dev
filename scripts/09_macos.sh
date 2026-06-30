#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

log "macOS 시스템 설정 적용 중..."

# ── Finder ────────────────────────────────────────────
defaults write com.apple.finder AppleShowAllFiles -bool true          # 숨김 파일 표시
defaults write NSGlobalDomain AppleShowAllExtensions -bool true        # 파일 확장자 표시
defaults write com.apple.finder ShowPathbar -bool true                 # 경로 바 표시
defaults write com.apple.finder ShowStatusBar -bool true               # 상태 바 표시
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"   # 현재 폴더에서 검색
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # 네트워크 .DS_Store 방지
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ── Dock ──────────────────────────────────────────────
defaults write com.apple.dock autohide -bool true                      # Dock 자동 숨김
defaults write com.apple.dock autohide-delay -float 0                  # 딜레이 제거
defaults write com.apple.dock autohide-time-modifier -float 0.3        # 애니메이션 빠르게
defaults write com.apple.dock show-recents -bool false                 # 최근 앱 숨김
defaults write com.apple.dock tilesize -int 48                         # 아이콘 크기

# ── 키보드 ────────────────────────────────────────────
defaults write NSGlobalDomain KeyRepeat -int 2                         # 키 반복 속도 빠르게
defaults write NSGlobalDomain InitialKeyRepeat -int 15                 # 반복 시작 딜레이 짧게
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false     # 키 꾹 누르면 반복

# ── 트랙패드 ──────────────────────────────────────────
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1      # 탭으로 클릭

# ── 스크린샷 ──────────────────────────────────────────
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots  # 저장 위치
defaults write com.apple.screencapture type -string "png"              # PNG 형식
defaults write com.apple.screencapture disable-shadow -bool true       # 그림자 제거

# ── 기타 ──────────────────────────────────────────────
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # 자동 수정 끄기
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # 자동 대문자 끄기
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false  # 자동 마침표 끄기

# ── 적용 ──────────────────────────────────────────────
killall Finder 2>/dev/null || true
killall Dock   2>/dev/null || true

success "macOS 시스템 설정 완료"
