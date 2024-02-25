import 'dart:developer';

import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/bookmark_repository.dart';
import 'package:iris_flutter/repository/post_repository.dart';

class BookmarkController {
  RxList<ShortPost> shortPostList = <ShortPost>[].obs;

  Future<void> loadData() async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .getPostList(0, 0, 'BOOKMARKED', 0, 6)
        .then((resp) {
          shortPostList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  // 북마크 추가 or 삭제
  Future postAndDeleteBookmark(bool bookmarked, int pid) async {
    if (bookmarked) {
      // true-> false: 삭제
      return deleteBookmark(pid);
    } else {
      // false -> true: 추가
      return postBookmark(pid);
    }
  }

  // 북마크 추가
  Future<bool> postBookmark(int postId) async {
    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.postBookmark(postId).then((resp) {
      // Error 발생 안 하면 성공 (true)
      return true;
    }).catchError((error) {
      log('[catchError]: $error');
      return false;
    });
    return true;
  }

  // 북마크 삭제
  Future<bool> deleteBookmark(int postId) async {
    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.deleteBookmark(postId).then((resp) {
      // Error 발생 안 하면 성공 (true)
      return true;
    }).catchError((error) {
      log('[catchError]: $error');
      return false;
    });
    return true;
  }
}
