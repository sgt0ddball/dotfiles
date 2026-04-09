# bootstrap.ps1 — run as Administrator
$DOTFILES = "$HOME\dotfiles"

$wtPath = (Get-ChildItem "$env:LOCALAPPDATA\Packages" -Filter "Microsoft.WindowsTerminal_*" | Select-Object -First 1).FullName

$links = @{
  "$env:USERPROFILE\.glzr\glazewm\config.yaml" = "$DOTFILES\glazewm\config.yaml"
  "$env:USERPROFILE\.glzr\zebar" = "$DOTFILES\zebar"
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
