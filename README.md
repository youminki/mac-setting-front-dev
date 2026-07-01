# Mac Frontend Dev Setup

깡통 맥에서 프론트엔드 개발 환경을 한 번에 세팅하는 자동화 스크립트.

## 사용법

```bash
git clone https://github.com/youminki/mac-setting-front-dev.git
cd mac-setting-front-dev
chmod +x setup.sh
./setup.sh
```

실행 후 터미널을 재시작하거나 `source ~/.zshrc`.

> **자체 호스팅 GitLab 사용 시** — 세팅 후 아무 때나 `gitlab-auth` 명령을 실행하면 호스트 주소를 물어보고 자동 인증 + SSH 키를 등록합니다.
> ```bash
> gitlab-auth                 # 호스트 주소를 입력받아 인증
> gitlab-auth git.example.com # 주소를 바로 지정
> ```
> setup 단계에서 함께 처리하려면 `GITLAB_HOST=git.example.com ./setup.sh` 로 실행하세요.

---

## 설치 항목

### CLI 도구 (Homebrew)

| 패키지 | 설명 |
|--------|------|
| zsh-autosuggestions | 명령어 자동완성 제안 |
| zsh-syntax-highlighting | 문법 하이라이팅 |
| fzf | 퍼지 검색 (`Ctrl+R`, `Ctrl+T`) |
| zoxide | 스마트 `cd` (`z` 명령어) |
| eza | 컬러 + 아이콘 `ls` 대체 |
| bat | 문법 하이라이팅 `cat` 대체 |
| tmux | 터미널 멀티플렉서 |
| gh | GitHub CLI |
| glab | GitLab CLI (자체 호스팅 지원) |
| jq | JSON 처리 |
| pnpm | 빠른 패키지 매니저 |
| wget | 파일 다운로드 |
| ripgrep | 빠른 grep 대체 (VS Code 내부 사용) |
| fd | 빠른 find 대체 (fzf 연동) |
| lazygit | 터미널 Git TUI |
| git-delta | git diff 문법 하이라이팅 |

### VS Code / Cursor 확장프로그램

> 총 32개 설치 — 전체 목록은 `scripts/10_vscode.sh` 참고. 주요 항목만 아래에 정리.

| 확장프로그램 | 설명 |
|------------|------|
| Vue.volar | Vue Language Features |
| dbaeumer.vscode-eslint | ESLint |
| esbenp.prettier-vscode | Prettier |
| bradlc.vscode-tailwindcss | Tailwind CSS IntelliSense |
| eamodio.gitlens | Git blame / history |
| mhutchie.git-graph | git 브랜치 그래프 |
| usernamehw.errorlens | 인라인 에러 표시 |
| christian-kohler.path-intellisense | 경로 자동완성 |
| formulahendry.auto-rename-tag | HTML 태그 자동 쌍 수정 |
| wix.vscode-import-cost | import 번들 크기 표시 |
| naumovs.color-highlight | HEX 색상 미리보기 |
| vitest.explorer | Vitest 테스트 러너 UI |
| PKief.material-icon-theme | 파일 아이콘 테마 |
| dracula-theme.theme-dracula | Dracula 테마 |
| MS-CEINTL.vscode-language-pack-ko | 한국어 팩 |

> Copilot은 Cursor에 AI가 내장돼 있어 설치하지 않습니다.

`settings.json` 주요 설정:
- `formatOnSave` + Prettier (singleQuote, no semi, trailingComma)
- ESLint `fixAll` on save
- Dracula 테마 + Material Icon
- 폰트: D2Coding / MesloLGS NF
- 터미널 폰트: MesloLGS NF

### 앱 (Homebrew Cask)

| 앱 | 설명 |
|----|------|
| Ghostty | 터미널 |
| Cursor | AI 코드 에디터 |
| Google Chrome | 브라우저 |
| Arc | 개발자 친화적 브라우저 |
| Rectangle | 단축키 윈도우 매니저 |
| Raycast | Spotlight 대체 (런처 + 클립보드) |
| Docker | 컨테이너 |
| Figma | 디자인 협업 |
| Postman | API 테스트 |
| TablePlus | DB GUI 클라이언트 |

### 폰트

| 폰트 | 용도 |
|------|------|
| MesloLGS NF (Nerd Font) | oh-my-zsh 아이콘/테마 필수 |
| D2Coding | 한글 코딩 폰트 |

---

## 적용되는 설정

