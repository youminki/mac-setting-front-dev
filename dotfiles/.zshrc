# ── Powerlevel10k Instant Prompt ──────────────────────
# 터미널 시작 속도 개선 — 이 블록은 파일 최상단에 있어야 함
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Homebrew PATH (Apple Silicon / Intel 대응) ────────
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"      # Intel
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ── NVM (lazy loading으로 터미널 시작 속도 개선) ──────
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm  "$@"; }
npx()  { nvm; npx  "$@"; }

# ── .nvmrc 자동 Node 버전 전환 ────────────────────────
# cd 시 상위 경로까지 .nvmrc 탐색 → 해당 버전으로 nvm use (첫 호출 때 nvm lazy-load)
autoload -U add-zsh-hook
_auto_nvmrc() {
  local dir="$PWD" nvmrc=""
  while [[ -n "$dir" && "$dir" != "/" ]]; do
    [[ -f "$dir/.nvmrc" ]] && { nvmrc="$dir/.nvmrc"; break; }
    dir="${dir:h}"
  done
  [[ -z "$nvmrc" ]] && return
  nvm use "$(<"$nvmrc")" &>/dev/null || echo "nvm: $(<"$nvmrc") 미설치 — 'nvm install' 하세요"
}
add-zsh-hook chpwd _auto_nvmrc

# ── pnpm ──────────────────────────────────────────────
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ── 기본 에디터 ───────────────────────────────────────
if command -v code &>/dev/null; then
  export EDITOR="code --wait"
fi

# ── Auto Suggestions ──────────────────────────────────
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── Syntax Highlighting ───────────────────────────────
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# → 키로 자동완성 수락
bindkey '^[[C' autosuggest-accept

# ── History ───────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ── fzf + fd 연동 ─────────────────────────────────────
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ── zoxide (스마트 cd) ────────────────────────────────
eval "$(zoxide init zsh)"
alias cd="z"

# ── eza (컬러 ls) ─────────────────────────────────────
alias ls="eza --icons"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias lt="eza --tree --icons -L 2"

# ── bat (문법 하이라이팅 cat) ─────────────────────────
alias cat="bat --paging=never"

# ── lazygit ───────────────────────────────────────────
alias lg="lazygit"

# ── Git ───────────────────────────────────────────────
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --all"
alias gb="git branch"
alias gaa="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

# ── 자체 호스팅 GitLab 인증 (glab) ────────────────────
# 사용법: gitlab-auth            → 호스트 주소를 물어봄
#         gitlab-auth git.xxx.com → 바로 인증
# GitLab 전용 키(id_ed25519_gitlab)로 호스트별 분리 + 커밋 서명까지 구성
gitlab-auth() {
  local host="$1"
  if [[ -z "$host" ]]; then
    echo -n "GitLab 호스트 주소를 입력하세요 (예: git.example.com): "
    read -r host
  fi
  [[ -z "$host" ]] && { echo "✗ 호스트가 비어 있습니다."; return 1; }
  command -v glab >/dev/null || { echo "✗ glab 미설치 — brew install glab"; return 1; }

  local gkey="$HOME/.ssh/id_ed25519_gitlab"
  # 1) GitLab 전용 키 없으면 생성
  if [[ ! -f "$gkey" ]]; then
    ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f "$gkey" -N "" || return 1
    echo "✓ GitLab 전용 키 생성: $gkey"
  fi
  # 2) ~/.ssh/config 에 호스트 블록 추가 (없을 때만)
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  if ! grep -qiE "^[[:space:]]*Host[[:space:]]+$host([[:space:]]|\$)" ~/.ssh/config 2>/dev/null; then
    cat >> ~/.ssh/config <<EOF

Host $host
  HostName $host
  User git
  IdentityFile ~/.ssh/id_ed25519_gitlab
  IdentitiesOnly yes
  UseKeychain yes
EOF
    chmod 600 ~/.ssh/config
    echo "✓ ~/.ssh/config 에 $host 추가 (전용 키 사용)"
  fi
  # 3) glab 로그인 + 키 등록 (usage-type 기본 auth_and_signing)
  export GITLAB_HOST="$host"
  glab auth login --hostname "$host" || { echo "✗ 로그인 실패"; return 1; }
  glab ssh-key add "$gkey.pub" --title "$(hostname -s)" \
    && echo "✓ SSH 키 등록 완료" || echo "! 키 등록 건너뜀 (이미 등록됨일 수 있음)"
  # 4) ~/dev/GitLab/ 아래 저장소는 GitLab 키로 커밋 서명 (Verified 배지)
  mkdir -p ~/dev/GitLab
  printf '[user]\n\tsigningkey = ~/.ssh/id_ed25519_gitlab.pub\n' > ~/.gitconfig-gitlab
  git config --global "includeIf.gitdir:~/dev/GitLab/.path" "~/.gitconfig-gitlab"
  echo "✓ ~/dev/GitLab/ 아래 저장소는 GitLab 전용 키로 커밋 서명하도록 설정"
  echo "✓ 완료 — 회사 repo는 ~/dev/GitLab/ 아래에 클론하세요 (전용 키·서명 자동 적용)"
}

# ── npm / pnpm ────────────────────────────────────────
alias dev="npm run dev"
alias build="npm run build"
alias pi="pnpm install"
alias pa="pnpm add"
alias pr="pnpm run"
alias pd="pnpm dev"

# ── Powerlevel10k 설정 로드 ───────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
