package app.iris.whereareyou.service;

import app.iris.whereareyou.dto.PostCreateRequestDto;
import app.iris.whereareyou.dto.PostCreateResponseDto;
import app.iris.whereareyou.dto.PostListItemDto;
import app.iris.whereareyou.dto.PostResponseDto;
import app.iris.whereareyou.entity.*;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.repository.BookmarkRepository;
import app.iris.whereareyou.repository.CommentRepository;
import app.iris.whereareyou.repository.LocationRepository;
import app.iris.whereareyou.repository.PostRepository;
import app.iris.whereareyou.security.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class PostService {
    private final PostRepository postRepository;
    private final BookmarkRepository bookmarkRepository;
    private final LocationRepository locationRepository;
    private final CommentRepository commentRepository;
    private final MemberService memberService;
    private final ImgStorageService imgStorageService;

    public Post get(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(()-> new CustomException(HttpStatus.BAD_REQUEST, "신고 정보를 찾을 수 없습니다."));
    }

    public PostResponseDto get(CustomUserDetails userDetails, Long id) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        Post post = postRepository.findById(id)
                .orElseThrow(()->new CustomException(HttpStatus.BAD_REQUEST, "신고 정보를 찾을 수 없습니다."));

        boolean bookmarked = bookmarkRepository.existsBookmarkByMemberAndPost(member, post);

        List<String> urlList = imgStorageService.getList(post);
        Image genImage = imgStorageService.getGenImageUrl(post);

        return new PostResponseDto(post, post.getLocation(), urlList, genImage.getUrl(), bookmarked, member==post.getAuthor(), genImage.isRepresent());
    }

    @Transactional
    public PostCreateResponseDto createPost(PostCreateRequestDto requestDto, CustomUserDetails userDetails){
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        Location location = locationRepository.save(convertLocation(requestDto));
        Post post = postRepository.save(convertPost(member, location, requestDto));

        imgStorageService.createImage(requestDto.getImages(), post);

        String genImageUrl = imgStorageService.createGenImage(post);

        return new PostCreateResponseDto(genImageUrl, post.getId());
    }

    @Transactional
    public void delete(Long id, CustomUserDetails userDetails){
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        Post post = postRepository.findById(id)
                .orElseThrow(()->new CustomException(HttpStatus.BAD_REQUEST, "해당 신고글을 찾을 수 없습니다."));

        if(post.getAuthor().getId()!=member.getId())
            throw new CustomException(HttpStatus.FORBIDDEN, "삭제 권한이 없습니다.");

        bookmarkRepository.deleteAllByPostId(post.getId());
        imgStorageService.deletePostImage(post.getId());
        commentRepository.deleteByPostId(post.getId());
        postRepository.delete(post);
    }

    private Post convertPost(Member member, Location location, PostCreateRequestDto dto) {
        return Post.builder()
                .author(member)
                .location(location)
                .disappearedAt(dto.getDisappearedAt())
                .missingName(dto.getName())
                .missingGender(dto.isGender()? Gender.FEMALE : Gender.MALE)
                .missingAge(dto.getAge())
                .missingHeight(dto.getHeight())
                .missingWeight(dto.getWeight())
                .clothes(dto.getClothes())
                .details(dto.getDetails())
                .build();
    }

    private Location convertLocation(PostCreateRequestDto dto){
        return Location
                .builder()
                .address(dto.getAddress())
                .latitude(dto.getLatitude())
                .longitude(dto.getLongitude())
                .build();
    }

    public List<PostListItemDto> getPostList(CustomUserDetails userDetails, Double latitude, Double longitude) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        Double startLat = latitude-0.7;
        Double endLat = latitude+0.7;
        Double startLong = longitude-0.14;
        Double endLong = longitude+0.14;

        List<PostListItemDto> dtoList = new ArrayList<>();
        List<Post> postList = postRepository.findAllByLocationInRangeOrderByCreatedAtDesc(startLong, endLong, startLat, endLat);
        for(Post post: postList){
            boolean bookmarked = bookmarkRepository.existsBookmarkByMemberAndPost(member, post);
            String url = imgStorageService.getRepresentative(post);
            dtoList.add(new PostListItemDto(post, url, bookmarked, post.getAuthor()==member));
        }
        return dtoList;
    }

    public List<PostListItemDto> getMyPostList(CustomUserDetails userDetails, int pageNo, int PageSize){
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        List<PostListItemDto> dtoList = new ArrayList<>();
        List<Post> postList = postRepository.findAllByAuthor(member);
        for(Post post: postList){
            boolean bookmarked = bookmarkRepository.existsBookmarkByMemberAndPost(member, post);
            String url = imgStorageService.getRepresentative(post);
            dtoList.add(new PostListItemDto(post, url, bookmarked, post.getAuthor() == member));
        }
        return dtoList;
    }

    public List<PostListItemDto> getBookmarkedPostList(CustomUserDetails userDetails, int pageNo, int PageSize){
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));

        List<PostListItemDto> dtoList = new ArrayList<>();
        List<Post> postList = postRepository.findAllBookmarked(member);
        for(Post post: postList){
            boolean bookmarked = bookmarkRepository.existsBookmarkByMemberAndPost(member, post);
            String url = imgStorageService.getRepresentative(post);
            dtoList.add(new PostListItemDto(post, url, bookmarked, post.getAuthor() == member));
        }
        return dtoList;
    }

    public PostResponseDto setRepresentImage(CustomUserDetails userDetails, Long postId, boolean genImage) {
        Member member = memberService.findById(Long.parseLong(userDetails.getUsername()));
        Post post = postRepository.findById(postId).orElseThrow(()-> new CustomException(HttpStatus.BAD_REQUEST, "해당 신고글을 찾을 수 없습니다."));

        if(post.getAuthor() != member)
            throw new CustomException(HttpStatus.FORBIDDEN, "권한이 없습니다.");

        imgStorageService.setRepresentative(post, genImage);

        List<String> urlList = imgStorageService.getList(post);
        String genUrl = imgStorageService.getGenImageUrl(post).getUrl();

        return new PostResponseDto(post, post.getLocation(), urlList, genUrl, post.getAuthor() == member  , true, genImage);
    }
}