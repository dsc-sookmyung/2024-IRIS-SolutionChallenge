package app.iris.whereareyou.security.jwt;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import io.jsonwebtoken.Jwts;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Component
public class TokenProvider {
    private static final long ACCESS_EXPIRATION  = 60 * 60 * 1000L; //1hour
    private static final long REFRESH_EXPIRATION = 60 * 60 * 24 * 14 * 1000L; //2weeks
    private final Key key;

    public String generateAccessToken(Long id, String name) {
        Date now = new Date();
        Map<String , String> map = new HashMap<>();
        map.put("id", String.valueOf(id));
        map.put("name", name);

        return Jwts.builder()
                .setClaims(map)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + ACCESS_EXPIRATION))
                .signWith(key)
                .compact();
    }

    public String generateRefreshToken(Long id) {
        Date now = new Date();

        return Jwts.builder()
                .setSubject(id.toString())
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + REFRESH_EXPIRATION))
                .signWith(key)
                .compact();
    }
}
