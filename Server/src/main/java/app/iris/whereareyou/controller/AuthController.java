package app.iris.whereareyou.controller;

import app.iris.whereareyou.dto.TokenDto;
import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.dto.MemberInfoDto;
import app.iris.whereareyou.entity.Platform;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.security.GoogleUser;
import app.iris.whereareyou.security.OAuth2Service;
import app.iris.whereareyou.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class AuthController {
    private final MemberService memberService;
    private final OAuth2Service oAuth2Service;

    @Operation(summary = "Google 소셜로그인 콜백")
    @GetMapping(value = "/auth/google/callback")
    public ResponseEntity<TokenDto> callback(@RequestParam(name = "code") String code) {
        GoogleUser user = oAuth2Service.getUserInfo(code);

        Member member = memberService.findOrJoin(user, Platform.GOOGLE);
        TokenDto dto = memberService.login(member);

        return ResponseEntity.ok().body(dto);
    }

    @Operation(summary = "refresh token을 이용한 토큰 재발급")
    @GetMapping(value = "/auth/refresh")
    public ResponseEntity<TokenDto> reIssueToken(@RequestHeader(required = true, name = "refreshToken") String refreshToken) {
        TokenDto dto = memberService.reIssueToken(refreshToken);
        return ResponseEntity.ok().body(dto);
    }

    @Operation(summary = "유저 정보 요청", security = { @SecurityRequirement(name = "bearerAuth")})
    @GetMapping(value = "/member")
    public ResponseEntity<MemberInfoDto> getUserInfo() {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        MemberInfoDto dto = memberService.get(principal);

        return ResponseEntity.ok().body(dto);
    }
}
