# bootstrap.ps1 — run as Administrator
# Configs managed by this script:
#   - glazewm/config.yaml    -> %USERPROFILE%\.glzr\glazewm\config.yaml
#   - zebar/                 -> %USERPROFILE%\.glzr\zebar
#   - starship/starship.toml -> %USERPROFILE%\.config\starship.toml
# If you add a new config here, add it to bootstrap.sh too.

$DOTFILES = "$env:USERPROFILE\dotfiles"

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

# --- Install Chocolatey if not present ---
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Chocolatey..."
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
  Write-Host "Chocolatey already installed, skipping."
}

# --- Install Starship if not present ---
if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Starship..."
  choco install starship -y
} else {
  Write-Host "Starship already installed, skipping."
}

# --- Winget: restore apps ---
$wingetFile = "$DOTFILES\winget\apps.json"
if (Test-Path $wingetFile) {
  Write-Host "Restoring apps via winget..."
  winget import -i $wingetFile --accept-package-agreements --accept-source-agreements
} else {
  Write-Host "No winget ap