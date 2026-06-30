export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ── NVM ───────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

# ── fzf (퍼지 검색) ───────────────────────────────────
eval "$(fzf --zsh)"
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

# ── Git ───────────────────────────────────────────────
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --all"
alias gb="git branch"
alias gaa="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

# ── npm ───────────────────────────────────────────────
alias dev="npm run dev"
alias build="npm run build"
