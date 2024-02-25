package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository <Comment, Long> {

    List<Comment> findAllByPostId(Long postId);
    List<Comment> findAllByPostIdAndAccuracyGreaterThanEqual(Long postId, double accuracy);

    void deleteByPostId(Long postId);
}
