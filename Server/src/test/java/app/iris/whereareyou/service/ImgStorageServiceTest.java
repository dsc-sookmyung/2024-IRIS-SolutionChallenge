package app.iris.whereareyou.service;

import app.iris.whereareyou.dto.ML.AccuracyDto;
import app.iris.whereareyou.dto.ML.GenImgRequestDto;
import app.iris.whereareyou.entity.Post;
import app.iris.whereareyou.exception.CustomException;
import app.iris.whereareyou.repository.BookmarkRepository;
import app.iris.whereareyou.repository.CommentRepository;
import app.iris.whereareyou.repository.ImageRepository;
import app.iris.whereareyou.repository.PostRepository;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.Storage;
import jdk.jfr.ContentType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.MultiValueMapAdapter;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.util.*;

@SpringBootTest
public class ImgStorageServiceTest {
    @Autowired
    private Storage storage;
    @Autowired
    private ImgStorageService imgStorageService;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private BookmarkRepository bookmarkRepository;
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private WebClient webClient;

    @Test
    public void downloadImg() throws IOException {
        String url = "url";

        InputStreamResource stream1 = webClient.get()
                .uri(url)
                .retrieve()
                .onStatus(HttpStatusCode::isError, response -> response.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(InputStreamResource.class)
                .block();

        InputStreamResource stream2 = webClient.get()
                .uri(url)
                .retrieve()
                .onStatus(HttpStatusCode::isError, response -> response.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(InputStreamResource.class)
                .block();

        InputStreamSource byteArrayResource =  new ByteArrayResource(stream1.getInputStream().readAllBytes()) {
            @Override
            public String getFilename(){
                return "file1.jpg";
            }
        };

        InputStreamSource byteArrayResource2 =  new ByteArrayResource(stream2.getInputStream().readAllBytes()) {
            @Override
            public String getFilename(){
                return "file1.jpg";
            }
        };
        List<InputStreamSource> list1 = new ArrayList<>();
        List<InputStreamSource> list2 = new ArrayList<>();
        list1.add(byteArrayResource);
        list2.add(byteArrayResource2);
        MultiValueMap<String, InputStreamSource> map = new LinkedMultiValueMap<>();
        map.put("file1", list1);
        map.add("file2", byteArrayResource2);

        AccuracyDto response = webClient.post()
                .uri("uri")
                .header("Content-Type", "multipart/form-data")
                .body(BodyInserters.fromMultipartData(map))
                .retrieve()
                .onStatus(HttpStatusCode::isError, res -> res.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(AccuracyDto.class)
                .block();
        System.out.println(response.getConfidence_percent());
    }

    @Test
    public void requestAccuracyByBlobTest() throws IOException {
        BlobId blobId = BlobId.of("iris2024-bucket","bf978297-299a-4e9a-95ba-8d1af6a6ed9b");
        Blob blob = storage.get(blobId);

        MultiValueMap<String, Blob> map = new LinkedMultiValueMap<>();

        List<Blob> list1 = new ArrayList<>();

        list1.add(blob);

        map.put("file1", list1);
        map.put("file2", list1);

        AccuracyDto response = webClient.post()
                .uri("uri")
                .header("Content-Type", "multipart/form-data")
                .body(BodyInserters.fromMultipartData(map))
                .retrieve()
                .onStatus(HttpStatusCode::isError, res -> res.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(AccuracyDto.class)
                .block();
        System.out.println(response.getConfidence_percent());
        Assertions.assertNotNull(response.getConfidence_percent());
    }

    @Test
    public void genImgTest(){
        GenImgRequestDto requestDto = new GenImgRequestDto("여자", "흰니트랑 청바지를 입었어요.");

        String response = webClient.post()
                .uri("uri")
                .body(BodyInserters.fromValue(requestDto))
                .retrieve()
                .onStatus(HttpStatusCode::isError, res -> res.bodyToMono(String.class)
                        .flatMap(errorBody -> Mono.error(new CustomException(HttpStatus.UNAUTHORIZED, errorBody))))
                .bodyToMono(String.class)
                .block();
        System.out.println(response);
    }

    @Test
    public void deleteImgTest() {
        Post post = postRepository.findById(34L).orElse(null);

        bookmarkRepository.deleteAllByPostId(post.getId());
        imgStorageService.deletePostImage(post.getId());
        commentRepository.deleteByPostId(post.getId());
        postRepository.delete(post);
    }
}
