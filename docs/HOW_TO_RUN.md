# 🚀 How to Run Steam Analytics Dashboard

Complete guide to running the application locally on your machine.

---

## 📋 Prerequisites

Before running, ensure you have installed:

### 1. Java 17+ ☕
```bash
# Check Java version
java -version

# Output should show: Java 17 or higher
# If not installed: https://www.oracle.com/java/technologies/downloads/
```

### 2. Maven 3.8+ 📦
```bash
# Check Maven version
mvn -version

# Output should show: Maven 3.8 or higher
# If not installed: https://maven.apache.org/download.cgi
```

### 3. Node.js 18+ & npm 9+
```bash
# Check Node version
node --version

# Check npm version
npm --version

# If not installed: https://nodejs.org/
```

### 4. Git
```bash
# Check Git version
git --version

# If not installed: https://git-scm.com/
```

### 5. Steam API Key 🎮
1. Go to: https://steamcommunity.com/dev/apikey
2. Login with your Steam account
3. Copy your API key
4. Keep it safe!

---

## 📁 Project Structure Reminder

```
game-dashboard/
├── backend/               ← Java Spring Boot (Port 5000)
│   ├── pom.xml
│   ├── .env.example
│   └── src/...
├── src/                   ← React Frontend (Port 5173)
├── package.json
└── [documentation files]
```

---

## ⚡ Quick Start (5 Minutes)

### Terminal 1: Start Backend
```bash
cd "d:\Code\Full Stack\FS_Project\game-dashboard\backend"

# Copy environment file
copy .env.example .env

# Edit .env and add STEAM_API_KEY
# On Windows: notepad .env
# On Linux/Mac: nano .env

# Build and run backend
mvn clean install
mvn spring-boot:run
```

**Expected Output:**
```
Started GameDashboardApplication in 2.5 seconds
Server running on http://localhost:5000
```

### Terminal 2: Start Frontend
```bash
# Navigate to project root (not backend)
cd "d:\Code\Full Stack\FS_Project\game-dashboard"

# Install dependencies (first time only)
npm install

# Start development server
npm run dev
```

**Expected Output:**
```
VITE v7.x.x  ready in 500 ms
Local:  http://localhost:5173/
```

### Terminal 3 (Browser): Open Application
```
Navigate to: http://localhost:5173
```

✅ **You're running!**

---

## 🎯 Step-by-Step Guide

### STEP 1: Navigate to Project

**Windows PowerShell:**
```powershell
cd "d:\Code\Full Stack\FS_Project\game-dashboard"
```

**Windows CMD:**
```cmd
cd "d:\Code\Full Stack\FS_Project\game-dashboard"
```

**Linux/Mac:**
```bash
cd ~/Code/Full\ Stack/FS_Project/game-dashboard
```

### STEP 2: Configure Backend

```bash
# Navigate to backend
cd backend

# Copy environment template
cp .env.example .env

# Edit .env file with your editor
# Add your Steam API Key:
# STEAM_API_KEY=your_actual_key_here

# Windows Notepad:
notepad .env

# Linux/Mac Nano:
nano .env
```

### STEP 3: Build Backend

```bash
# From backend directory
mvn clean install

# This will:
# ✅ Download all Maven dependencies
# ✅ Compile Java source code
# ✅ Create JAR files
# ✅ Run any tests

# Wait for "BUILD SUCCESS" message
# Time: ~1-2 minutes first time
```

### STEP 4: Run Backend

**Option A: Using Maven** (Recommended)
```bash
# From backend directory
mvn spring-boot:run

# Output:
# Started GameDashboardApplication in 2.5 seconds (JVM running for 3.2)
# Server running on http://localhost:5000
```

**Option B: Using JAR File**
```bash
# From backend directory
java -jar target/game-dashboard.jar

# Similar output as above
```

### STEP 5: Install Frontend Dependencies

**Open NEW Terminal (keep backend running)**

```bash
# Navigate to project root (NOT backend)
cd "d:\Code\Full Stack\FS_Project\game-dashboard"

# Install npm packages
npm install

# This installs: React, Vite, ESLint, etc.
# Time: ~1 minute
# Creates: node_modules/ directory
```

### STEP 6: Start Frontend

**From same terminal:**

