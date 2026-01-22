# Game Dashboard Backend API

Express.js server with Steam OAuth2 authentication for the Game Dashboard application.

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Edit .env and add your STEAM_API_KEY from https://steamcommunity.com/dev/apikey

# Start server
npm start

# Or with auto-reload in development
npm run dev
```

Server runs on: `http://localhost:5000`

## 📝 Environment Variables

```env
# Steam API Configuration
STEAM_API_KEY=your_steam_api_key_here
STEAM_RETURN_URL=http://localhost:5000/auth/steam/return

# Session Configuration
SESSION_SECRET=your_super_secret_session_key_change_this

# Server Configuration
NODE_ENV=development
PORT=5000
FRONTEND_URL=http://localhost:5173
```

## 🔐 Authentication Flow

### Steam OAuth

1. User visits frontend and clicks "Login with Steam OAuth"
2. Redirected to `GET /auth/steam`
3. Passport initiates Steam OpenID flow
4. User logs in on Steam's servers
5. Steam redirects to `GET /auth/steam/return`
6. Server validates identity and creates session
7. Redirected back to frontend with `?auth=success`
8. Frontend fetches user data from `/api/auth/user`

### Session Management

- Uses `express-session` with in-memory store (not suitable for production)
- Sessions stored in user cookie (httpOnly, sameSite)
- User serialized/deserialized by Passport

## 📡 API Endpoints

### Authentication

#### `GET /auth/steam`
Initiates Steam OAuth flow
```
No parameters
Redirects to Steam login or /auth/steam/return
```

#### `GET /auth/steam/return`
Steam OAuth callback
```
Handled by Passport
Redirects to: FRONTEND_URL?auth=success
```

#### `GET /api/auth/user`
Get current authenticated user
```
Response (authenticated):
{
  "authenticated": true,
  "user": {
    "steamId": "76561198123456789",
    "username": "PlayerName",
    "avatar": "https://avatars.steamstatic.com/...",
    "profileUrl": "https://steamcommunity.com/profiles/76561198123456789"
  }
}

Response (not authenticated):
{
  "authenticated": false
}
```

#### `POST /api/auth/logout`
Logout current user
```
Response:
{
  "success": true
}
```

### Steam Data (Requires Authentication)

#### `GET /api/steam/games`
Fetch user's owned games
```
Headers: (Authentication required)
Response: 
{
  "response": {
    "game_count": 42,
    "games": [
      {
        "appid": 730,
        "name": "Counter-Strike 2",
        "playtime_forever": 2400,
        "rtime_last_played": 1700000000
      },
      ...
    ]
  }
}
```

#### `GET /api/steam/profile`
Fetch user's profile information
```
Headers: (Authentication required)
Response:
{
  "response": {
    "players": [
      {
        "steamid": "76561198123456789",
        "personaname": "PlayerName",
        "profileurl": "https://steamcommunity.com/profiles/76561198123456789",
        "avatar": "https://avatars.steamstatic.com/...",
        "avatarmedium": "...",
        "avatarfull": "...",
        "personastate": 1,
        "loccountrycode": "US"
      }
    ]
  }
}
```

#### `GET /api/health`
Health check endpoint
```
Response: { "status": "ok" }
```

## 🏗️ Architecture

### Dependencies

- **express** - Web framework
- **express-session** - Session middleware
- **passport** - Authentication middleware
- **passport-steam** - Steam OpenID strategy
- **dotenv** - Environment configuration
- **cors** - Cross-origin resource sharing
- **node-fetch** - HTTP requests (for Steam API)

### Key Files

- `server.js` - Main application file with all routes and middleware

### Middleware Stack

```
CORS Middleware
    ↓
JSON Parser
    ↓
Session Middleware
    ↓
Passport Initialization
    ↓
Passport Session
    ↓
Route Handlers
```

## 🔒 Security Considerations

### Current Implementation

