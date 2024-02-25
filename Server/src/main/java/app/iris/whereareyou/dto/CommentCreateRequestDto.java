package app.iris.whereareyou.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class CommentCreateRequestDto {
    @NotBlank
    private Long pid;

    @NotBlank
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime discoveredAt;

    @NotBlank
    @Schema( type = "string", example = "서울시 용산구 갈월동 24")
    private String address;

    @NotBlank
    private double latitude;

    @NotBlank
    private double longitude;

    private String clothes;
    private String details;

    @NotBlank
    private List<MultipartFile> images;
}
