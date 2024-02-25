import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'bookmark_repository.g.dart';

@RestApi()
abstract class BookmarkRepository {
  factory BookmarkRepository(Dio dio, {String baseUrl}) = _BookmarkRepository;
  
  @POST('/bookmarks/{pid}')
  Future postBookmark(@Path() int pid);

  @DELETE('/bookmarks/{pid}')
  Future deleteBookmark(@Path() int pid);
}