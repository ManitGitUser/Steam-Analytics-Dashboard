# Game Dashboard Backend - Spring Boot

This is the Spring Boot backend for the Steam Game Analytics Dashboard, replacing the Express.js server.

## Prerequisites

- Java 17+
- Maven 3.8+
- Steam API Key (from https://steamcommunity.com/dev/apikey)

## Setup

### 1. Create Environment File

```bash
cp .env.example .env
```

Edit `.env` and add your credentials:
```
STEAM_API_KEY=your_key_here
STEAM_CLIENT_ID=your_client_id
STEAM_CLIENT_SECRET=your_client_secret
```

### 2. Build the Project

```bash
mvn clean install
```

### 3. Run the Application

```bash
mvn spring-boot:run
```

Or:

```bash
java -jar target/game-dashboard-backend-1.0.0.jar
```

Server runs on: `http://localhost:5000`

## API Endpoints

### Authentication
- `GET /api/auth/user` - Get current authenticated user
- `POST /api/auth/logout` - Logout user
- `GET /api/health` - Health check

### Steam Data (requires authentication)
- `GET /api/steam/games` - Fetch user's owned games
- `GET /api/steam/profile` - Fetch user's Steam profile

## Configuration

Settings in `src/main/resources/application.yml`:
- Server port: 5000
- Frontend URL: http://localhost:5173
- Session timeout: 1800s
- CORS enabled for frontend

## Technologies Used

- Spring Boot 3.1.0
- Spring Security with OAuth2
- Spring Session
- RestTemplate for HTTP calls
- Lombok for boilerplate reduction

## Advantages over Express

✅ Enterprise-grade framework
✅ Built-in security
✅ Better performance for large scale
✅ Type-safe code
✅ Extensive ecosystem
✅ Better for team environments

## Troubleshooting

### Port already in use
Change PORT in `application.yml` or set via environment variable

### CORS errors
Verify `steam.frontend-url` in `application.yml` matches your frontend URL

### OAuth not working
- Check Steam API key is valid
- Verify callback URLs are correct
- Check application.yml OAuth2 configuration

## Building JAR

```bash
mvn clean package
java -jar target/game-dashboard-backend-1.0.0.jar
```
