# Steam Game Analytics Dashboard - Setup Guide

## Overview

This project now includes Steam OAuth2 authentication for secure login. You can authenticate either via:
1. **Steam OAuth** (Recommended) - Secure, no API key storage needed
2. **Manual Login** - Using Steam ID + API Key
3. **Demo Mode** - Try without logging in

## Prerequisites

- Node.js (v14+)
- npm or yarn
- Steam Account
- Steam API Key (from https://steamcommunity.com/dev/apikey)

## Setup Instructions

### 1. Backend Setup

Navigate to the server directory:

```bash
cd server
```

Install dependencies:

```bash
npm install
```

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Update `.env` with your configuration:

```env
STEAM_API_KEY=your_steam_api_key_here
STEAM_RETURN_URL=http://localhost:5000/auth/steam/return
SESSION_SECRET=your_super_secret_session_key_change_this_in_production
NODE_ENV=development
PORT=5000
FRONTEND_URL=http://localhost:5173
```

#### Getting Your Steam API Key:

1. Visit https://steamcommunity.com/dev/apikey
2. Log in with your Steam account
3. Agree to the terms
4. Copy your API Key
5. Paste it in the `.env` file as `STEAM_API_KEY`

Start the backend server:

```bash
npm start
```

Or for development with auto-reload:

```bash
npm run dev
```

The server should now be running on `http://localhost:5000`

### 2. Frontend Setup

In a new terminal, navigate to the frontend directory:

```bash
cd game-dashboard
```

Install dependencies (if not already installed):

```bash
npm install
```

Start the development server:

```bash
npm run dev
```

The frontend should now be running on `http://localhost:5173`

### 3. Testing the OAuth Flow

1. Open `http://localhost:5173` in your browser
2. Click "🔐 Login with Steam OAuth"
3. You'll be redirected to Steam's authentication page
4. Log in with your Steam account
5. Authorize the application
6. You'll be redirected back to the dashboard with your game data

## Architecture

### Backend (Express.js)

**File:** `server/server.js`

Key endpoints:

- `GET /auth/steam` - Initiates OAuth flow
- `GET /auth/steam/return` - OAuth callback (redirects to frontend)
- `GET /api/auth/user` - Returns authenticated user info
- `POST /api/auth/logout` - Logs out user
- `GET /api/steam/games` - Fetches user's Steam games
- `GET /api/steam/profile` - Fetches user's Steam profile

### Frontend (React + Vite)

**Files:**
- `src/App.jsx` - Main app component with OAuth session management
- `src/SteamLogin.jsx` - Login component with OAuth, manual login, and demo mode

### Authentication Flow

```
User clicks "Login with Steam OAuth"
         ↓
Redirects to: http://localhost:5000/auth/steam
         ↓
Backend initiates Passport Steam Strategy
         ↓
User logs in on Steam's website
         ↓
Steam redirects back to: http://localhost:5000/auth/steam/return
         ↓
Backend validates Steam identity
         ↓
Session created and user serialized
         ↓
Redirects to: http://localhost:5173?auth=success
         ↓
Frontend detects auth=success and fetches user profile
         ↓
Dashboard loads with user's Steam data
```

## Features

### 1. OAuth Login (Recommended)
- ✅ Secure Steam authentication
- ✅ No API key storage needed
- ✅ Session-based authentication
- ✅ User profile displayed in header

### 2. Manual Login
- ✅ Use Steam ID + API Key
- ✅ Useful for testing without OAuth setup
- ✅ Data stored locally

### 3. Demo Mode
- ✅ No login required
- ✅ View sample data
- ✅ Perfect for testing UI

## Troubleshooting

### Backend not connecting to frontend

Make sure `FRONTEND_URL` in `.env` matches your frontend URL (default: `http://localhost:5173`)

### CORS errors

Check that the backend has the correct `FRONTEND_URL` configured in `.env`

### Steam API errors

- Verify your `STEAM_API_KEY` is correct
- Check https://developer.valvesoftware.com/wiki/Steam_Web_API to see API status
- Ensure your Steam profile is public for some API calls to work

### Session not persisting

Make sure `credentials: "include"` is set in fetch requests (already done in the code)

### Private profile issues

If your Steam profile is private:
1. Make it public temporarily for testing
2. Or use Demo Mode to see how the app works

## Security Notes

⚠️ **Important for Production:**

1. Set `SESSION_SECRET` to a strong, random string
2. Enable `secure: true` in session cookie settings (requires HTTPS)
3. Use environment variables for sensitive data
4. Never commit `.env` to version control
5. Validate all user inputs on the backend

## API Endpoints Reference

### Authentication

```
GET /auth/steam
  Initiates Steam OAuth flow

GET /auth/steam/return
  OAuth callback endpoint (handled by Passport)

GET /api/auth/user
  Returns: { authenticated: boolean, user: {...} }
  
POST /api/auth/logout
  Returns: { success: boolean }
```

### Steam Data

```
GET /api/steam/games
  Requires: Authentication
  Returns: { response: { games: [...] } }

GET /api/steam/profile
  Requires: Authentication
  Returns: { response: { players: [...] } }
```

## File Structure

```
game-dashboard/
├── server/
│   ├── server.js           # Express server with OAuth setup
│   ├── package.json        # Backend dependencies
│   ├── .env.example        # Example environment variables
│   └── .gitignore
│
├── src/
│   ├── App.jsx             # Main app (updated with OAuth)
│   ├── SteamLogin.jsx      # Login component (updated)
│   ├── PlayerProfile.jsx
│   ├── RecentGames.jsx
│   ├── GameAnalytics.jsx
│   ├── AdvancedAnalytics.jsx
│   └── QuickStats.jsx
│
├── package.json            # Frontend dependencies
├── vite.config.js
└── index.html
```

## Next Steps

1. Deploy to production with proper HTTPS
2. Add database to store user sessions
3. Add more OAuth providers (Google, Discord, etc.)
4. Implement user preferences/settings
5. Add real-time game notifications
6. Cache Steam API data to reduce API calls

## Support

For issues or questions:
- Check Steam API documentation: https://developer.valvesoftware.com/wiki/Steam_Web_API
- Passport.js docs: http://www.passportjs.org/
- Express.js docs: https://expressjs.com/

---

**Made by Vide Coder - Manit Saxena**