```bash
# Start Vite development server
npm run dev

# Output:
#   VITE v7.x.x  ready in XXX ms
#   Local:   http://localhost:5173/
#   press h to show help
```

### STEP 7: Open in Browser

```
1. Open web browser (Chrome, Firefox, Edge, Safari)
2. Go to: http://localhost:5173
3. Click "Login with Steam"
4. Authorize on Steam
5. See your game library!
```

---

## 📊 Full Terminal Setup (Copy-Paste Ready)

### Terminal 1: Backend
```bash
# Windows
cd "d:\Code\Full Stack\FS_Project\game-dashboard\backend"
copy .env.example .env
notepad .env
mvn clean install
mvn spring-boot:run

# Linux/Mac
cd ~/Code/Full\ Stack/FS_Project/game-dashboard/backend
cp .env.example .env
nano .env
mvn clean install
mvn spring-boot:run
```

### Terminal 2: Frontend
```bash
# Windows
cd "d:\Code\Full Stack\FS_Project\game-dashboard"
npm install
npm run dev

# Linux/Mac
cd ~/Code/Full\ Stack/FS_Project/game-dashboard
npm install
npm run dev
```

### Then Open Browser:
```
http://localhost:5173
```

---

## ✅ Verification Checklist

### Backend Running?
```bash
# Check if backend is running
curl http://localhost:5000/api/health

# Should respond:
# {"status":"ok"}
```

### Frontend Running?
```
1. Open browser
2. Go to http://localhost:5173
3. Should see "Login with Steam" button
```

### Both Connected?
```
1. Click "Login with Steam"
2. Should redirect to Steam login page
3. After login, should see your games
4. If CORS error, check backend is running
```

---

## 🐛 Troubleshooting

### ❌ "mvn not found"
```bash
# Verify Maven installed
mvn -version

# If not found, reinstall:
# Download: https://maven.apache.org/download.cgi
# Add to PATH environment variable
```

### ❌ "Java version error"
```bash
# Check Java version
java -version

# Must be Java 17+
# Download: https://www.oracle.com/java/technologies/downloads/
```

### ❌ "Port 5000 already in use"
```bash
# Windows - find what's using port 5000
netstat -ano | findstr :5000

# Windows - kill the process
taskkill /PID <PID> /F

# Linux/Mac - find process
lsof -i :5000

# Linux/Mac - kill process
kill -9 <PID>

# Or change port in: backend/src/main/resources/application.yml
# Change: server.port: 5000 to server.port: 5001
```

### ❌ "Port 5173 already in use"
```bash
# Change frontend port in vite.config.js
# Or kill the process using port 5173
```

### ❌ "npm not found"
```bash
# Install Node.js: https://nodejs.org/
# Then retry: npm install
```

### ❌ "CORS error in browser"
```
1. Verify backend is running on port 5000
2. Check .env has STEAM_API_KEY set
3. Check frontend URL in application.yml is http://localhost:5173
4. Restart both servers
```

### ❌ "OAuth login fails"
```
1. Verify STEAM_API_KEY in backend/.env is correct
2. Ensure Steam profile is PUBLIC
3. Check steam.api-key in application.yml matches .env
4. Check browser console for detailed error
```

### ❌ "Games not loading"
```
1. Check Steam profile is public
2. Ensure profile has games in library
3. Check browser console for errors
4. Check backend logs for API errors
```

---

## 🎮 Test the Application

### Demo Mode (No Login)
```
1. Look for "Try Demo" button
2. Click to see sample data
3. Explore dashboard without Steam account
```

### Login with Steam
```
1. Click "Login with Steam"
2. You'll be redirected to Steam login
3. Login with your Steam account
4. Authorize the application
5. See your actual game library
```

### View Features
```
✅ Player Profile - Your Steam profile info
✅ Game Library - All your owned games
✅ Game Statistics - Playtime breakdown
✅ Advanced Analytics - Detailed insights
✅ Recent Games - Last played games
✅ Quick Stats - Playtime summary
```

---

## 📝 Available Commands

### Backend Commands
```bash
cd backend

# Clean build (remove old files)
mvn clean

# Build project
mvn install

# Run application
mvn spring-boot:run

# Run tests
mvn test

# Create production JAR
mvn clean package -DskipTests

# Run production JAR
java -jar target/game-dashboard.jar
```

