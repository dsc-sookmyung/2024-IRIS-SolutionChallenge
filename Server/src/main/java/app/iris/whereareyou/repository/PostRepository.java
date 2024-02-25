package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Post;
import app.iris.whereareyou.repository.CommentedPostDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {

    @Query("SELECT p " +
            "FROM Post p " +
            "WHERE p.location.latitude BETWEEN :startLat AND :endLat " +
            "AND p.location.longitude BETWEEN :startLong AND :endLong "+
            "ORDER BY p.updatedAt DESC "    )
    List<Post> findAllByLocationInRangeOrderByCreatedAtDesc(@Param("startLong") Double startLongitude, @Param("endLong") Double endLongitude,
                                        @Param("startLat") Double startLatitude, @Param("endLat") Double endLatitude);

    List<Post> findAllByAuthor(Member member);

    @Query("SELECT b.post " +
            "FROM Bookmark b " +
            "WHERE b.member = :member ")
    List<Post> findAllBookmarked(@Param("member") Member member);

    @Query("SELECT new app.iris.whereareyou.repository.CommentedPostDto(p, c) " +
            "FROM Comment c, Post p " +
            "WHERE c.author = :author " +
            "AND p.id = c.post.id")
    List<CommentedPostDto> findAllCommentedByMember(@Param("author") Member author);
}
