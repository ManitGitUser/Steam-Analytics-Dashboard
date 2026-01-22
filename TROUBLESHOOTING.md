# Troubleshooting Checklist

## 🔍 Common Issues & Solutions

### Getting Started Issues

#### ❌ "npm: command not found"
**Solution:**
- Install Node.js from https://nodejs.org
- Restart your terminal/PowerShell after installation
- Verify: `node -v` and `npm -v`

#### ❌ "Cannot find module 'express'"
**Solution:**
```bash
cd server
npm install
```

#### ❌ "Port 5000 already in use"
**Solution:**
- Kill the process using port 5000
- Or change PORT in `server/.env` to 5001

#### ❌ ".env file not found"
**Solution:**
```bash
cd server
cp .env.example .env
# Edit .env and add your STEAM_API_KEY
```

---

### OAuth Issues

#### ❌ "OAuth button does nothing" or "Blank page after clicking"
**Check List:**
- [ ] Backend running on http://localhost:5000
- [ ] No console errors (open DevTools: F12)
- [ ] Check backend console for errors
- [ ] Try opening http://localhost:5000/api/health in browser
- [ ] If 404, backend not running

**Solution:**
```bash
# Terminal
cd server
npm start

# Wait 2-3 seconds for server to start
# Then try OAuth again
```

