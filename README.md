# dotfiles

Personal configuration files for macOS and Windows, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Mac setup
```bash
git clone https://github.com/sgt0ddball/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

## Windows setup
```powershell
git clone https://github.com/sgt0ddball/dotfiles.git $HOME\dotfiles
# Run as Administrator:
.\bootstrap.ps1
```

## What's in here

| Package | Config |
|---------|--------|
| zsh | `.zshrc`, `.zprofile`, `.zshenv` |
| vim | `.vimrc` |
| starship | `starship.toml` |
| ghostty | Ghostty terminal config |
| tmux | `tmux.conf` |
| gh | GitHub CLI config |
| windows/terminal | Windows Terminal `settings.json` |
| windows/glazewm | GlazeWM `config.yaml` |

## Adding a new config
```bash
mkdir -p ~/dotfiles/<package>
mv ~/.config/<tool>/config ~/dotfiles/<package>/.config/<tool>/
stow --dir=$HOME/dotfiles --target=$HOME <package>
```