### Frontend Commands
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Run linter
npm run lint
```

---

## 🚀 Production Build

### Build Backend for Production
```bash
cd backend
mvn clean package -DskipTests
# Creates: target/game-dashboard.jar
java -jar target/game-dashboard.jar
```

### Build Frontend for Production
```bash
npm run build
# Creates: dist/ directory with optimized files
```

---

## 🔄 Workflow During Development

### Continuous Development Loop:

```bash
# Terminal 1: Keep backend running
cd backend
mvn spring-boot:run
# Backend automatically recompiles on file changes

# Terminal 2: Keep frontend running
npm run dev
# Frontend has hot reload - changes appear instantly

# Terminal 3: Make code changes
# Edit files in IDE/Editor
# Changes auto-reflect in browser
```

---

## 📊 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **Java** | 17 | 21 |
| **Maven** | 3.8 | 3.9+ |
| **Node.js** | 18 | 20 |
| **RAM** | 2GB | 4GB+ |
| **Disk Space** | 500MB | 2GB+ |
| **OS** | Windows/Mac/Linux | Any |

---

## ⏱️ Startup Times

| Component | Time |
|-----------|------|
| Maven build | 30-60s (first time) |
| Backend startup | 2-3 seconds |
| Frontend startup | 1-2 seconds |
| **Total first run** | ~2 minutes |
| **Total subsequent runs** | ~10 seconds |

---

## 💾 Files You'll Need

### Configuration
```
backend/.env.example  → Copy to backend/.env
                      → Add STEAM_API_KEY
```

### No Manual Setup Needed
```
✅ application.yml    - Automatically configured
✅ package.json       - Automatically configured
✅ vite.config.js     - Automatically configured
```

---

## 🎯 What If Something Goes Wrong?

### Check These First:
1. ✅ Java installed and version 17+? (`java -version`)
2. ✅ Maven installed? (`mvn -version`)
3. ✅ Node.js installed? (`node --version`)
4. ✅ .env file created with STEAM_API_KEY? (Check `backend/.env`)
5. ✅ Both servers running? (Check terminal output)
6. ✅ Correct URLs? (Backend: 5000, Frontend: 5173)

### Review Documentation:
- **Quick help:** `QUICK_GITHUB_PUSH.md`
- **Detailed backend:** `JAVA_BACKEND_SETUP.md`
- **Common issues:** `TROUBLESHOOTING.md`
- **Getting started:** `START_HERE.md`

---

## 📞 Quick Reference

### Check If Running:

```bash
# Backend health check
curl http://localhost:5000/api/health

# Frontend check
# Open browser to http://localhost:5173
# Should see login page
```

### Restart Services:

```bash
# Kill all Java processes (be careful!)
# Windows: taskkill /F /IM java.exe
# Linux/Mac: killall java

# Then restart backend: mvn spring-boot:run
```

### Clear Cache:

```bash
# Backend
cd backend
mvn clean

# Frontend
del node_modules
npm install
```

---

## ✨ Tips & Tricks

### Faster Builds
```bash
# Skip tests during build
mvn clean package -DskipTests
```

### Debug Mode
```bash
# Run backend in debug
mvn spring-boot:run -Dspring-boot.run.arguments="--debug"
```

### Change Ports
```bash
# Frontend port in vite.config.js
# Add: server: { port: 3000 }

# Backend port in backend/src/main/resources/application.yml
# Change: server.port: 5000 to 5001
```

### Access from Other Machines
```
# Change localhost to your IP in vite.config.js
# Change proxy URL to http://your-ip:5000
```

---

## 🎉 You're All Set!

You now know how to:
- ✅ Install prerequisites
- ✅ Configure backend
- ✅ Start backend server
- ✅ Install frontend
- ✅ Start frontend server
- ✅ Access in browser
- ✅ Test the application
- ✅ Troubleshoot issues

---

## 🚀 Next Steps

1. **Run the application** using steps above
2. **Test login** with your Steam account
3. **View your games** and statistics
4. **Push to GitHub** using `GITHUB_PUSH_GUIDE.md`
5. **Deploy** to cloud (optional)

---

**Status:** ✅ Ready to Run  
**Last Updated:** January 2026  
**Questions?** Check `TROUBLESHOOTING.md`

Made with ❤️ for easy setup and running!
