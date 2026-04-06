#!/usr/bin/env bash
set -e

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install stow

DOTFILES="$HOME/dotfiles"
PACKAGES=(zsh vim ssh starship ghostty tmux gh)

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg..."
  stow --dir="$DOTFILES" --target="$HOME" "$pkg"
done

echo "Done."
