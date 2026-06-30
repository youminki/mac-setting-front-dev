#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../dotfiles" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

backup_and_copy() {
  local src="$1"
  local dest="$2"

  if [[ -f "$dest" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp "$dest" "$BACKUP_DIR/$(basename "$dest")"
    warn "기존 $(basename "$dest") → $BACKUP_DIR 백업"
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  success "$(basename "$dest") 적용 완료"
}

backup_and_copy "$DOTFILES_DIR/.zshrc"          "$HOME/.zshrc"
backup_and_copy "$DOTFILES_DIR/.tmux.conf"      "$HOME/.tmux.conf"
backup_and_copy "$DOTFILES_DIR/.editorconfig"   "$HOME/.editorconfig"

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

backup_and_copy "$DOTFILES_DIR/ghostty/config"  "$HOME/.config/ghostty/config"

mkdir -p "$HOME/.config/ghostty/themes"
cp "$DOTFILES_DIR/ghostty/themes/Dracula+" "$HOME/.config/ghostty/themes/Dracula+"
success "Ghostty Dracula+ 테마 적용 완료"
