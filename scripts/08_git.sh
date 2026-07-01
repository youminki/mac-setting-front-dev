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
  success "SSH 키 생성 완료"
fi

# ── GitHub CLI 인증 + 키 등록 ─────────────────────────
if command -v gh &>/dev/null; then
  if gh auth status &>/dev/null; then
    success "GitHub CLI 이미 인증됨"
  else
    log "GitHub 로그인 (브라우저가 열립니다)..."
    if gh auth login --git-protocol ssh --web; then
      success "GitHub 로그인 완료"
    else
      warn "GitHub 로그인 실패/건너뜀 — 나중에 'gh auth login' 실행"
    fi
  fi

  # 인증됐으면 공개키를 authentication + signing 키로 자동 등록 (이미 있으면 무시됨)
  if gh auth status &>/dev/null; then
    host=$(hostname -s)
    gh ssh-key add "${SSH_KEY}.pub" --title "$host" --type authentication &>/dev/null \
      && success "SSH 인증 키 등록 완료" || warn "SSH 인증 키 등록 건너뜀 (이미 등록/권한)"
    gh ssh-key add "${SSH_KEY}.pub" --title "$host (signing)" --type signing &>/dev/null \
      && success "SSH 서명 키 등록 완료" || warn "SSH 서명 키 등록 건너뜀 (이미 등록/권한)"
  fi
else
  warn "gh(GitHub CLI)가 없어요 — 공개키를 수동 등록하세요:"
  echo -e "\n$(cat "${SSH_KEY}.pub")\n"
  pbcopy < "${SSH_KEY}.pub" && success "공개키가 클립보드에 복사됐습니다"
fi

# ── 자체 호스팅 GitLab 자동 인증 (선택) ───────────────
# GITLAB_HOST 환경변수가 설정된 경우에만 실행 (glab이 이 변수를 네이티브로 인식).
#   예)  GITLAB_HOST=git.example.com ./setup.sh
if [[ -n "$GITLAB_HOST" ]]; then
  if command -v glab &>/dev/null; then
    if glab auth status &>/dev/null; then
      success "GitLab($GITLAB_HOST) 이미 인증됨"
    else
      log "GitLab($GITLAB_HOST) 로그인..."
      glab auth login --hostname "$GITLAB_HOST" \
        && success "GitLab 로그인 완료" \
        || warn "GitLab 로그인 실패/건너뜀 — 나중에 'glab auth login --hostname $GITLAB_HOST'"
    fi
    # 인증됐으면 공개키 자동 등록 (이미 있으면 무시됨)
    if glab auth status &>/dev/null; then
      glab ssh-key add "${SSH_KEY}.pub" --title "$(hostname -s)" &>/dev/null \
        && success "GitLab SSH 키 등록 완료" \
        || warn "GitLab SSH 키 등록 건너뜀 (이미 등록/권한)"
    fi
  else
    warn "glab 미설치 — 'brew install glab' 후 다시 실행하세요"
  fi
fi

# ── SSH 커밋 서명 (GitHub / GitLab 'Verified' 배지) ───
git config --global gpg.format ssh
git config --global user.signingkey "${SSH_KEY}.pub"
git config --global commit.gpgsign true
git config --global tag.gpgsign true
success "SSH 커밋 서명 설정 완료"
