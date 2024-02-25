package app.iris.whereareyou.dto.ML;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class GenImgRequestDto {
    String gender;
    String outfit;
}
