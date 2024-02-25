package app.iris.whereareyou.dto;

import lombok.Data;

@Data
public class TokenDto {
    private String grantType;
    private String accessToken;
    private String refreshToken;

    public TokenDto(String access, String refresh) {
        grantType = "Bearer";
        accessToken = access;
        refreshToken = refresh;
    }
}
