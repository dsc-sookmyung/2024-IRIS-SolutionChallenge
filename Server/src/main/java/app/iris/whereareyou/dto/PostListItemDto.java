package app.iris.whereareyou.dto;

import app.iris.whereareyou.entity.Gender;
import app.iris.whereareyou.entity.Post;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PostListItemDto {
    private Long pid;
    private boolean isAuthor;
    private String imgUrl;
    private String name;
    private int age;
    private boolean gender;

    private String address;
    private double latitude;
    private double longitude;

    private LocalDateTime disappearedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private boolean bookmarked;

    public PostListItemDto(Post post, String imgUrl, boolean bookmarked, boolean isAuthor){
        this.pid = post.getId();
        this.imgUrl = imgUrl;
        this.name = post.getMissingName();
        this.age = post.getMissingAge();
        this.gender = post.getMissingGender() == Gender.FEMALE;

        this.address = post.getLocation().getAddress();
        this.longitude = post.getLocation().getLongitude();
        this.latitude = post.getLocation().getLatitude();

        this.disappearedAt = post.getDisappearedAt();
        this.createdAt = post.getCreatedAt();
        this.updatedAt = post.getUpdatedAt();

        this.bookmarked = bookmarked;
        this.isAuthor = isAuthor;
    }
}
