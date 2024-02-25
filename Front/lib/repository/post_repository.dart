import 'package:iris_flutter/model/gen_image_resp.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_repository.g.dart';

@RestApi()
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  // 실종 정보 List 조회
  @GET('/posts')
  Future<List<ShortPost>> getPostList(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('for') String? purpose,
    @Query('pageNo') int? pageNo,
    @Query('pageSize') int? pageSize,
  );

  // 실종 정보 작성
  @POST('/posts')
  Future<GenImageResp> postPost(@Body() FormData data);

  // 실종 정보 작성 - 생성 이미지 대표 설정
  @POST('/posts/{pid}/set-representative')
  Future<Post> setRepresentative(@Path() int pid, @Query('gen') bool gen);

  // 실종 정보 조회
  @GET('/posts/{id}')
  Future<Post> getPost(@Path() int id);


  // 실종 정보 삭제
  @DELETE('/posts/{id}')
  Future deletePost(@Path() int id);
}
