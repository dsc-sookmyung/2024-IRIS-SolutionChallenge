package app.iris.whereareyou.security;

import app.iris.whereareyou.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Log4j2
@Service
@RequiredArgsConstructor
public class OAuth2Service {
    @Value("${spring.security.oauth2.client.registration.google.client-id}")
    private String GOOGLE_CLIENT_ID;
    @Value("${spring.security.oauth2.client.registration.google.redirect-uri}")
    private String GOOGLE_CALLBACK_URI;
    @Value("${spring.security.oauth2.client.registration.google.client-secret}")
    private String GOOGLE_CLIENT_SECRET;

    private final WebClient webClient;

    public GoogleUser getUserInfo(String code) {
        GoogleOAuthToken googleOAuthToken = requestAccessToken(code);
        return requestUserInfo(googleOAuthToken);
    }

    private GoogleOAuthToken requestAccessToken(String code) {
        return webClient.post()
                .uri("https://oauth2.googleapis.com/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData("code", code)
                        .with("client_id", GOOGLE_CLIENT_ID)
                        .with("client_secret", GOOGLE_CLIENT_SECRET)
                        .with("redirect_uri", GOOGLE_CALLBACK_URI)
                        .with("grant_type", "authorization_code")
                        .with("access_type", "offline"))
                .retrieve()
                .onStatus(HttpStatusCode::isError, response -> response.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(GoogleOAuthToken.class)
                .block();
    }

    private GoogleUser requestUserInfo(GoogleOAuthToken oAuthToken) {
        String GOOGLE_USERINFO_REQUEST_URL="https://www.googleapis.com/oauth2/v1/userinfo";

        return webClient.get()
                .uri(GOOGLE_USERINFO_REQUEST_URL)
                .header("Authorization","Bearer " + oAuthToken.getAccess_token())
                .retrieve()
                .bodyToMono(GoogleUser.class)
                .block();
    }
}
