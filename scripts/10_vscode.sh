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
  # ── Vue / TypeScript ──────────────────────────────
  "Vue.volar"                             # Vue Language Features
  "ms-vscode.vscode-typescript-next"      # TypeScript 최신 버전
  "antfu.goto-alias"                      # @ 경로 바로 이동 (Vue 필수)

  # ── 린트 / 포맷 ───────────────────────────────────
  "dbaeumer.vscode-eslint"                # ESLint
  "esbenp.prettier-vscode"                # Prettier

  # ── 스타일 ────────────────────────────────────────
  "bradlc.vscode-tailwindcss"             # Tailwind CSS IntelliSense
  "antfu.iconify"                         # Iconify 아이콘 미리보기
  "naumovs.color-highlight"               # HEX 색상 미리보기

  # ── 에디터 UX ─────────────────────────────────────
  "oderwat.indent-rainbow"                # 들여쓰기 단계별 컬러
  "vincaslt.highlight-matching-tag"       # HTML 태그 쌍 하이라이트
  "formulahendry.auto-rename-tag"         # HTML 태그 자동 쌍 수정
  "aaron-bond.better-comments"            # TODO/FIXME/! 색상 강조
  "christian-kohler.path-intellisense"    # 경로 자동완성
  "wix.vscode-import-cost"                # import 번들 크기 표시
  "streetsidesoftware.code-spell-checker" # 영문 스펠링 체크

  # ── Git ───────────────────────────────────────────
  "eamodio.gitlens"                       # Git blame / history
  "mhutchie.git-graph"                    # git 브랜치 그래프 시각화

  # ── 테스트 ────────────────────────────────────────
  "ZixuanChen.vitest-explorer"            # Vitest 테스트 러너 UI
  "antfu.vite"                            # Vite 지원

  # ── 원격 / 컨테이너 ───────────────────────────────
  "ms-vscode-remote.remote-containers"    # Dev Containers (Docker 연동)

  # ── 테마 / UI ─────────────────────────────────────
  "PKief.material-icon-theme"             # 파일 아이콘 테마
  "dracula-theme.theme-dracula"           # Dracula 테마

  # ── 기타 ──────────────────────────────────────────
  "usernamehw.errorlens"                  # 인라인 에러 표시
  "MS-CEINTL.vscode-language-pack-ko"     # 한국어 팩
  "GitHub.copilot"                        # GitHub Copilot
  "GitHub.copilot-chat"                   # GitHub Copilot Chat
)

for ext in "${EXTENSIONS[@]}"; do
  id="${ext%%#*}"; id="${id//[[:space:]]/}"
  $CLI --install-extension "$id" --force &>/dev/null \
    && success "$id" \
    || warn "$id 설치 실패 (건너뜀)"
done

# ── settings.json / keybindings.json 복사 ─────────────
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../dotfiles" && pwd)"

if [[ "$CLI" == "cursor" ]]; then
  SETTINGS_DIR="$HOME/Library/Application Support/Cursor/User"
else
  SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
fi

mkdir -p "$SETTINGS_DIR"
backup_and_copy "$DOTFILES_DIR/vscode/settings.json"    "$SETTINGS_DIR/settings.json"
backup_and_copy "$DOTFILES_DIR/vscode/keybindings.json" "$SETTINGS_DIR/keybindings.json"
