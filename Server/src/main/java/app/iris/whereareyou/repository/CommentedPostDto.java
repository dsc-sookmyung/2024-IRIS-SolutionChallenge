package app.iris.whereareyou.repository;

import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.entity.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class CommentedPostDto {
    private Post post;
    private Comment comment;
}
