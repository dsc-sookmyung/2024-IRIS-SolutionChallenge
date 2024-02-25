package app.iris.whereareyou.controller;

import app.iris.whereareyou.exception.ErrorResponse;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.service.BookmarkService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/bookmarks")
@RestController
public class BookmarkController {
    private final BookmarkService bookmarkService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공"),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "조회 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "북마크 등록", security = { @SecurityRequirement(name = "bearerAuth")})
    @PostMapping("/{pid}")
    public ResponseEntity<?> createBookmark(
            @Parameter(description = "id of post") @PathVariable("pid") Long postId) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        bookmarkService.create(principal, postId);

        return ResponseEntity.ok().build();
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "조회 성공"),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "조회 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "북마크 삭제", security = { @SecurityRequirement(name = "bearerAuth")})
    @DeleteMapping("/{pid}")
    public ResponseEntity<?> deleteBookmark(
            @Parameter(description = "id of post") @PathVariable("pid") Long postId) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        bookmarkService.delete(principal, postId);

        return ResponseEntity.noContent().build();
    }
}
