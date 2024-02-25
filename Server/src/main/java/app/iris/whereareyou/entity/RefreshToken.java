package app.iris.whereareyou.entity;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
public class RefreshToken extends TimeStamp{
    public  RefreshToken (Member member, String token){
        this.member = member;
        this.hashedToken = token;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    private Member member;

    @Column(nullable = false)
    private String hashedToken;

    public void setHashedToken(String hashedToken){
        this.hashedToken = hashedToken;
    }

    public String getHashedToken(){
        return hashedToken;
    }
}
