package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Bookmark;
import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookmarkRepository extends JpaRepository <Bookmark, Long> {
    boolean existsBookmarkByMemberAndPost(Member member, Post post);

    void deleteBookmarkByMemberIdAndPostId(Long memberId, Long postId);

    void deleteAllByPostId(Long postId);
}
