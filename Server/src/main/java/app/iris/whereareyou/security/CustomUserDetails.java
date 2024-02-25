package app.iris.whereareyou.security;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Platform;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Map;
import java.util.Set;

public class CustomUserDetails implements UserDetails, OAuth2User {
    private final Map<String, Object> attributes;
    private final Collection<? extends GrantedAuthority> authorities;
    private final String email;
    private final Platform platform;
    private final String name;
    private final Long id;

    public CustomUserDetails(Member member) {
        this.id = member.getId();
        this.email = member.getEmail();
        this.platform = member.getPlatform();
        this.name = member.getName();
        this.attributes = null;
        this.authorities = Set.of(new SimpleGrantedAuthority(member.getRole().toString()));
    }

    @Override
    public Map<String, Object> getAttributes() {
        return this.attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getUsername() {
        if(id == null)
            return email+platform;
        return String.valueOf(id);
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public String getPassword() {
        return null;
    }

    public Platform getPlatform() {
        return platform;
    }
    public String getEmail() {
        return email;
    }
}