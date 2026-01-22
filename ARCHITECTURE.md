# Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      USER BROWSER                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                 REACT FRONTEND (Vite)                    │  │
│  │              (localhost:5173)                            │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │  - App.jsx (Session Management)                          │  │
│  │  - SteamLogin.jsx (OAuth / Manual / Demo)                │  │
│  │  - GameAnalytics.jsx (Stats & Charts)                    │  │
│  │  - PlayerProfile.jsx (User Info)                         │  │
│  │  - Other Components (UI)                                 │  │
│  │                                                          │  │
│  │  State: credentials, games, profile, oauthUser          │  │
│  └──────────────────────────────────────────────────────────┘  │
│           │                                       │              │
│           │ HTTP Requests                         │              │
│           │ fetch(..., {credentials: 'include'})  │              │
│           ↓                                       ↓              │
│        API Calls                              OAuth Redirect     │
└───────────┼───────────────────────────────────┼─────────────────┘
            │                                   │
            │ (CORS)                            │
            │                                   │
            ↓                                   ↓
┌───────────────────────────────────────────────────────────────────┐
│              EXPRESS.JS BACKEND SERVER                            │
│              (localhost:5000)                                     │
├───────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  MIDDLEWARE STACK:                                          │ │
│  │  • CORS (origin whitelist)                                  │ │
│  │  • JSON Parser                                              │ │
│  │  • Session Middleware (express-session)                    │ │
│  │  • Passport Initialization                                  │ │
│  │  • Passport Session Serialization                           │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  PASSPORT.JS STEAM STRATEGY:                                │ │
│  │  • Steam OpenID Endpoint                                    │ │
│  │  • User Serialization/Deserialization                       │ │
│  │  • Session Cookies (httpOnly, sameSite)                     │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  ROUTE HANDLERS:                                            │ │
│  │                                                             │ │
│  │  OAuth Routes:                                              │ │
│  │  • GET /auth/steam                                          │ │
│  │  • GET /auth/steam/return                                   │ │
│  │                                                             │ │
│  │  Auth Routes:                                               │ │
│  │  • GET /api/auth/user (check session)                       │ │
│  │  • POST /api/auth/logout (destroy session)                  │ │
│  │  • GET /api/health (health check)                           │ │
│  │                                                             │ │
│  │  Steam Proxy Routes (requires auth):                        │ │
│  │  • GET /api/steam/games (fetch owned games)                 │ │
│  │  • GET /api/steam/profile (fetch player profile)            │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  SESSION STORE:                                             │ │
│  │  • In-memory (development)                                  │ │
│  │  • Recommended: MongoDB, Redis (production)                 │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
└───────────┬───────────────────────────────────────────┬───────────┘
            │                                           │
            │ HTTP Requests with API Key                │
            │ (Proxied to avoid CORS)                   │ OAuth
            │                                           │ Redirect
            ↓                                           ↓
┌─────────────────────────────────────────┐   ┌──────────────────┐
│    STEAM WEB API SERVERS                │   │  STEAM OpenID    │
│                                         │   │  & Login         │
│  https://api.steampowered.com/          │   │                  │
│                                         │   │  Steam's Auth    │
│  • IPlayerService (games, profile)     │   │  Servers         │
│  • ISteamUser (player summaries)        │   │                  │
│  • ISteamApps (game details)            │   └──────────────────┘
│                                         │
│  Endpoints Used:                        │
│  • /IPlayerService/GetOwnedGames        │
│  • /ISteamUser/GetPlayerSummaries       │
└─────────────────────────────────────────┘
```

## Data Flow

### OAuth Login Flow

```
1. User clicks "Login with Steam OAuth"
                    ↓
2. Redirects to http://localhost:5000/auth/steam
                    ↓
3. Passport Steam Strategy activates
                    ↓
4. User redirected to Steam's login page
                    ↓
5. User logs in with Steam credentials
                    ↓
6. User authorizes app
                    ↓
7. Steam redirects to: http://localhost:5000/auth/steam/return
                    ↓
8. Passport validates Steam response
                    ↓
9. User object extracted and serialized
                    ↓
10. Session cookie created (httpOnly, secure)
                    ↓
11. Server redirects to: http://localhost:5173?auth=success
                    ↓
12. Frontend detects auth=success
                    ↓
13. Frontend calls GET /api/auth/user (with session cookie)
                    ↓
14. Backend retrieves session and returns user data
                    ↓
15. Frontend sets oauthUser state
                    ↓
16. Dashboard renders with user's Steam data
```

### Game Data Fetch Flow

```
User clicks "Fetch My Data" (manual) or page loads with OAuth
                    ↓
Frontend sends: GET /api/steam/games
  (with credentials: include)
                    ↓
Browser automatically includes session cookie
                    ↓
