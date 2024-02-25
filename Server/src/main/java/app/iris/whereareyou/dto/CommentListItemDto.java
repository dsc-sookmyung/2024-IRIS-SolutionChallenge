package app.iris.whereareyou.dto;

import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.entity.Location;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class CommentListItemDto {
    private Long cid;
    private boolean isAuthor;
    private String address;
    private double longitude;
    private double latitude;
    private String clothes;
    private String details;
    private Double accuracy;
    private List<String> images;

     private LocalDateTime discoveredAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public CommentListItemDto(Comment comment, Location location, List<String> images, boolean isAuthor){
        this.cid = comment.getId();
        this.isAuthor = isAuthor;
        this.address = location.getAddress();
        this.latitude = location.getLatitude();
        this.longitude = location.getLongitude();
        this.clothes = comment.getClothes();
        this.details = comment.getDetails();
        this.accuracy = comment.getAccuracy();
        this.images = images;

        this.discoveredAt = comment.getDiscoveredAt();
        this.createdAt = comment.getCreatedAt();
        this.updatedAt = comment.getUpdatedAt();
    }
}
