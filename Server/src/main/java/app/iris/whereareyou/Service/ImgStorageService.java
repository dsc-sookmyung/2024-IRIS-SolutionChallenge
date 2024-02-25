package app.iris.whereareyou.service;

import app.iris.whereareyou.dto.ML.GenImgRequestDto;
import app.iris.whereareyou.dto.ML.GenImgResponseDto;
import app.iris.whereareyou.entity.Comment;
import app.iris.whereareyou.entity.Gender;
import app.iris.whereareyou.entity.Image;
import app.iris.whereareyou.entity.Post;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.repository.ImageRepository;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import lombok.RequiredArgsConstructor;
import lombok.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
@Service
public class ImgStorageService {
    //@Value("${spring.cloud.gcp.storage.bucket}")
    private final String bucketName = "bucketName";
    private final Storage storage;
    private final WebClient webClient;
    private final ImageRepository imageRepository;

    public List<String> getList(Post post){
        return imageRepository.findAllUrlByPost(post.getId());
    }

    public List<String> getList(Comment comment) {
        return imageRepository.findAllUrlByCommentId(comment.getId());
    }

    public String getRepresentative(Post post) {
        Image img = imageRepository.findByPostAndIsRepresentTrue(post).orElse(null);
        return img != null ? img.getUrl() : null;
    }

    public void setRepresentative(Post post, boolean genImage) {
        Image prevRepresent = imageRepository.findByPostAndIsRepresentTrue(post)
                .orElseThrow(()-> new CustomException(HttpStatus.NOT_FOUND, "제보 정보의 사진을 찾을 수 없습니다."));
        prevRepresent.setRepresent(false);
        imageRepository.save(prevRepresent);

        Image image = imageRepository.findTopByPostAndIsGenImage(post, genImage)
                .orElseThrow(()-> new CustomException(HttpStatus.NOT_FOUND, "제보 정보의 사진을 찾을 수 없습니다."));

        image.setRepresent(true);
        imageRepository.save(image);
    }

    public Image getGenImageUrl (Post post){
        return imageRepository.findTopByPostAndIsGenImage(post, true)
                .orElseThrow(()-> new CustomException(HttpStatus.NOT_FOUND, "제보 정보의 사진을 찾을 수 없습니다."));
    }

    @Transactional
    public List<String> createImage(List<MultipartFile> fileList, Post post)  {
        List<String> imgUrlList = new ArrayList<>();

        for(MultipartFile file: fileList){
            String uuid = UUID.randomUUID().toString();
            String imgUrl = uploadImage(file, uuid);
            imageRepository.save(Image.builder().post(post).url(imgUrl).name(uuid).build());
            imgUrlList.add(imgUrl);
        }
        return imgUrlList;
    }

    @Transactional
    public List<String> createImage(List<MultipartFile> fileList, Comment comment)  {
        List<String> imgUrlList = new ArrayList<>();

        for(MultipartFile file: fileList){
            String uuid = UUID.randomUUID().toString();
            String imgUrl = uploadImage(file, uuid);
            imageRepository.save(Image.builder().comment(comment).url(imgUrl).name(uuid).build());
            imgUrlList.add(imgUrl);
        }
        return imgUrlList;
    }

    private String uploadImage(MultipartFile file, String path) {
        String contentType = file.getContentType();

        BlobId blobId = BlobId.of(bucketName, path);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType(contentType).build();

        Blob blob = null;
        try {
            blob = storage.create(blobInfo, file.getBytes());
        }catch (IOException e){
            throw new CustomException(HttpStatus.BAD_REQUEST, "Image 파일 업로드에 실패했습니다.");
        }

        return blob.getMediaLink();
    }

    public String createGenImage(Post post) {
        String gender = post.getMissingGender() == Gender.FEMALE ? "여자" : "남자";
        GenImgRequestDto requestDto = new GenImgRequestDto(gender, post.getClothes());

        GenImgResponseDto response =  webClient.post()
                .uri("MLServerUrl")
                .body(BodyInserters.fromValue(requestDto))
                .retrieve()
                .onStatus(HttpStatusCode::isError, res -> res.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(GenImgResponseDto.class)
                .block();

        imageRepository.save(Image.builder()
                        .url(response.getSigned_url())
                        .name(extractBlobName(response.getSigned_url()))
                        .post(post)
                        .isGenImage(true)
                        .isRepresent(true)
                        .build());

         return response.getSigned_url();
    }

    @Transactional
    public void deleteCommentImage(Long commentId) {
        imageRepository.findAllNameByCommentId(commentId).forEach(this::deleteImage);
        imageRepository.deleteAllByCommentId(commentId);
    }

    @Transactional
    public void deletePostImage(Long postId) {
        imageRepository.findAllNameByPostId(postId).forEach(this::deleteImage);
        imageRepository.deleteAllByPostId(postId);
        imageRepository.deleteCommentImgByPostId(postId);
    }

    private void deleteImage(String uuid) {
        BlobId blobId = BlobId.of(bucketName, uuid);
        storage.delete(blobId);
    }

    public String extractBlobName(String url) {
        if(!url.startsWith("https://storage.googleapis.com"))
            return null;
        int start = url.lastIndexOf('/');
        int end = url.contains("?") ? url.lastIndexOf('?') : url.length();
        if (start > 0 && end <= url.length()) {
            return "gen-image/" + url.substring(start + 1, end);
        }
        return null;
    }
}
