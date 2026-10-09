# 🎮 RUN STEAM DASHBOARD - QUICK CARD

## 3 Easy Steps ⚡

### ✅ STEP 1: Setup Backend (First Terminal)

```bash
cd "d:\Code\Full Stack\FS_Project\game-dashboard\backend"
copy .env.example .env
# Edit .env with notepad, add your STEAM_API_KEY
mvn clean install
mvn spring-boot:run
```

**Expected:** `Server running on http://localhost:5000` ✅

---

### ✅ STEP 2: Setup Frontend (Second Terminal)

```bash
cd "d:\Code\Full Stack\FS_Project\game-dashboard"
npm install
npm run dev
```

**Expected:** `Local:  http://localhost:5173/` ✅

---

### ✅ STEP 3: Open Browser

```
http://localhost:5173
```

**Click "Login with Steam" and enjoy!** 🎉

---

## 📋 CHECKLIST

- [ ] Java 17+ installed? `java -version`
- [ ] Maven 3.8+ installed? `mvn -version`
- [ ] Node.js 18+ installed? `node --version`
- [ ] Steam API key obtained?
- [ ] .env file created with API key?
- [ ] Backend running on port 5000?
- [ ] Frontend running on port 5173?
- [ ] Both servers showing no errors?

---

## 🐛 COMMON ISSUES

| Problem | Solution |
|---------|----------|
| Maven not found | Install from https://maven.apache.org |
| Java version error | Install Java 17+ from oracle.com |
| Port 5000 in use | Change port in `application.yml` |
| CORS error | Verify both servers running |
| OAuth fails | Check STEAM_API_KEY in .env |
| npm not found | Install Node.js from nodejs.org |

---

## ⏱️ TIMING

| Step | Time |
|------|------|
| Backend build (first) | ~1 min |
| Backend start | ~3 sec |
| Frontend install (first) | ~1 min |
| Frontend start | ~1 sec |
| **Total first run** | ~3 min |

---

## 📞 HELP COMMANDS

```bash
# Check backend health
curl http://localhost:5000/api/health

# Check all Java processes
jps

# Kill a process on Windows
taskkill /F /PID <PID>

# Clear frontend cache
rmdir /s node_modules
npm install
```

---

## 🎯 WHAT TO EXPECT

### Backend Terminal Shows:
```
Started GameDashboardApplication in 2.5 seconds
Server running on http://localhost:5000
```

### Frontend Terminal Shows:
```
VITE v7.x.x  ready in 500 ms
Local:  http://localhost:5173/
```

### Browser Shows:
```
🔐 Login with Steam button
OR
Demo mode option
```

---

## 🚀 YOU'RE DONE!

All set to run the Steam Analytics Dashboard! 🎉

Need help? Read: **HOW_TO_RUN.md** (detailed version)
