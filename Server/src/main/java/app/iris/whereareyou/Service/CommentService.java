package app.iris.whereareyou.service;

import app.iris.whereareyou.dto.CommentCreateRequestDto;
import app.iris.whereareyou.dto.CommentListItemDto;
import app.iris.whereareyou.dto.ML.AccuracyDto;
import app.iris.whereareyou.dto.MyCommentsListItemDto;
import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.entity.Location;
import app.iris.whereareyou.entity.Member;
import app.iris.whereareyou.entity.Post;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.repository.*;
import app.iris.whereareyou.security.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class CommentService {
    private final WebClient webClient;

    private final CommentRepository commentRepository;
    private final LocationRepository locationRepository;
    private final PostRepository postRepository;
    private final PostService postService;
    private final MemberService memberService;
    private final ImgStorageService imgStorageService;

    @Transactional
    public Comment create(CustomUserDetails userDetails, CommentCreateRequestDto requestDto) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));
        Post post = postService.get(requestDto.getPid());

        Location location = locationRepository.save(
                Location.builder()
                        .address(requestDto.getAddress())
                        .latitude(requestDto.getLatitude())
                        .longitude(requestDto.getLongitude())
                        .build());
        Comment comment = commentRepository.save(Comment.builder()
                .clothes(requestDto.getClothes())
                .details(requestDto.getDetails())
                .discoveredAt(requestDto.getDiscoveredAt())
                .location(location)
                .author(member)
                .post(post)
                .build());

        List<String> urlList1 = imgStorageService.getList(post);
        List<InputStreamSource> file2List = getImages(urlList1);
        List<String> urlList2 = imgStorageService.createImage(requestDto.getImages(), comment);
        List<InputStreamSource> file1List = getImages(urlList2);

        double accuracy = requestAccuracy(file1List, file2List);
        comment.setAccuracy(accuracy);

        return commentRepository.save(comment);
    }

    @Transactional
    public void delete(CustomUserDetails userDetails, Long commentId) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));
        Comment comment = commentRepository.findById(commentId).orElseThrow(()-> new CustomException(HttpStatus.BAD_REQUEST, "해당 제보글을 찾을 수 없습니다."));

        if(member != comment.getAuthor())
            throw new CustomException(HttpStatus.FORBIDDEN, "삭제 권한이 없습니다.");

        imgStorageService.deleteCommentImage(commentId);
        commentRepository.deleteById(commentId);
    }

    public double requestAccuracy(List<InputStreamSource> file1List, List<InputStreamSource> file2List) {
        MultiValueMap<String, InputStreamSource> map = new LinkedMultiValueMap<>();
        map.put("file1", file2List);
        map.put("file2", file1List);

        AccuracyDto response = webClient.post()
                .uri("http://104.199.126.137:8000/verify-faces")
                .header("Content-Type", "multipart/form-data")
                .body(BodyInserters.fromMultipartData(map))
                .retrieve()
                .onStatus(HttpStatusCode::isError, res -> res.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.INTERNAL_SERVER_ERROR, errorBody))))
                .bodyToMono(AccuracyDto.class)
                .block();
        return response.getConfidence_percent();
    }

    public List<InputStreamSource> getImages (List<String> imgUrlList) {
        List<InputStreamSource> list = new ArrayList<>();
        for(String url: imgUrlList){
            InputStreamResource stream = webClient.get()
                    .uri(url)
                    .retrieve()
                    .onStatus(HttpStatusCode::isError, response ->
                            response.bodyToMono(String.class).flatMap(errorBody -> {
                                log.error(errorBody);
                                return Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, "제보 사진의 일치율을 계산할 수 없습니다."));}))
                    .bodyToMono(InputStreamResource.class)
                    .block();

            list.add(convertResource(stream, extractBlobName(url)));
        }
        return list;
    }

    private InputStreamSource convertResource (InputStreamResource inputStream, String filename) {
        byte[] bytes = new byte[0];
        try {
            bytes = inputStream.getInputStream().readAllBytes();
        } catch (IOException e) {
            e.printStackTrace();
            throw new CustomException(HttpStatus.UNAUTHORIZED, "제보 사진의 일치율을 계산할 수 없습니다.");
        }
        return new ByteArrayResource(bytes) {
            @Override
            public String getFilename(){return filename;}
        };
    }

    public List<CommentListItemDto> getList(CustomUserDetails userDetails, Long postId, Double filter) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));
        List<CommentListItemDto> dto = new ArrayList<>();

        List<Comment> commentList;
        if(filter != null)
            commentList = commentRepository.findAllByPostIdAndAccuracyGreaterThanEqual(postId, filter);
        else
            commentList = commentRepository.findAllByPostId(postId);

        for(Comment comment : commentList){
            List<String> images = imgStorageService.getList(comment);
            dto.add(new CommentListItemDto(comment, comment.getLocation(), images, comment.getAuthor()==member));
        }
        return dto;
    }

    public List<MyCommentsListItemDto> getMyCommentList(CustomUserDetails userDetails) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));
        List<MyCommentsListItemDto> list = new ArrayList<>();

        List<CommentedPostDto> resultList = postRepository.findAllCommentedByMember(member);
        MultiValueMap<Long, CommentListItemDto> map = new LinkedMultiValueMap<>();

        for (CommentedPostDto result : resultList) {
            Comment comment = result.getComment();
            List<String> images = imgStorageService.getList(comment);
            map.add(result.getPost().getId(), new CommentListItemDto(comment, comment.getLocation(), images, true) );
        }
        for (CommentedPostDto result : resultList) {
            Post post = result.getPost();
            if(!map.containsKey(post.getId()))
                continue;
            String representImg = imgStorageService.getRepresentative(post);
            list.add(new MyCommentsListItemDto(post, representImg ,map.get(post.getId())));
            map.remove(post.getId());
        }
        return list;
    }

    private String extractBlobName(String url) {
        if(!url.startsWith("https://storage.googleapis.com"))
            return null;
        int start = url.lastIndexOf('/');
        int end = url.lastIndexOf('?');
        if (start > 0 && end < url.length() - 1) {
            return url.substring(start + 1, end);
        }
        return null;
    }
}
