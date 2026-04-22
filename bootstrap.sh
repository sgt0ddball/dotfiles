#!/usr/bin/env bash
# bootstrap.sh
# Configs managed by this script:
#   - starship/starship.toml -> ~/.config/starship.toml
#   - zebar/                 -> ~/.glzr/zebar (if on Linux)
#   - vim/                   -> ~/.vim
#   - zsh/                   -> ~/.zshrc
#   - ghostty/               -> ~/.config/ghostty
#   - tmux/                  -> ~/.tmux.conf
#   - gh/                    -> ~/.config/gh
# If you add a new config here, add it to bootstrap.ps1 too.

set -e

DOTFILES="$HOME/dotfiles"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# --- Stow ---
brew install stow

# --- Git: clone or pull ---
if [ ! -d "$DOTFILES" ]; then
  echo "Cloning dotfiles repo..."
  git clone https://github.com/YOURUSERNAME/dotfiles.git "$DOTFILES"
else
  echo "Pulling latest dotfiles..."
  git -C "$DOTFILES" pull
fi

# --- Stow packages ---
PACKAGES=(zsh vim ssh starship ghostty tmux gh)
for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg..."
  stow --dir="$DOTFILES" --target="$HOME" "$pkg"
done

echo "Bootstrap complete."