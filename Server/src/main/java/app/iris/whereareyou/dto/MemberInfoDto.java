package app.iris.whereareyou.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class MemberInfoDto {
    private String name;
    private String email;
    private String profile_url;
}
