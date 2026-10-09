# Java Spring Boot Backend Setup Guide

## Overview

The game-dashboard project now uses a **Spring Boot Java backend** instead of Express.js. The frontend remains exactly the same - only the backend server has changed.

**Key Benefits:**
- ✅ Enterprise-grade framework
- ✅ Better performance at scale
- ✅ Type-safe Java code
- ✅ Built-in security framework
- ✅ Easier to extend and maintain

## Prerequisites

### Required
- **Java 17 or higher** - Download from https://www.oracle.com/java/technologies/downloads/
- **Maven 3.8 or higher** - Download from https://maven.apache.org/download.cgi
- **Steam API Key** - Get free from https://steamcommunity.com/dev/apikey

### Verify Installation
```bash
java -version
mvn -version
```

## Project Structure

```
game-dashboard/
├── backend/                          # NEW - Java Spring Boot Backend
│   ├── pom.xml                      # Maven dependencies
│   ├── .env.example                 # Configuration template
│   ├── README.md                    # Backend documentation
│   └── src/
│       └── main/
│           ├── java/com/steamdashboard/
│           │   ├── GameDashboardApplication.java     # Main app
│           │   ├── controller/
│           │   │   ├── AuthController.java           # Auth endpoints
│           │   │   └── SteamController.java          # Steam API endpoints
│           │   ├── config/
│           │   │   ├── CorsConfig.java              # CORS setup
│           │   │   └── SecurityConfig.java          # OAuth2 setup
│           │   └── model/
│           │       ├── UserInfo.java                # User model
│           │       └── AuthResponse.java            # Response model
│           └── resources/
│               └── application.yml                   # Spring Boot config
│
├── src/                             # React Frontend (unchanged)
│   ├── App.jsx
│   ├── SteamLogin.jsx
│   └── [other components]
│
└── package.json                     # Frontend dependencies
```

## Installation Steps

### Step 1: Setup Environment Variables

```bash
cd backend
cp .env.example .env
```

Edit `backend/.env` and add your credentials:
```
STEAM_API_KEY=your_steam_api_key_here
STEAM_CLIENT_ID=your_client_id
STEAM_CLIENT_SECRET=your_client_secret
SERVER_PORT=5000
FRONTEND_URL=http://localhost:5173
```

### Step 2: Build the Java Backend

```bash
cd backend
mvn clean install
```

This downloads all dependencies and compiles the Java code.

**First time?** This may take 2-5 minutes as it downloads ~100MB of dependencies.

### Step 3: Run the Backend

Option A - Using Maven:
```bash
mvn spring-boot:run
```

Option B - Using JAR:
```bash
mvn clean package
java -jar target/game-dashboard-backend-1.0.0.jar
```

You should see:
```
Started GameDashboardApplication in 2.5 seconds
```

Backend runs on: **http://localhost:5000**

### Step 4: Run the Frontend

In a new terminal:
```bash
# From game-dashboard root folder
npm install
npm run dev
```

Frontend runs on: **http://localhost:5173**

### Step 5: Test the Application

1. Open http://localhost:5173
2. Click "Login with Steam OAuth"
3. You should be redirected to Steam login
4. After authorization, you'll be redirected back to the dashboard

## API Endpoints Reference

### Authentication
```
GET  /api/auth/user              # Get current authenticated user
POST /api/auth/logout            # Logout user
GET  /api/health                 # Health check
```

### Steam Data (requires authentication)
```
GET  /api/steam/games            # Get user's owned games
GET  /api/steam/profile          # Get user's Steam profile
```

## Configuration Files

### application.yml
Located at `backend/src/main/resources/application.yml`

```yaml
server.port: 5000                    # Server port
steam.api-key: ${STEAM_API_KEY}      # Steam API key
steam.frontend-url: http://localhost:5173  # Frontend URL
spring.session.timeout: 1800s        # Session timeout (30 minutes)
```

### pom.xml
Maven dependencies configuration. Key dependencies:
- Spring Boot Web
- Spring Security with OAuth2
- Spring Session
- Jackson (JSON processing)
- Lombok (reduces boilerplate)

## Common Commands

### Build Backend
```bash
mvn clean install
```

### Run Backend
```bash
mvn spring-boot:run
```

### Run Tests
```bash
mvn test
```

### Package as JAR
```bash
mvn clean package
# Output: target/game-dashboard-backend-1.0.0.jar
```

### View Dependencies
```bash
mvn dependency:tree
```

### Clean Build Artifacts
```bash
mvn clean
```

## Troubleshooting

### Maven Not Found
**Error:** `command not found: mvn`