#### ❌ "Redirected back to login after OAuth"
**Check List:**
- [ ] STEAM_API_KEY set in `server/.env`?
- [ ] STEAM_API_KEY is valid (from https://steamcommunity.com/dev/apikey)?
- [ ] Check server console for specific error
- [ ] Try Demo Mode to verify UI works

**Solution:**
1. Verify API key: https://steamcommunity.com/dev/apikey
2. Add correct key to `server/.env`:
   ```
   STEAM_API_KEY=your_actual_key_here
   ```
3. Save and restart backend server

#### ❌ "CORS error in console"
**Error message:**
```
Access to XMLHttpRequest blocked by CORS policy
```

**Solution:**
- Check that backend is running on localhost:5000
- Check that `FRONTEND_URL` in `server/.env` is correct:
  ```
  FRONTEND_URL=http://localhost:5173
  ```
- Restart backend after .env changes

#### ❌ "Session not persisting" or "User disappears on refresh"
**Check List:**
- [ ] Browser cookies enabled?
- [ ] Using http://localhost:5173 (not 127.0.0.1)?
- [ ] Backend running?
- [ ] Check browser DevTools → Application → Cookies

**Solution:**
1. Enable cookies in browser settings
2. Make sure using correct localhost URL
3. Try logging in again

---

### Steam API Issues

#### ❌ "Cannot fetch games" or "No games found"
**Possible Causes:**
1. Steam profile is private
2. Invalid API key
3. Account has no games

**Solutions:**

**Option 1: Make profile public**
1. Go to https://steamcommunity.com/my/edit/profile
2. Set "Game Details" to "Public"
3. Try again

**Option 2: Verify API key**
1. Check https://steamcommunity.com/dev/apikey
2. Verify key matches `server/.env`
3. Try accessing: https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=YOUR_KEY&steamids=your_steam_id

**Option 3: Use Demo Mode**
1. Click "Launch Demo" to test UI

#### ❌ "Error 429 - Rate Limited"
**Cause:** Too many API requests

**Solution:**
- Wait a few minutes before making more requests
- The backend will retry automatically

#### ❌ "Invalid Steam ID"
**Solution:**
1. Get your 64-bit Steam ID from: https://steamcommunity.com/my/profile
2. URL format: `/profiles/76561198XXXXXXXXX`
3. Use the number at the end

---

### Frontend Issues

#### ❌ "Vite dev server won't start"
**Solution:**
```bash
npm install
npm run dev
```

#### ❌ "Page is blank or shows errors"
**Solution:**
1. Open browser DevTools (F12)
2. Check Console tab for errors
3. Check Network tab for failed requests
4. Check that backend is running

#### ❌ "Can't see user info in header after OAuth"
**Check List:**
- [ ] Did you see the login page on Steam?
- [ ] Did you authorize the app?
- [ ] Check browser console for errors
- [ ] Check server console for errors

**Solution:**
```bash
# Check server logs
cd server && npm start

# Check frontend logs in browser DevTools
# Try logout and login again
```

---

### Backend Issues

#### ❌ "Server crashes on startup"
**Check:**
- [ ] Port 5000 not in use
- [ ] Node.js installed correctly
- [ ] All dependencies installed: `npm install`
- [ ] .env file exists

**Solution:**
```bash
cd server
npm install
# Check for specific error message in terminal
cat .env  # Verify .env exists
npm start
```

#### ❌ "Backend can't connect to Steam API"
**Solutions:**
1. Check internet connection
2. Verify API key is valid
3. Check Steam API status: https://developer.valvesoftware.com/wiki/Steam_Web_API
4. Try accessing: `https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=your_key`

#### ❌ "Session data lost on server restart"
**Normal behavior!** In-memory sessions are cleared.

**Fix:** Add MongoDB or Redis for production (see SETUP_OAUTH.md)

---

### Windows-Specific Issues

#### ❌ "PowerShell execution policy error"
**Error:**
```
cannot be loaded because running scripts is disabled
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### ❌ start.ps1 or setup.ps1 don't work
**Solution:**
```bash
# Use command line directly
cd server
npm install
npm start

# In another terminal
npm install
npm run dev
```

#### ❌ "Command not found" errors
**Solution:**
- Use full paths or ensure npm is in PATH
- Restart PowerShell/CMD after Node.js installation

---

### Configuration Issues

#### ❌ "Cannot read properties of undefined (reading 'STEAM_API_KEY')"
**Solution:**
- Ensure .env file exists: `cd server && ls -la .env`
- Ensure STEAM_API_KEY is set in .env
- Restart backend server

#### ❌ "Env variables not updating"
**Solution:**
```bash
# Changes to .env require server restart
cd server
npm start  # Restart to reload .env
```

---

### Demo Mode

#### ✅ Demo Mode not working
**Note:** Demo Mode should always work! If it doesn't:

1. Open browser DevTools (F12)
2. Check Console for errors
3. Try refreshing page
4. Report issue with error message

---

## 📋 Diagnostic Steps

### Step 1: Check Node & npm
```bash
node -v      # Should be v14+
npm -v       # Should be v6+
```

### Step 2: Check Backend
```bash
# Terminal 1
cd server
npm install
npm start

# You should see:
# 🎮 Game Dashboard Server running on http://localhost:5000

# Terminal 2
curl http://localhost:5000/api/health
# Should return: {"status":"ok"}
```

### Step 3: Check Frontend
```bash
# Terminal 3
npm install
npm run dev

# You should see:
# ➜ Local: http://localhost:5173/
```

### Step 4: Check Browser
1. Open http://localhost:5173
2. Open DevTools (F12)
3. Check Console tab for errors
4. Check Network tab for failed requests
5. Try each login method (OAuth, Manual, Demo)

### Step 5: Check .env
```bash
cd server
cat .env  # Or open in editor

# Should contain:
# STEAM_API_KEY=your_actual_key
# STEAM_RETURN_URL=http://localhost:5000/auth/steam/return
# etc.
```

---

## 🐛 How to Report Issues

Include this information:

1. **What you were trying to do:**
   - "Clicked login with Steam OAuth"

2. **What happened:**
   - "Got blank page"

3. **Error messages:**
   - Check browser console (F12)
   - Check terminal output
   - Copy exact error message

4. **What you've tried:**
   - "Restarted server"
   - "Checked API key"

5. **Environment:**
   - Windows/Mac/Linux
   - Node.js version
   - npm version

---

## 🔗 Useful Links

- **Get Steam API Key:** https://steamcommunity.com/dev/apikey
- **Steam Profile Edit:** https://steamcommunity.com/my/edit/profile
- **Find Your Steam ID:** https://steamcommunity.com/my/profile
- **Steam API Status:** https://developer.valvesoftware.com/wiki/Steam_Web_API
- **Node.js Download:** https://nodejs.org
- **Passport.js Docs:** http://www.passportjs.org/

---

## ✨ Success Checklist

Once everything works:

- ✅ Backend running on http://localhost:5000
- ✅ Frontend running on http://localhost:5173
- ✅ OAuth login redirects to Steam
- ✅ Can authorize app on Steam
- ✅ Redirects back to dashboard
- ✅ User info shows in header
- ✅ Game library loads
- ✅ Analytics display correctly
- ✅ Manual login works (if API key provided)
- ✅ Demo mode displays sample data

**If all ✅, you're good to go! 🎉**

---

**Last Updated:** November 2025
**Author:** Vide Coder - Manit Saxena
