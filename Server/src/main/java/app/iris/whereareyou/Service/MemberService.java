package app.iris.whereareyou.service;

import app.iris.whereareyou.dto.TokenDto;
import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.dto.MemberInfoDto;
import app.iris.whereareyou.entity.Platform;
import app.iris.whereareyou.entity.RefreshToken;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.repository.MemberRepository;
import app.iris.whereareyou.repository.RefreshTokenRepository;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.security.GoogleUser;
import app.iris.whereareyou.security.jwt.TokenProvider;
import app.iris.whereareyou.security.jwt.TokenValidator;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final MemberRepository memberRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final TokenProvider tokenProvider;
    private final TokenValidator tokenValidator;
    private final BCryptPasswordEncoder passwordEncoder;

    @Transactional
    public TokenDto login(Member member) {
        String access = tokenProvider.generateAccessToken(member.getId(), member.getName());
        String refresh = tokenProvider.generateRefreshToken(member.getId());
        String hashed = passwordEncoder.encode(refresh);

        RefreshToken refreshToken = refreshTokenRepository.findByMemberId(member.getId()).orElse(null);
        if(refreshToken != null)
            refreshToken.setHashedToken(hashed);
        else
            refreshToken = new RefreshToken(member, hashed);


        refreshTokenRepository.save(refreshToken);

        return new TokenDto(access, refresh);
    }

    @Transactional
    public TokenDto reIssueToken(String refreshToken) {
        tokenValidator.verifyToken(refreshToken);

        Long id = Long.parseLong(tokenValidator.getSubject(refreshToken));
        RefreshToken stored = refreshTokenRepository.findByMemberId(id)
                .orElseThrow(() -> new CustomException(HttpStatus.NOT_FOUND, "토큰 정보를 찾을 수 없습니다."));

        if(!passwordEncoder.matches(refreshToken, stored.getHashedToken()))
            throw new CustomException(HttpStatus.UNAUTHORIZED, "유효하지 않은 토큰입니다. 다시 로그인해주세요.");

        String name = memberRepository.findById(id)
                .orElseThrow(() -> new CustomException(HttpStatus.NOT_FOUND, "해당 유저를 찾을 수 없습니다."))
                .getName();

        String access = tokenProvider.generateAccessToken(id, name);
        String refresh = tokenProvider.generateRefreshToken(id);
        String hashed = passwordEncoder.encode(refresh);
        stored.setHashedToken(hashed);
        refreshTokenRepository.save(stored);

        return new TokenDto(access, refresh);
    }

    @Transactional
    public Member findOrJoin(GoogleUser user, Platform platform) {
        return memberRepository.findByEmailAndPlatform(user.getEmail(), platform)
                .orElseGet(()->memberRepository.save(user.toMember()));
    }

    public Member findById(Long id){
        return memberRepository.findById(id)
                .orElseThrow(()->new CustomException(HttpStatus.NOT_FOUND, "해당 유저를 찾을 수 없습니다."));
    }

    public MemberInfoDto get(CustomUserDetails userDetails) {
        Member member = findById(Long.parseLong(userDetails.getUsername()));

        return new MemberInfoDto(member.getName(), member.getEmail(), member.getProfile());
    }
}
