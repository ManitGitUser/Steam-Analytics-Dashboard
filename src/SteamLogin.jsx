import React, { useState } from "react";

// --- MOCK DATA ---
const mockGames = [
  { appid: 730, name: "Counter-Strike 2", playtime_forever: 2400, rtime_last_played: Date.now() / 1000 - 86400 },
  { appid: 440, name: "Team Fortress 2", playtime_forever: 1800, rtime_last_played: Date.now() / 1000 - 172800 },
  { appid: 570, name: "Dota 2", playtime_forever: 3600, rtime_last_played: Date.now() / 1000 - 259200 },
  { appid: 271590, name: "Grand Theft Auto V", playtime_forever: 1200, rtime_last_played: 0 },
  { appid: 292030, name: "The Witcher 3", playtime_forever: 4800, rtime_last_played: Date.now() / 1000 - 604800 },
  { appid: 431960, name: "Wallpaper Engine", playtime_forever: 0, rtime_last_played: 0 },
  { appid: 1174180, name: "Red Dead Redemption 2", playtime_forever: 2100, rtime_last_played: 0 },
  { appid: 1091500, name: "Cyberpunk 2077", playtime_forever: 900, rtime_last_played: 0 }
];

const mockProfile = {
  personaname: "Demo Player",
  avatarfull: "https://avatars.steamstatic.com/b5bd56c1aa4644a474a2e4972be27ef9e82e517e_full.jpg",
  loccountrycode: "US",
  profileurl: "https://steamcommunity.com/profiles/demo"
};

// We now accept 'onUseDemoData' as a prop
function SteamLogin({ onSubmit, onUseDemoData }) {
  const [steamId, setSteamId] = useState(localStorage.getItem("steamId") || "");
  const [apiKey, setApiKey] = useState(localStorage.getItem("apiKey") || "");
  const [isLoggingIn, setIsLoggingIn] = useState(false);
  const [error, setError] = useState("");

  const handleOAuthLogin = () => {
    setIsLoggingIn(true);
    setError("");
    // Redirect to backend OAuth flow
    window.location.href = "http://localhost:5000/auth/steam";
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!steamId || !apiKey) {
      setError("Please enter both Steam ID and API Key");
      return;
    }
    localStorage.setItem("steamId", steamId);
    localStorage.setItem("apiKey", apiKey);
    onSubmit({ steamId, apiKey });
  };

  return (
    <div style={{
      backgroundColor: "#2a475e",
      padding: "25px",
      border: "1px solid #406883",
      borderRadius: "8px",
      width: "450px",
      margin: "40px auto",
      textAlign: "center",
      color: "#c7d5e0"
    }}>
      <h2 style={{ color: "white" }}>Steam Account Login</h2>
      <p style={{ fontSize: "13px", color: "#c7d5e0", marginBottom: "20px" }}>
        Choose a login method to access your game analytics
      </p>
      
      {error && (
        <div style={{
          backgroundColor: "#dc3545",
          padding: "10px",
          borderRadius: "6px",
          marginBottom: "15px",
          color: "white",
          fontSize: "13px"
        }}>
          {error}
        </div>
      )}

      {/* OAuth Login */}
      <div style={{ marginBottom: "20px" }}>
        <button
          onClick={handleOAuthLogin}
          disabled={isLoggingIn}
          style={{
            backgroundColor: "#1b2838",
            border: "2px solid #66c0f4",
            color: "#66c0f4",
            padding: "12px 20px",
            borderRadius: "5px",
            cursor: isLoggingIn ? "not-allowed" : "pointer",
            fontSize: "16px",
            fontWeight: "bold",
            width: "100%",
            transition: "all 0.3s",
            opacity: isLoggingIn ? 0.6 : 1
          }}
          onMouseEnter={(e) => !isLoggingIn && (e.target.style.backgroundColor = "#66c0f4", e.target.style.color = "#171a21")}
          onMouseLeave={(e) => (e.target.style.backgroundColor = "#1b2838", e.target.style.color = "#66c0f4")}
        >
          {isLoggingIn ? "🔄 Logging in..." : "🔐 Login with Steam OAuth"}
        </button>
        <p style={{ fontSize: "11px", color: "#999", marginTop: "8px" }}>
          Recommended: Secure OAuth authentication
        </p>
      </div>

      <div style={{
        borderTop: "1px solid #406883",
        borderBottom: "1px solid #406883",
        padding: "15px 0",
        margin: "20px 0"
      }}>
        <p style={{ fontSize: "12px", color: "#999" }}>OR</p>
      </div>

      {/* Manual API Key Login */}
      <div style={{ marginBottom: "20px" }}>
        <h3 style={{ fontSize: "14px", marginBottom: "10px", color: "white" }}>Manual Login</h3>
        <p style={{ fontSize: "12px", color: "#c7d5e0", marginBottom: "15px" }}>
          Enter your Steam ID and API Key for authentication.
        </p>
        
        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: "10px" }}>
            <input
              type="text"
              placeholder="Enter Steam ID (64-bit)"
              value={steamId}
              onChange={(e) => setSteamId(e.target.value)}
              style={{
                width: "100%",
                padding: "10px",
                borderRadius: "5px",
                border: "1px solid #406883",
                backgroundColor: "#1b2838",
                color: "#c7d5e0",
                fontSize: "14px",
                boxSizing: "border-box"
              }}
            />
          </div>
          <div style={{ marginBottom: "15px" }}>
            <input
              type="text"
              placeholder="Enter Steam API Key"
              value={apiKey}
              onChange={(e) => setApiKey(e.target.value)}
              style={{
                width: "100%",
                padding: "10px",
                borderRadius: "5px",
                border: "1px solid #406883",
                backgroundColor: "#1b2838",
                color: "#c7d5e0",
                fontSize: "14px",
                boxSizing: "border-box"
              }}
            />
          </div>
          <button
            type="submit"
            style={{
              backgroundColor: "#66c0f4",
              color: "#171a21",
              border: "none",
              padding: "12px 20px",
              borderRadius: "5px",
              cursor: "pointer",
              fontSize: "16px",
              fontWeight: "bold",
              width: "100%",
              transition: "opacity 0.2s"
            }}
            onMouseEnter={(e) => (e.target.style.opacity = "0.9")}
            onMouseLeave={(e) => (e.target.style.opacity = "1")}
          >
            Fetch My Data
          </button>
        </form>
      </div>

      {/* Demo Mode */}
      <div style={{
        backgroundColor: "#1b2838",
        padding: "10px 15px",
        borderRadius: "6px",
        fontSize: "12px",
        border: "1px solid #406883",
        textAlign: "left"
      }}>
        <strong>🎮 Try Demo Mode:</strong>
        <p style={{ marginTop: "5px", marginBottom: "5px" }}>
          No login required. See how the dashboard works with sample data.
        </p>
        <button
          onClick={(e) => {
            e.preventDefault();
            onUseDemoData(mockGames, mockProfile);
          }}
          style={{
            backgroundColor: "transparent",
            color: "#66c0f4",
            border: "1px solid #66c0f4",
            padding: "6px 12px",
            borderRadius: "4px",
            cursor: "pointer",
            fontSize: "11px",
            fontWeight: "bold",
            width: "100%"
          }}
        >
          Launch Demo
        </button>
      </div>
    </div>
  );
}

export default SteamLogin;