package app.iris.whereareyou.controller;

import app.iris.whereareyou.dto.*;
import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.exception.ErrorResponse;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.service.CommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class CommentController {
    private final CommentService commentService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "요청 성공",
                    content = { @Content(array = @ArraySchema(schema = @Schema(implementation = CommentListItemDto.class)))}),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "신고글 id로 제보글 list 조회", security = { @SecurityRequirement(name = "bearerAuth")})
    @GetMapping("/posts/{pid}/comments")
    public ResponseEntity<List<CommentListItemDto>> getCommentsById(
            @Parameter(description = "id of post") @PathVariable("pid") Long postId,
            @Parameter(description = "정확도 필터 적용 기준") @RequestParam(name="filter", required = false) Double filter
    ) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<CommentListItemDto> dto = commentService.getList(principal, postId, filter);

        return ResponseEntity.ok().body(dto);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "요청 성공",
                    content = { @Content(array = @ArraySchema(schema = @Schema(implementation = MyCommentsListItemDto.class)))}),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "작성한 제보글 list 조회", security = { @SecurityRequirement(name = "bearerAuth") })
    @GetMapping("/my-comments")
    public ResponseEntity<List<MyCommentsListItemDto>> getMyComments(
            @Parameter(description = "page Number of comment List") @RequestParam(name="pageNo", defaultValue="0") int pageNo,
            @Parameter(description = "page Size of comment List") @RequestParam(name="pageSize", defaultValue="6") int pageSize
    ) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<MyCommentsListItemDto> list = commentService.getMyCommentList(principal);

        return ResponseEntity.ok().body(list);
    }

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
    @Operation(summary = "제보글 작성", security = { @SecurityRequirement(name = "bearerAuth") })
    @PostMapping(path = "/comments", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> postComment(
            @RequestBody CommentCreateRequestDto requestDto) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        Comment comment = commentService.create(principal, requestDto);
        
        return ResponseEntity.ok().body("제보글 작성 성공");
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
    @Operation(summary = "제보글 삭제", security = { @SecurityRequirement(name = "bearerAuth") })
    @DeleteMapping(path = "/comments/{cid}")
    public ResponseEntity<?> deleteComment(
            @Parameter(description = "id of comment") @PathVariable("cid") Long commentId)
    {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        commentService.delete(principal, commentId);

        return ResponseEntity.noContent().build();
    }
}
