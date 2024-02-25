package app.iris.whereareyou.security.jwt;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.service.MemberService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@RequiredArgsConstructor
@Slf4j
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final TokenValidator validator;
    private final MemberService memberService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String bearerToken = request.getHeader("Authorization");

        if (StringUtils.hasText(bearerToken)) {
            String accessToken = resolveToken(bearerToken);
            validator.verifyToken((accessToken));

            Member member = memberService.findById(Long.parseLong(validator.getMemberId(accessToken))) ;

            Authentication auth = getAuthentication(member);
            SecurityContextHolder.getContext().setAuthentication(auth);
        }
        filterChain.doFilter(request, response);
    }

    private String resolveToken(String bearerToken) {
        if (bearerToken.length() > 7 && bearerToken.startsWith("Bearer")) {
            return bearerToken.substring(7);
        }
        throw new CustomException(HttpStatus.UNAUTHORIZED, "Bearer {AccessToken} 형식으로 요청해주세요.");
    }

    public Authentication getAuthentication(Member member) {
        CustomUserDetails userDetails = new CustomUserDetails(member);

        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }
}