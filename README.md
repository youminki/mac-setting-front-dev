# Mac Frontend Dev Setup

깡통 맥에서 프론트엔드 개발 환경을 한 번에 세팅하는 자동화 스크립트.

## 설치 항목

| 항목 | 설명 |
|------|------|
| **Homebrew** | macOS 패키지 매니저 |
| **oh-my-zsh** | zsh 프레임워크 |
| **zsh-autosuggestions** | 명령어 자동완성 제안 |
| **zsh-syntax-highlighting** | 문법 하이라이팅 |
| **fzf** | 퍼지 검색 (`Ctrl+R`, `Ctrl+T`) |
| **zoxide** | 스마트 `cd` (`z` 명령어) |
| **eza** | 컬러 + 아이콘 `ls` 대체 |
| **bat** | 문법 하이라이팅 `cat` 대체 |
| **tmux** | 터미널 멀티플렉서 |
| **nvm + Node.js LTS** | Node.js 버전 관리 |

## 사용법

```bash
git clone https://github.com/youminki/mac-setting-front-dev.git
cd mac-setting-front-dev
chmod +x setup.sh
./setup.sh
```

실행 후 터미널을 재시작하거나 `source ~/.zshrc`.

## 적용되는 설정

### zsh (`.zshrc`)
- `→` 키로 자동완성 수락
- 히스토리 10,000개, 중복 제거, 세션 간 공유
- `z <디렉토리>` 로 자주 가는 곳 빠르게 이동
- `ls` / `ll` / `la` / `lt` → eza (아이콘 + git 상태)
- `cat` → bat (문법 하이라이팅)

**Git 단축키**
```
gs  git status        gaa  git add .
gd  git diff          gc   git commit -m
gl  git log --graph   gp   git push
gb  git branch        gpl  git pull
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

## 구조

```
mac-setting-front-dev/
├── setup.sh              # 메인 실행 스크립트
├── scripts/
│   ├── 01_homebrew.sh    # Homebrew 설치
│   ├── 02_ohmyzsh.sh     # oh-my-zsh 설치
│   ├── 03_packages.sh    # CLI 패키지 설치
│   ├── 04_nvm.sh         # NVM + Node.js LTS
│   └── 05_dotfiles.sh    # dotfiles 복사 (기존 파일 자동 백업)
└── dotfiles/
    ├── .zshrc
    ├── .tmux.conf
    └── ghostty/
        ├── config
        └── themes/
            └── Dracula+
```

> 기존 설정 파일이 있으면 `~/.dotfiles_backup/<timestamp>/` 에 자동 백업됩니다.