✅ httpOnly cookies (prevents XSS attacks)
✅ sameSite cookie policy (prevents CSRF)
✅ Session-based auth (no tokens exposed to client)
✅ CORS restriction to frontend domain

### Production Recommendations

⚠️ **Before deploying:**

1. Set `SESSION_SECRET` to a cryptographically secure random string
2. Enable `secure: true` in cookie settings (requires HTTPS)
3. Use a production session store (MongoDB, Redis, etc.)
4. Set `NODE_ENV=production`
5. Implement rate limiting
6. Add input validation/sanitization
7. Use environment-specific configuration
8. Enable HTTPS/TLS
9. Add request logging and monitoring
10. Implement CSRF protection if needed

## 🚨 Error Handling

All errors return JSON with status codes:

```javascript
// Authentication required
401 { "error": "Not authenticated" }

// Server error
500 { "error": "Something went wrong!" }
```

## 📊 Request/Response Examples

### Login via OAuth

```bash
# 1. Initiate login
GET http://localhost:5000/auth/steam

# 2. User logs in on Steam and is redirected back
# Server redirects to:
http://localhost:5173?auth=success

# 3. Frontend fetches user info
GET http://localhost:5000/api/auth/user
  (with credentials: include)

# Response:
{
  "authenticated": true,
  "user": {
    "steamId": "76561198123456789",
    "username": "PlayerName",
    ...
  }
}
```

### Fetch Games

```bash
GET http://localhost:5000/api/steam/games
  (with authentication)

Response:
{
  "response": {
    "game_count": 42,
    "games": [...]
  }
}
```

## 🐛 Debugging

Enable debug logging:

```javascript
// In server.js
process.env.DEBUG = 'passport,express-session';
```

Check backend logs in terminal where `npm start` is running.

## 📱 CORS Configuration

Currently allows requests from:
- `http://localhost:5173` (development)

To add more origins, update in `server.js`:

```javascript
app.use(cors({
  origin: ['http://localhost:5173', 'http://localhost:3000', 'https://yourdomain.com'],
  credentials: true
}));
```

## 🔗 External APIs Used

### Steam Web API
- Endpoint: `https://api.steampowered.com/`
- Used for: Games list, player profile, game details
- Requires: `STEAM_API_KEY`
- Docs: https://developer.valvesoftware.com/wiki/Steam_Web_API

### Steam OpenID
- Used for: OAuth authentication
- Handled by: `passport-steam` library
- No API key required for OpenID authentication

## 📦 Deployment

### Recommended Platforms

- **Heroku** - Easy deployment with environment variables
- **Vercel** - For serverless
- **AWS/Azure/GCP** - For scalable deployments
- **DigitalOcean/Linode** - For VPS deployment

### Deployment Checklist

- [ ] Set `NODE_ENV=production`
- [ ] Set secure `SESSION_SECRET`
- [ ] Update `STEAM_RETURN_URL` to production domain
- [ ] Update `FRONTEND_URL` to production domain
- [ ] Enable HTTPS
- [ ] Set up production session store
- [ ] Configure environment variables on hosting platform
- [ ] Test OAuth flow on production domain

## 🆘 Troubleshooting

### "Cannot GET /auth/steam"
- Make sure server is running
- Check PORT is correct (default 5000)

### "Session not persisting"
- Check browser cookies are enabled
- Verify sameSite policy compatibility
- Check cookie httpOnly flag

### "Steam API errors"
- Verify API key is correct
- Check API rate limits
- Make sure player profiles are public

### "CORS errors"
- Check FRONTEND_URL matches client domain
- Verify credentials: true in fetch requests

## 📚 References

- [Passport.js Documentation](http://www.passportjs.org/)
- [passport-steam GitHub](https://github.com/liamcurry/passport-steam)
- [Express.js Guide](https://expressjs.com/)
- [Steam Web API](https://developer.valvesoftware.com/wiki/Steam_Web_API)

---

**Made by Vide Coder - Manit Saxena**

Need help? Check the main README_QUICK.md or SETUP_OAUTH.md for more information.
