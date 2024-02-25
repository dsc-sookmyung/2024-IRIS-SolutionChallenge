package app.iris.whereareyou.dto;

import app.iris.whereareyou.entity.Gender;
import app.iris.whereareyou.entity.Post;
import lombok.Data;

import java.util.List;

@Data
public class MyCommentsListItemDto {
    //신고글Post 정보
    private long pid;
    private String name;
    private String imgUrl;
    private int age;
    private boolean gender;
    private String address;

    private List<CommentListItemDto> commentList;

    public MyCommentsListItemDto(Post post, String imgUrl ,List<CommentListItemDto> commentList){
        this.pid = post.getId();
        this.name = post.getMissingName();
        this.imgUrl = imgUrl;
        this.age = post.getMissingAge();
        this.gender = post.getMissingGender() == Gender.FEMALE;
        this.address = post.getLocation().getAddress();

        this.commentList = commentList;
    }
}
