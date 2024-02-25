import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/model/my_comments_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'comment_repository.g.dart';

@RestApi()
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  // 제보 댓글 작성
  @POST('/comments')
  Future postComment(@Body() FormData data);

  // 제보 댓글 List 조회
  @GET('/posts/{pid}/comments')
  Future<List<Comment>> getCommentList(@Path() int pid, @Query('filter') int filter);

//  내가 작성한 제보글 조회
  @GET('/my-comments')
  Future<List<MyCommentsResp>> getMyComments(@Query('pageNo') int pageNo, @Query('pageSize') int pageSize);
  
  // 제보 댓글 삭제
  @DELETE('/comments/{cid}')
  Future deleteComment(@Path() int cid);
}