package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.entity.Image;
import app.iris.whereareyou.entity.Post;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {

    Optional<Image> findByPostAndIsRepresentTrue(Post post);

    @Override
    <S extends Image> Optional<S> findOne(Example<S> example);

    @Query("SELECT img.url "+
            "FROM Image img "+
            "WHERE img.post.id = :postId AND img.isGenImage = false ")
    List<String> findAllUrlByPost(@Param("postId") Long postId);

    @Query("SELECT img.url "+
            "FROM Image img "+
            "WHERE img.comment.id = :commentId")
    List<String> findAllUrlByCommentId(@Param("commentId") Long commentId);

    @Query("SELECT img.name "+
            "FROM Image img "+
            "WHERE img.post.id = :postId")
    List<String> findAllNameByPostId(@Param("postId") Long postId);

    @Query("SELECT img.name "+
            "FROM Image img "+
            "WHERE img.comment.id = :commentId")
    List<String> findAllNameByCommentId(@Param("commentId") Long commentId);

    @Modifying
    @Query("DELETE "+
            "FROM Image img " +
            "WHERE img.comment.post.id = :postId")
    void deleteCommentImgByPostId (@Param("postId") Long postId);

    void deleteAllByCommentId(Long commentId);

    void deleteAllByPostId(Long postId);

    Optional<Image> findTopByPostAndIsGenImage(Post post, boolean genImage);
}
