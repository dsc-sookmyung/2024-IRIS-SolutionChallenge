package app.iris.whereareyou.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Schema (description = "for [Post] /post request")
@Data
public class PostCreateRequestDto {
    @NotBlank
    private String name;

    @NotBlank
    @Schema(examples = {"false:남", "true:여"})
    private boolean gender;

    @NotBlank
    private int age;

    @Schema(type = "Integer", defaultValue ="null")
    private Integer height;

    @Schema(type = "int", defaultValue ="null")
    private Integer weight;

    @NotBlank
    @Schema( type = "string", example = "서울시 용산구 갈월동 24")
    private String address;

    @NotBlank
    private double latitude;
    @NotBlank
    private double longitude;

    @NotBlank
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime disappearedAt;

    @NotBlank
    private String clothes;
    private String details;

    @NotBlank
    private List<MultipartFile> images;
}
