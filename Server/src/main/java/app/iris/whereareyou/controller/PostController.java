package app.iris.whereareyou.controller;

import app.iris.whereareyou.dto.PostCreateRequestDto;
import app.iris.whereareyou.dto.PostCreateResponseDto;
import app.iris.whereareyou.dto.PostResponseDto;
import app.iris.whereareyou.dto.PostListItemDto;
import app.iris.whereareyou.exception.ErrorResponse;
import app.iris.whereareyou.security.CustomUserDetails;
import app.iris.whereareyou.service.PostService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
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
@RequestMapping("/posts")
@RestController
public class PostController {
    private final PostService postService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = PostResponseDto.class)) }),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "조회 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "신고글 id로 신고글 단건(세부) 조회", security = { @SecurityRequirement(name = "bearerAuth") })
    @GetMapping("/{id}")
    public ResponseEntity<PostResponseDto> getPostById(@Parameter(description = "id of post")
                                                           @PathVariable("id") Long id) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        PostResponseDto responseDto = postService.get(principal, id);
        return ResponseEntity.ok().body(responseDto);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "요청 성공",
                    content = { @Content(array = @ArraySchema(schema = @Schema(implementation = PostListItemDto.class)))}),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "신고글 List 조회", security = { @SecurityRequirement(name = "bearerAuth") })
    @GetMapping
    public ResponseEntity<List<PostListItemDto>> getPostList(
            @Parameter(description = "위도") @RequestParam(name="latitude", required = false) Double latitude ,
            @Parameter(description = "경도") @RequestParam(name="longitude", required = false) Double longitude,
            @Parameter(description = "목적: ALL, MINE, BOOKMARKED") @RequestParam(name="for", defaultValue="ALL") PURPOSE purpose ,
            @Parameter(description = "page Number of post List") @RequestParam(name="pageNo", defaultValue="0") int pageNo,
            @Parameter(description = "page Size of post List") @RequestParam(name="pageSize", defaultValue="6") int pageSize)
    {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<PostListItemDto> list = null;
        switch (purpose){
            case ALL ->  list = postService.getPostList(principal, latitude, longitude);
            case MINE -> list = postService.getMyPostList(principal, pageNo, pageSize);
            case BOOKMARKED -> list = postService.getBookmarkedPostList(principal, pageNo, pageSize);
        }
        return ResponseEntity.ok().body(list);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "요청 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = PostCreateResponseDto.class)) }),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "BAD REQUEST 업로드 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "신고글 작성", security = { @SecurityRequirement(name = "bearerAuth") })
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<PostCreateResponseDto> postPost(@ModelAttribute PostCreateRequestDto requestDto){
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        PostCreateResponseDto responseDto = postService.createPost(requestDto, principal);

        return ResponseEntity.ok().body(responseDto);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "요청 성공",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = PostResponseDto.class)) }),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })
             })
    @Operation(summary = "생성 이미지 대표 설정", security = { @SecurityRequirement(name = "bearerAuth") })
    @PostMapping(path = "/{pid}/set-representative")
    public ResponseEntity<PostResponseDto> setRepresentImage(
            @PathVariable("pid") Long postId,
            @Parameter(description = "생성 이미지 대표 설정 여부") @RequestParam(name="gen", required = true) boolean genImage) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        PostResponseDto responseDto = postService.setRepresentImage(principal, postId, genImage);

        return ResponseEntity.ok().body(responseDto);
    }


    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "삭제 성공",
                    content = @Content),
            @ApiResponse(responseCode = "403", description = "인증 헤더 누락",
                    content = @Content),
            @ApiResponse(responseCode = "401", description = "인증 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "조회 실패",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = ErrorResponse.class)) })})
    @Operation(summary = "신고글 삭제", security = { @SecurityRequirement(name = "bearerAuth") })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@Parameter(description = "id of post")
                                            @PathVariable("id") Long id) {
        CustomUserDetails principal = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        postService.delete(id, principal);
        return ResponseEntity.noContent().build();
    }
}
