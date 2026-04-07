# TCS Skill Installer for Windows
# Run with: powershell -ExecutionPolicy Bypass -File install.ps1

Write-Host "Installing TCS skill for Claude Code..." -ForegroundColor Cyan

# Define paths
$skillsDir = "$env:USERPROFILE\.claude\skills"
$skillFile = "$skillsDir\tcs.md"

# Create skills directory if it doesn't exist
if (!(Test-Path $skillsDir)) {
    Write-Host "Creating skills directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null
}

# Copy the skill file
if (Test-Path "tcs.md") {
    Write-Host "Copying tcs.md to skills directory..." -ForegroundColor Yellow
    Copy-Item "tcs.md" -Destination $skillFile -Force
    Write-Host "✓ Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Claude Code completely" -ForegroundColor White
    Write-Host "2. Type '/skills' to verify installation" -ForegroundColor White
    Write-Host "3. Use with: /tcs ""story.xml"" ""ui.png"" ""common steps""" -ForegroundColor White
} else {
    Write-Host "✗ Error: tcs.md not found in current directory" -ForegroundColor Red
    Write-Host "Please run this script from the directory containing tcs.md" -ForegroundColor Yellow
    exit 1
}
