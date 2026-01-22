#!/usr/bin/env pwsh
# Setup environment for Steam Game Dashboard

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Steam Game Analytics Dashboard - Environment Setup   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check Node.js
Write-Host "[*] Checking Node.js..." -ForegroundColor Yellow
$nodeVersion = node -v
if ($nodeVersion) {
    Write-Host "[✓] Node.js $nodeVersion installed" -ForegroundColor Green
} else {
    Write-Host "[✗] Node.js not found! Install from https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Install backend dependencies
Write-Host "[*] Installing backend dependencies..." -ForegroundColor Yellow
Push-Location server
npm install
if ($?) {
    Write-Host "[✓] Backend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "[✗] Backend installation failed" -ForegroundColor Red
    Pop-Location
    exit 1
}
Pop-Location

# Install frontend dependencies
Write-Host "[*] Installing frontend dependencies..." -ForegroundColor Yellow
npm install
if ($?) {
    Write-Host "[✓] Frontend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "[✗] Frontend installation failed" -ForegroundColor Red
    exit 1
}

# Create .env file if it doesn't exist
if (-not (Test-Path "server\.env")) {
    Write-Host "[*] Creating server/.env file..." -ForegroundColor Yellow
    Copy-Item "server\.env.example" "server\.env"
    Write-Host "[✓] server/.env created from example" -ForegroundColor Green
} else {
    Write-Host "[*] server/.env already exists" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              Setup Complete!                           ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Get your Steam API Key:" -ForegroundColor White
Write-Host "   https://steamcommunity.com/dev/apikey" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Add your API Key to server/.env:" -ForegroundColor White
Write-Host "   Set STEAM_API_KEY=your_key_here" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Start the servers:" -ForegroundColor White
Write-Host "   Run: .\start.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "4. Open your browser:" -ForegroundColor White
Write-Host "   http://localhost:5173" -ForegroundColor Yellow
Write-Host ""

Write-Host "✨ Environment setup is complete! Run '.\start.ps1' to begin." -ForegroundColor Green
