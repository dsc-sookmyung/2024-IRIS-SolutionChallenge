package app.iris.whereareyou.domain;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Platform;
import app.iris.whereareyou.entity.Role;
import app.iris.whereareyou.repository.MemberRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
public class MemberRepositoryTest {
    @Autowired
    MemberRepository memberRepository;

    @Transactional
    @Test
    public void findByEmailAndPlatformTest(){
        String email = "test@test.com";
        Platform platform = Platform.GOOGLE;
        String name = "테스트유저";

        Member create = memberRepository.save(
                Member.builder()
                        .name(name)
                        .email(email)
                        .role(Role.ROLE_USER)
                        .platform(platform)
                        .build()
        );

        Member find = memberRepository.findByEmailAndPlatform(email, platform).orElseThrow();
        Assertions.assertEquals(create.getId(), find.getId());
    }
}