### zsh (`.zshrc`)
- `→` 키로 자동완성 수락
- 히스토리 10,000개, 중복 제거, 세션 간 공유
- `z <디렉토리>` 로 자주 가는 곳 빠르게 이동
- `ls` / `ll` / `la` / `lt` → eza (아이콘 + git 상태)
- `cat` → bat (문법 하이라이팅)
- `.nvmrc` 감지 시 디렉토리 이동만으로 Node 버전 자동 전환
- nvm lazy loading (터미널 시작 속도 개선)

**Git 단축키**
```
gs   git status        gaa  git add .
gd   git diff          gc   git commit -m
gl   git log --graph   gp   git push
gb   git branch        gpl  git pull
```

**npm 단축키**
```
dev    npm run dev
build  npm run build
```

### tmux (`.tmux.conf`)
- Prefix: `Ctrl+B` (기본값)
- `prefix + r` 설정 리로드
- `prefix + 4` 현재 윈도우 2×2 4분할 / 새 세션은 자동 4분할
- `prefix + " / %` 상하·좌우 분할 (현재 경로 유지)
- vi 복사 모드 (`v` 선택, `y` 클립보드 복사)
- 마우스 지원, Dracula 테마 상태바 (세션명 / git 브랜치 / 시각)

### Ghostty (`~/.config/ghostty/config`)
- Dracula+ 테마
- 폰트: MesloLGS NF + Apple SD Gothic Neo (한글)
- 배경 투명도 + 블러
- `Cmd+D` 수직 분할 / `Cmd+Shift+D` 수평 분할
- `Option` 키 → Alt (터미널 단축키 호환)

### Git 전역 설정
- `init.defaultBranch = main`
- `pull.rebase = false`
- `~/.gitignore_global` (`.DS_Store`, `.env`, `node_modules` 등)
- **호스트별 SSH 키 분리** (정석) — GitHub은 `id_ed25519`, GitLab은 `id_ed25519_gitlab`
- `gh`로 GitHub 로그인 + 공개키를 인증·서명 키로 자동 등록 (`gh` 없으면 클립보드 복사로 폴백)
- `gitlab-auth` / `GITLAB_HOST` 지정 시 `glab`로 자체 호스팅 GitLab 자동 인증
  (전용 키 생성 → `~/.ssh/config` 호스트 블록 추가 → 키 등록 → 호스트별 서명까지 자동)
- **SSH 커밋 서명** 활성화 — GitHub 저장소는 GitHub 키, GitLab 저장소는 `includeIf`로 GitLab 키 (`Verified` 배지)

### macOS 시스템 설정 (선택)
- Finder: 숨김 파일 표시, 확장자 표시, 경로 바 표시
- Dock: 자동 숨김, 딜레이 제거
- 키보드: 키 반복 속도 최대
- 트랙패드: 탭으로 클릭
- 스크린샷: `~/Pictures/Screenshots` 저장, 그림자 제거
- 자동 수정 / 자동 대문자 끄기

---

## 구조

```
mac-setting-front-dev/
├── setup.sh                 # 메인 실행 스크립트 (전체 세팅)
├── update.sh                # 업데이트 (repo pull + brew/omz/p10k/npm/확장)
├── scripts/
│   ├── utils.sh             # 공통 헬퍼 (로그, brew/cask 설치, 백업)
│   ├── 00_xcode.sh          # Xcode CLT + Rosetta 2 (Apple Silicon)
│   ├── 01_homebrew.sh       # Homebrew 설치
│   ├── 02_ohmyzsh.sh        # oh-my-zsh + Powerlevel10k
│   ├── 03_packages.sh       # CLI 패키지 설치
│   ├── 04_nvm.sh            # NVM + Node.js LTS
│   ├── 05_dotfiles.sh       # dotfiles 복사 (자동 백업)
│   ├── 06_fonts.sh          # 폰트 설치
│   ├── 07_apps.sh           # 앱 설치 (Cask)
│   ├── 08_git.sh            # Git 전역 설정 + SSH 키
│   ├── 09_macos.sh          # macOS 시스템 설정
│   └── 10_vscode.sh         # VS Code / Cursor 확장 + settings/keybindings/snippets
└── dotfiles/
    ├── .zshrc
    ├── .tmux.conf
    ├── .gitconfig
    ├── .editorconfig
    ├── .ssh_config
    ├── .p10k.zsh
    ├── ghostty/
    │   ├── config
    │   └── themes/Dracula+
    ├── lazygit/
    │   └── config.yml
    └── vscode/
        ├── settings.json
        ├── keybindings.json
        └── snippets/{vue,typescript}.json
```

> 기존 설정 파일이 있으면 `~/.dotfiles_backup/<timestamp>/` 에 자동 백업됩니다.
