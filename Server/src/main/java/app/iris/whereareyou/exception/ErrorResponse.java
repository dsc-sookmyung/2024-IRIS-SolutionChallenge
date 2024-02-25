package app.iris.whereareyou.exception;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.time.LocalDateTime;

@Getter
@Builder
@Data
public class ErrorResponse {
    private final LocalDateTime timestamp = LocalDateTime.now();
    private final int status;
    private final String message;
    private final String details;


    public static ResponseEntity<ErrorResponse> toResponseEntity(HttpStatus httpStatus, String message) {
        return ResponseEntity
                .status(httpStatus)
                .body(ErrorResponse.builder()
                        .status(httpStatus.value())
                        .message(httpStatus.name())
                        .details(message)
                        .build()
                );
    }
}
