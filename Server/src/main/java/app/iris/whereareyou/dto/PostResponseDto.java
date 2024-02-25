package app.iris.whereareyou.dto;

import app.iris.whereareyou.entity.Gender;
import app.iris.whereareyou.entity.Location;
import app.iris.whereareyou.entity.Post;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@Schema (description = "for /post response")
@Data
public class PostResponseDto {
    private long pid;
    private boolean isAuthor;
    private String name;

    @Schema( type = "string", examples = {"false:남", "true:여"})
    private boolean gender;

    private Integer age;
    private Integer height;
    private Integer weight;

    @Schema( type = "string", example = "서울시 용산구 갈월동 24")
    private String address;

    private double latitude;
    private double longitude;

    private String clothes;
    private String details;

    private boolean bookmarked;

    private LocalDateTime disappearedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<String> images;
    private String genImage;
    private boolean isGenRepresent;

    public PostResponseDto(Post post, Location location, List<String> imgUrlList, String genUrl, boolean bookmarked, boolean isAuthor, boolean isGenRepresent){
        this.pid = post.getId();
        this.name = post.getMissingName();
        this.gender = post.getMissingGender() == Gender.FEMALE;
        this.age = post.getMissingAge();
        this.height = post.getMissingHeight();
        this.weight = post.getMissingWeight();

        this.address = location.getAddress();
        this.latitude = location.getLatitude();
        this.longitude = location.getLongitude();

        this.clothes = post.getClothes();
        this.details = post.getDetails();

        this.disappearedAt = post.getDisappearedAt();
        this.createdAt = post.getCreatedAt();
        this.updatedAt = post.getUpdatedAt();

        this.images = imgUrlList;
        this.genImage = genUrl;

        this.bookmarked = bookmarked;
        this.isAuthor = isAuthor;
        this.isGenRepresent = isGenRepresent;
    }
}
