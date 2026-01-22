package com.steamdashboard.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RestController
@RequestMapping("/api/steam")
public class SteamController {

    @Value("${steam.api-key}")
    private String steamApiKey;

    private final RestTemplate restTemplate;

    public SteamController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/games")
    public ResponseEntity<?> getGames(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(401).body(Map.of("error", "Not authenticated"));
        }

        OAuth2User principal = (OAuth2User) authentication.getPrincipal();
        String steamId = (String) principal.getAttributes().get("sub");

        try {
            String url = "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/" +
                    "?key=" + steamApiKey +
                    "&steamid=" + steamId +
                    "&include_appinfo=true" +
                    "&include_played_free_games=true" +
                    "&format=json";

            Map<String, Object> response = restTemplate.getForObject(url, Map.class);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(401).body(Map.of("error", "Not authenticated"));
        }

        OAuth2User principal = (OAuth2User) authentication.getPrincipal();
        String steamId = (String) principal.getAttributes().get("sub");

        try {
            String url = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/" +
                    "?key=" + steamApiKey +
                    "&steamids=" + steamId +
                    "&format=json";

            Map<String, Object> response = restTemplate.getForObject(url, Map.class);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage()));
        }
    }
}
