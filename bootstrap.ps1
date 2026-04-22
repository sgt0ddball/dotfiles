# bootstrap.ps1 — run as Administrator
$DOTFILES = "$HOME\dotfiles"

# --- Git: clone or pull ---
if (-not (Test-Path $DOTFILES)) {
  Write-Host "Cloning dotfiles repo..."
  git clone https://github.com/YOURUSERNAME/dotfiles.git $DOTFILES
} else {
  Write-Host "Pulling latest dotfiles..."
  git -C $DOTFILES pull
}

# --- Symlink targets ---
$links = @{
  "$env:USERPROFILE\.glzr\glazewm\config.yaml" = "$DOTFILES\glazewm\config.yaml"
  "$env:USERPROFILE\.glzr\zebar"               = "$DOTFILES\zebar"
  "$env:USERPROFILE\.config\starship.toml"      = "$DOTFILES\starship\starship.toml"
}

foreach ($target in $links.Keys) {
  $source = $links[$target]
  $parentDir = Split-Path $target -Parent
  if (-not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
    Write-Host "Created directory $parentDir"
  }
  if (Test-Path $target) { Remove-Item $target -Recurse -Force }
  New-Item -ItemType SymbolicLink -Path $target -Target $source
  Write-Host "Linked $target"
}

Write-Host "Bootstrap complete."