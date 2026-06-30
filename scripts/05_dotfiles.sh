#!/bin/bash
[[ "$(type -t log)" != "function" ]] && source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../dotfiles" && pwd)"

backup_and_copy "$DOTFILES_DIR/.zshrc"        "$HOME/.zshrc"
backup_and_copy "$DOTFILES_DIR/.tmux.conf"    "$HOME/.tmux.conf"
backup_and_copy "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"
backup_and_copy "$DOTFILES_DIR/.p10k.zsh"     "$HOME/.p10k.zsh"

# .gitconfig: user 설정은 유지하고 나머지만 덮어쓰기
if [[ -f "$HOME/.gitconfig" ]]; then
  saved_name=$(git config --global user.name 2>/dev/null)
  saved_email=$(git config --global user.email 2>/dev/null)
  backup_and_copy "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
  [[ -n "$saved_name" ]]  && git config --global user.name "$saved_name"
  [[ -n "$saved_email" ]] && git config --global user.email "$saved_email"
else
  cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
  success ".gitconfig 적용 완료"
fi

backup_and_copy "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
mkdir -p "$HOME/.config/ghostty/themes"
cp "$DOTFILES_DIR/ghostty/themes/Dracula+" "$HOME/.config/ghostty/themes/Dracula+"
success "Ghostty Dracula+ 테마 적용 완료"

# ── SSH config ────────────────────────────────────────
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
if [[ ! -f "$HOME/.ssh/config" ]]; then
  cp "$DOTFILES_DIR/.ssh_config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
  success "~/.ssh/config 적용 완료"
else
  success "~/.ssh/config 이미 존재 (건너뜀)"
fi
