#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

# .gitconfig는 05_dotfiles.sh에서 이미 복사됨
# user 정보와 excludesfile만 여기서 추가 설정
git config --global core.excludesfile ~/.gitignore_global

# ── .gitignore_global ─────────────────────────────────
cat > ~/.gitignore_global << 'EOF'
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Thumbs.db
.env
.env.local
.env.*.local
node_modules/
dist/
.idea/
.vscode/
*.log
EOF
success "~/.gitignore_global 생성 완료"

# ── Git user 설정 ──────────────────────────────────────
current_name=$(git config --global user.name 2>/dev/null)
current_email=$(git config --global user.email 2>/dev/null)

if [[ -z "$current_name" ]]; then
  echo -n "  Git 이름을 입력하세요: "
  read -r git_name
  git config --global user.name "$git_name"
fi

if [[ -z "$current_email" ]]; then
  echo -n "  Git 이메일을 입력하세요: "
  read -r git_email
  git config --global user.email "$git_email"
fi

success "Git 전역 설정 완료 ($(git config --global user.name) / $(git config --global user.email))"

# ── SSH 키 ─────────────────────────────────────────────
SSH_KEY="$HOME/.ssh/id_ed25519"

if [[ -f "$SSH_KEY" ]]; then
  success "SSH 키 이미 존재: $SSH_KEY"
else
  git_email=$(git config --global user.email)
  log "SSH 키 생성 중..."
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  ssh-keygen -t ed25519 -C "$git_email" -f "$SSH_KEY" -N ""
  eval "$(ssh-agent -s)" &>/dev/null
  ssh-add "$SSH_KEY"

  echo ""
  warn "아래 공개키를 GitHub → Settings → SSH Keys에 등록하세요:"
  echo -e "\n$(cat "${SSH_KEY}.pub")\n"
  pbcopy < "${SSH_KEY}.pub"
  success "공개키가 클립보드에 복사됐습니다"
fi
