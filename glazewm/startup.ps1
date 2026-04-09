# Give GlazeWM time to fully initialize
Start-Sleep -Seconds 2

# Workspace 1: Chrome
Start-Process "chrome"
Start-Sleep -Milliseconds 500

# Workspace 2: File Explorer
Start-Process "explorer"
Start-Sleep -Milliseconds 500

# Workspace 4: Terminal & VS Code
Start-Process "wt"
Start-Sleep -Milliseconds 500
Start-Process "code"
Start-Sleep -Milliseconds 500

# Workspace 5 & 6: Outlook
Start-Process "outlook"
Start-Sleep -Milliseconds 500

# Workspace 8: Teams & Signal
Start-Process "ms-teams"
Start-Sleep -Milliseconds 500
Start-Process "signal"
Start-Sleep -Milliseconds 500

# Workspace 9: Obsidian & Todoist
Start-Process "obsidian"
Start-Sleep -Milliseconds 500
Start-Process "todoist"