package app.iris.whereareyou.security;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Platform;
import app.iris.whereareyou.entity.Role;
import lombok.*;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class GoogleUser {
    private String id;
    private String email;
    private Boolean verifiedEmail;
    private String name;
    private String givenName;
    private String familyName;
    private String picture;
    private String locale;

    public Member toMember(){
        return Member.builder()
                .profile(picture)
                .platform(Platform.GOOGLE)
                .email(email)
                .name(name)
                .role(Role.ROLE_USER)
                .build();
    }
}