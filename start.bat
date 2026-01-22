@echo off
REM Start both frontend and backend servers for the Game Dashboard

echo.
echo ========================================
echo Steam Game Analytics Dashboard Starter
echo ========================================
echo.

REM Check if node_modules exist in server folder
if not exist "server\node_modules" (
    echo [*] Installing backend dependencies...
    cd server
    call npm install
    cd ..
    echo [✓] Backend dependencies installed
    echo.
)

REM Check if node_modules exist in root folder
if not exist "node_modules" (
    echo [*] Installing frontend dependencies...
    call npm install
    echo [✓] Frontend dependencies installed
    echo.
)

REM Check if .env exists in server
if not exist "server\.env" (
    echo [!] Warning: server\.env file not found!
    echo [!] Creating from .env.example...
    copy "server\.env.example" "server\.env"
    echo [!] IMPORTANT: Update server\.env with your STEAM_API_KEY
    echo.
)

echo [*] Starting Game Dashboard...
echo.
echo Backend will run on:  http://localhost:5000
echo Frontend will run on: http://localhost:5173
echo.
echo Starting servers in 2 seconds...
timeout /t 2 /nobreak

REM Start backend in new window
start "Game Dashboard - Backend" cmd /k "cd server && npm start"

REM Wait a moment for backend to start
timeout /t 3 /nobreak

REM Start frontend in new window
start "Game Dashboard - Frontend" cmd /k "npm run dev"

echo.
echo [✓] Both servers started!
echo [*] Opening http://localhost:5173 in your browser...
timeout /t 2 /nobreak

REM Try to open in browser (Windows)
start http://localhost:5173

echo.
echo ========================================
echo Servers are running!
echo Close either window to stop the servers.
echo ========================================
