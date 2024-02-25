package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Platform;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

    boolean existsByEmailAndPlatform(String email, Platform platform);

    Optional<Member> findByEmailAndPlatform(String email, Platform platform);
}
