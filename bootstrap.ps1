# bootstrap.ps1 — run as Administrator
$DOTFILES = "$HOME\dotfiles"

$wtPath = (Get-ChildItem "$env:LOCALAPPDATA\Packages" -Filter "Microsoft.WindowsTerminal_*" | Select-Object -First 1).FullName

$links = @{
  "$wtPath\LocalState\settings.json" = "$DOTFILES\windows\terminal\settings.json"
  "$env:USERPROFILE\.glaze-wm\config.yaml" = "$DOTFILES\windows\glazewm\config.yaml"
}

foreach ($target in $links.Keys) {
  $source = $links[$target]
  if (Test-Path $target) { Remove-Item $target }
  New-Item -ItemType SymbolicLink -Path $target -Target $source
  Write-Host "Linked $target"
}
