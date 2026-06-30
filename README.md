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
| jq | JSON 처리 |
| pnpm | 빠른 패키지 매니저 |
| wget | 파일 다운로드 |

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
- Prefix: `Ctrl+A`
- `prefix + r` 설정 리로드
- 패널 분할 시 현재 경로 유지
- vi 복사 모드 (`v` 선택, `y` 클립보드 복사)
- Dracula 테마 상태바 (세션명 / git 브랜치 / 시각)

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
- SSH 키 자동 생성 (`ed25519`) + 공개키 클립보드 복사

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
├── setup.sh                 # 메인 실행 스크립트
├── scripts/
│   ├── 00_xcode.sh          # Xcode Command Line Tools
│   ├── 01_homebrew.sh       # Homebrew 설치
│   ├── 02_ohmyzsh.sh        # oh-my-zsh 설치
│   ├── 03_packages.sh       # CLI 패키지 설치
│   ├── 04_nvm.sh            # NVM + Node.js LTS
│   ├── 05_dotfiles.sh       # dotfiles 복사 (자동 백업)
│   ├── 06_fonts.sh          # 폰트 설치
│   ├── 07_apps.sh           # 앱 설치 (Cask)
│   ├── 08_git.sh            # Git 전역 설정 + SSH 키
│   └── 09_macos.sh          # macOS 시스템 설정
└── dotfiles/
    ├── .zshrc
    ├── .tmux.conf
    └── ghostty/
        ├── config
        └── themes/
            └── Dracula+
```

> 기존 설정 파일이 있으면 `~/.dotfiles_backup/<timestamp>/` 에 자동 백업됩니다.