Backend receives request
  • Checks if req.isAuthenticated() = true
  • Extracts steamId from session
                    ↓
Backend constructs Steam API URL:
  https://api.steampowered.com/IPlayerService/GetOwnedGames/v1
    ?key=STEAM_API_KEY
    &steamid={steamId}
    &include_appinfo=true
                    ↓
Backend calls Steam API (server-to-server, no CORS)
                    ↓
Steam API returns game list
                    ↓
Backend sends response to frontend (JSON)
                    ↓
Frontend receives games array
                    ↓
Frontend renders:
  • GameAnalytics component
  • Game library view
  • Quick stats
```

## Component Hierarchy

```
App.jsx (Main)
├── Header
│   ├── Title
│   ├── User Info (if OAuth logged in)
│   └── Logout Button (if logged in)
│
├── Router / View Controller
│   ├── !credentials → SteamLogin (show login options)
│   │   ├── OAuth Button
│   │   ├── Manual Login Form
│   │   └── Demo Mode Button
│   │
│   └── credentials → Dashboard
│       ├── Tab Navigation
│       │   ├── Dashboard Tab
│       │   └── Library Tab
│       │
│       ├── Dashboard View (if activeView === 'dashboard')
│       │   ├── Left Column
│       │   │   ├── PlayerProfile (OAuth only)
│       │   │   ├── GameAnalytics
│       │   │   └── AdvancedAnalytics
│       │   │
│       │   └── Right Column (sticky)
│       │       ├── QuickStats
│       │       └── RecentGames
│       │
│       └── Library View (if activeView === 'library')
│           └── Game Grid (all owned games)
│
└── Footer
```

## State Management

### Frontend State (App.jsx)

```javascript
credentials: {
  steamId: "76561198123456789",
  apiKey: "XXXXXXXXXXXXXXXX" (if manual login)
}

oauthUser: {
  steamId: "76561198123456789",
  username: "PlayerName",
  avatar: "https://avatars.steamstatic.com/...",
  profileUrl: "https://steamcommunity.com/..."
}

games: [
  { appid, name, playtime_forever, rtime_last_played },
  ...
]

profile: {
  personaname,
  avatarfull,
  loccountrycode,
  profileurl
}

isDemoMode: boolean
loading: boolean
error: string
activeView: "dashboard" | "library"
checkingAuth: boolean
```

### Backend Session

```javascript
req.session.passport = {
  user: {
    id: "76561198123456789",        // steamId
    displayName: "PlayerName",
    photos: [{ value: "avatar_url" }],
    profileUrl: "https://...",
    identifier: "steam_openid_url"
  }
}
```

## Security Layers

```
Layer 1: CORS Protection
├─ Only allow requests from frontend domain
└─ Credentials: include enforces cookie sending

Layer 2: Session Management
├─ httpOnly cookies (can't be accessed by JS)
├─ SameSite=Lax (CSRF protection)
├─ Secure flag (HTTPS only in production)
└─ Session ID in database (not in URL)

Layer 3: Authentication Checks
├─ req.isAuthenticated() checks session
└─ API endpoints return 401 if not authenticated

Layer 4: API Key Security
├─ Stored only on backend (server/.env)
├─ Never sent to frontend
└─ Only server can make Steam API calls

Layer 5: OAuth Validation
├─ Steam validates user on Steam servers
├─ Server validates Steam response
└─ User identity confirmed before session creation
```

## Environment Configuration

```
Frontend (.env - not needed, values hardcoded)
├─ VITE_API_URL = http://localhost:5000

Backend (.env)
├─ STEAM_API_KEY = (from Steam dev portal)
├─ STEAM_RETURN_URL = (OAuth callback)
├─ SESSION_SECRET = (random string)
├─ PORT = 5000
├─ FRONTEND_URL = http://localhost:5173
└─ NODE_ENV = development | production
```

## Performance Considerations

1. **Caching**
   - Game list cached in frontend state
   - Profile data cached until logout
   - Consider Redis for backend session store

2. **API Rate Limiting**
   - Steam API has rate limits
   - Current implementation fetches on demand
   - Consider adding request throttling

3. **Session Storage**
   - In-memory storage loses data on restart
   - Use MongoDB/Redis for production

4. **Network**
   - CORS adds one extra request per API call
   - Session cookie sent with every request
   - Consider HTTP/2 for multiplexing

## Scalability

### Current Bottlenecks
- In-memory session storage (single server only)
- No database for user persistence
- All API calls synchronous

### For Production Scale
- Implement session store (MongoDB, Redis)
- Add request caching (Redis)
- Implement async job queue for Steam API calls
- Add rate limiting middleware
- Implement API versioning
- Add monitoring and logging

---

**Created: November 2025**
**Author: Vide Coder - Manit Saxena**
