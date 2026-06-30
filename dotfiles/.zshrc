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

# ── pnpm ──────────────────────────────────────────────
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ── 기본 에디터 ───────────────────────────────────────
if command -v cursor &>/dev/null; then
  export EDITOR="cursor --wait"
elif command -v code &>/dev/null; then
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

# ── npm / pnpm ────────────────────────────────────────
alias dev="npm run dev"
alias build="npm run build"
alias pi="pnpm install"
alias pa="pnpm add"
alias pr="pnpm run"
alias pd="pnpm dev"

# ── Powerlevel10k 설정 로드 ───────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
