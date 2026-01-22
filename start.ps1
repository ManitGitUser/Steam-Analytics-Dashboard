#!/usr/bin/env pwsh
# Start both frontend and backend servers for the Game Dashboard

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Steam Game Analytics Dashboard Starter" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if node_modules exist in server folder
if (-not (Test-Path "server/node_modules")) {
    Write-Host "[*] Installing backend dependencies..." -ForegroundColor Yellow
    Push-Location server
    npm install
    Pop-Location
    Write-Host "[✓] Backend dependencies installed" -ForegroundColor Green
    Write-Host ""
}

# Check if node_modules exist in root folder
if (-not (Test-Path "node_modules")) {
    Write-Host "[*] Installing frontend dependencies..." -ForegroundColor Yellow
    npm install
    Write-Host "[✓] Frontend dependencies installed" -ForegroundColor Green
    Write-Host ""
}

# Check if .env exists in server
if (-not (Test-Path "server\.env")) {
    Write-Host "[!] Warning: server\.env file not found!" -ForegroundColor Red
    Write-Host "[!] Creating from .env.example..." -ForegroundColor Yellow
    Copy-Item "server\.env.example" "server\.env"
    Write-Host "[!] IMPORTANT: Update server\.env with your STEAM_API_KEY" -ForegroundColor Red
    Write-Host ""
}

Write-Host "[*] Starting Game Dashboard..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Backend will run on:  http://localhost:5000" -ForegroundColor Cyan
Write-Host "Frontend will run on: http://localhost:5173" -ForegroundColor Cyan
Write-Host ""
Write-Host "Starting servers in 2 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

# Start backend in new PowerShell window
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "cd '$PWD\server'; npm start" -WindowStyle Normal -PassThru

# Wait for backend to start
Start-Sleep -Seconds 3

# Start frontend in new PowerShell window
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "cd '$PWD'; npm run dev" -WindowStyle Normal -PassThru

Write-Host ""
Write-Host "[✓] Both servers started!" -ForegroundColor Green
Write-Host "[*] Opening http://localhost:5173 in your browser..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

# Try to open in browser
Start-Process "http://localhost:5173"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Servers are running!" -ForegroundColor Green
Write-Host "Close either window to stop the servers." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