**Solution:** 
1. Install Maven from https://maven.apache.org/download.cgi
2. Add to system PATH
3. Restart terminal

### Port 5000 Already in Use
**Error:** `Address already in use`

**Solution:**
1. Change port in `application.yml`:
   ```yaml
   server:
     port: 5001
   ```
2. Or kill process using port 5000

### CORS Errors in Browser
**Error:** `Access to XMLHttpRequest blocked by CORS policy`

**Solution:**
1. Check `steam.frontend-url` in `application.yml` matches your frontend
2. Verify it's `http://localhost:5173` (with http, not https)
3. Restart backend

### OAuth Not Working
**Error:** Redirects to blank page or 404

**Solution:**
1. Verify `STEAM_API_KEY` is correct
2. Check `.env` file exists in `backend/` folder
3. Verify `application.yml` OAuth2 configuration
4. Restart backend after .env changes

### Java Version Mismatch
**Error:** `ERROR: JAVA_HOME is not set and no 'java' command could be found`

**Solution:**
1. Install Java 17+ from https://www.oracle.com/java/technologies/downloads/
2. Set JAVA_HOME environment variable
3. Add to system PATH
4. Verify: `java -version` shows Java 17+

### Build Fails
**Error:** `[ERROR] COMPILATION ERROR`

**Solution:**
1. Clean: `mvn clean`
2. Rebuild: `mvn install`
3. Check Java version: `java -version`

## File Comparison: Express vs Spring Boot

| Aspect | Express | Spring Boot |
|--------|---------|------------|
| Main File | `server.js` (150 lines) | `GameDashboardApplication.java` (~10 lines) |
| Dependencies | `package.json` | `pom.xml` |
| Configuration | `.env` file | `.env` + `application.yml` |
| Security | Passport.js | Spring Security |
| Sessions | express-session | Spring Session |
| Routing | Express routes | Spring Controllers |
| Type Safety | Dynamic JS | Static Java |
| Performance | Good | Excellent |

## Frontend Changes

The React frontend (`src/`) has **minimal changes**:
- Updated error messages to mention "Java backend"
- Better error handling for HTTP requests
- Same API endpoints (still `/api/auth/user`, etc.)

**No breaking changes** - the frontend works identically!

## Deployment (Production)

### Build Production JAR
```bash
mvn clean package
```

Output: `backend/target/game-dashboard-backend-1.0.0.jar`

### Run on Production Server
```bash
java -jar game-dashboard-backend-1.0.0.jar \
  --STEAM_API_KEY=prod_key \
  --STEAM_CLIENT_ID=prod_client_id \
  --STEAM_CLIENT_SECRET=prod_secret \
  --steam.frontend-url=https://yourdomain.com
```

### Docker Deployment

Create `backend/Dockerfile`:
```dockerfile
FROM openjdk:17-slim
COPY target/game-dashboard-backend-1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
```

Build & run:
```bash
docker build -t game-dashboard-backend .
docker run -p 5000:5000 -e STEAM_API_KEY=your_key game-dashboard-backend
```

## Development Tips

### Hot Reload (Live Changes)
Spring Boot doesn't auto-reload by default. To enable:

1. Add to `pom.xml`:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
</dependency>
```

2. Run with: `mvn spring-boot:run`

### Debug Mode
```bash
mvn spring-boot:run -Dspring-boot.run.arguments=--debug
```

### View Application Logs
Already enabled in `application.yml`:
```yaml
logging:
  level:
    root: INFO
    org.springframework.security: DEBUG
```

### Test OAuth Locally
1. Make Steam profile public: https://steamcommunity.com/my/edit/profile
2. Or use Demo Mode to test UI

## Next Steps

1. ✅ Install Java and Maven
2. ✅ Get Steam API Key
3. ✅ Configure `.env` file
4. ✅ Run backend: `mvn spring-boot:run`
5. ✅ Run frontend: `npm run dev`
6. ✅ Test application
7. Optional: Customize and extend!

## Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Security OAuth2](https://spring.io/projects/spring-security-oauth)
- [Maven Documentation](https://maven.apache.org/guides/)
- [Steam Web API](https://developer.valvesoftware.com/wiki/Steam_Web_API)

## Support

For issues:
1. Check logs in terminal where you ran `mvn spring-boot:run`
2. Check browser console (F12) for frontend errors
3. Verify all configuration files
4. Ensure ports 5000 and 5173 are available

---

**Created:** January 2026
**Backend Type:** Spring Boot 3.1.0
**Java Version:** 17+
**Status:** Production Ready ✅
