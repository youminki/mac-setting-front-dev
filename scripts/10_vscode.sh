#!/bin/bash

# Cursor 또는 VS Code CLI 감지
if command -v cursor &>/dev/null; then
  CLI="cursor"
elif command -v code &>/dev/null; then
  CLI="code"
else
  warn "Cursor / VS Code CLI를 찾을 수 없습니다. 앱을 먼저 실행한 뒤 다시 시도하세요."
  return 0
fi

log "$CLI 확장프로그램 설치 중..."

EXTENSIONS=(
  # ── Vue / TypeScript ───────────────────────────────
  "Vue.volar"                          # Vue Language Features (Volar)
  "dbaeumer.vscode-eslint"             # ESLint
  "esbenp.prettier-vscode"             # Prettier

  # ── 스타일 ────────────────────────────────────────
  "bradlc.vscode-tailwindcss"          # Tailwind CSS IntelliSense
  "naumovs.color-highlight"            # HEX 색상 미리보기

  # ── 생산성 ────────────────────────────────────────
  "eamodio.gitlens"                    # GitLens (git blame, history)
  "usernamehw.errorlens"               # 인라인 에러 표시
  "christian-kohler.path-intellisense" # 경로 자동완성
  "formulahendry.auto-rename-tag"      # HTML 태그 자동 쌍 수정
  "wix.vscode-import-cost"             # import 번들 크기 표시

  # ── 테마 / UI ─────────────────────────────────────
  "PKief.material-icon-theme"          # 파일 아이콘 테마
  "dracula-theme.theme-dracula"        # Dracula 테마

  # ── TypeScript / Vite ────────────────────────────────
  "ms-vscode.vscode-typescript-next"      # TypeScript 최신 버전
  "antfu.vite"                            # Vite 지원

  # ── 기타 ──────────────────────────────────────────
  "streetsidesoftware.code-spell-checker" # 영문 스펠링 체크
  "MS-CEINTL.vscode-language-pack-ko"     # 한국어 팩
  "GitHub.copilot"                        # GitHub Copilot
  "GitHub.copilot-chat"                   # GitHub Copilot Chat
)

for ext in "${EXTENSIONS[@]}"; do
  id="${ext%%#*}"
  id="${id//[[:space:]]/}"
  $CLI --install-extension "$id" --force &>/dev/null \
    && success "$id" \
    || warn "$id 설치 실패 (건너뜀)"
done

# ── settings.json 복사 ────────────────────────────────
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../dotfiles" && pwd)"

if [[ "$CLI" == "cursor" ]]; then
  SETTINGS_DIR="$HOME/Library/Application Support/Cursor/User"
else
  SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
fi

mkdir -p "$SETTINGS_DIR"

if [[ -f "$SETTINGS_DIR/settings.json" ]]; then
  BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  cp "$SETTINGS_DIR/settings.json" "$BACKUP_DIR/vscode_settings.json"
  warn "기존 settings.json → $BACKUP_DIR 백업"
fi

cp "$DOTFILES_DIR/vscode/settings.json" "$SETTINGS_DIR/settings.json"
success "settings.json 적용 완료"

cp "$DOTFILES_DIR/vscode/keybindings.json" "$SETTINGS_DIR/keybindings.json"
success "keybindings.json 적용 완료"
