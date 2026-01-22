# Quick Start Guide - Steam OAuth Integration

## 🚀 Fast Setup

### Step 1: Get Your Steam API Key
1. Go to https://steamcommunity.com/dev/apikey
2. Log in with your Steam account
3. Copy your API Key

### Step 2: Configure Backend

```bash
cd server
cp .env.example .env
```

Edit `server/.env` and add your Steam API Key:
```env
STEAM_API_KEY=your_key_here_12345
```

### Step 3: Start Everything

**Option A - Windows (PowerShell):**
```bash
.\start.ps1
```

**Option B - Windows (CMD):**
```bash
start.bat
```

**Option C - Manual Start:**

Terminal 1 - Backend:
```bash
cd server
npm install
npm start
```

Terminal 2 - Frontend:
```bash
npm install
npm run dev
```

Then open: http://localhost:5173

## 🔐 Login Options

### 1️⃣ Steam OAuth (Recommended)
- Click "🔐 Login with Steam OAuth"
- You'll be redirected to Steam
- Log in and authorize
- You're done! No API keys needed.

### 2️⃣ Manual Login
- Enter your Steam ID (64-bit)
- Enter your Steam API Key
- Click "Fetch My Data"

### 3️⃣ Demo Mode
- Click "Launch Demo"
- See how the app works with sample data
- No login required

## 📋 What You Get

After logging in:
- 📊 View all your Steam games
- ⏱️ See total playtime per game
- 📈 Game analytics and statistics
- 🎮 Your player profile
- 📅 Recent game activity

## 🐛 Troubleshooting

### "Cannot connect to server"
- Make sure backend is running on http://localhost:5000
- Check that `FRONTEND_URL` in `.env` is `http://localhost:5173`

### "OAuth not working"
- Verify your Steam API key is correct
- Make sure you're using the correct return URL
- Try Demo Mode first to test the UI

### "Cannot find steam games"
- Make sure your Steam profile is public
- Or use the Demo Mode to see sample data

### "Module not found"
Run:
```bash
npm install
cd server && npm install
```

## 📁 Project Structure

```
game-dashboard/
├── server/              # Express backend with OAuth
├── src/                 # React frontend
├── start.bat           # Quick start (Windows CMD)
├── start.ps1           # Quick start (PowerShell)
├── SETUP_OAUTH.md      # Detailed setup guide
└── README_QUICK.md     # This file
```

## 🔗 Useful Links

- Steam API Docs: https://developer.valvesoftware.com/wiki/Steam_Web_API
- Steam Profile Settings: https://steamcommunity.com/my/edit/profile
- Get API Key: https://steamcommunity.com/dev/apikey

## 💡 Tips

- Use Demo Mode to test without Steam account
- Check backend logs for detailed error messages
- Your session persists in the browser
- Logout clears all data

## ✅ Everything Working?

If you can see this page and log in, you're good to go! 🎉

---

**Made by Vide Coder - Manit Saxena**

Need help? Check `SETUP_OAUTH.md` for more detailed information.
