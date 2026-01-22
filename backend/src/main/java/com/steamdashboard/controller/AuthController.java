package com.steamdashboard.controller;

import com.steamdashboard.model.AuthResponse;
import com.steamdashboard.model.UserInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Value("${steam.api-key}")
    private String steamApiKey;

    @GetMapping("/user")
    public ResponseEntity<AuthResponse> getCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            AuthResponse response = new AuthResponse();
            response.setAuthenticated(false);
            return ResponseEntity.ok(response);
        }

        OAuth2User principal = (OAuth2User) authentication.getPrincipal();
        UserInfo user = new UserInfo();
        user.setUsername((String) principal.getAttributes().get("name"));
        user.setSteamId((String) principal.getAttributes().get("sub"));
        user.setProfileUrl((String) principal.getAttributes().get("profile"));
        
        Object pictureObj = principal.getAttributes().get("picture");
        if (pictureObj != null) {
            user.setAvatar(pictureObj.toString());
        }

        AuthResponse response = new AuthResponse();
        response.setAuthenticated(true);
        response.setUser(user);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public ResponseEntity<Map<String, Boolean>> logout() {
        return ResponseEntity.ok(Map.of("success", true));
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        return ResponseEntity.ok(Map.of("status", "ok"));
    }
}
