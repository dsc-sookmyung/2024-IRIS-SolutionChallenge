import 'dart:developer';

import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/repository/comment_repository.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';

class PostController extends GetxController {
  // 이전 페이지에서 전달 받은 postId
  RxInt postId = 0.obs;

  // Rx<Post?> post = Rx<Post?>(null);
  // 하나의 실종 정보 글에 대한 정보
  Rx<Post> post = Post(
    pid: 0,
    name: "",
    gender: true,
    age: 0,
    address: "",
    latitude: 0.0,
    longitude: 0.0,
    clothes: "",
    bookmarked: false,
    images: [""],
    genImage: '',
    disappearedAt: '',
    createdAt: '',
    updatedAt: '',
    author: false,
    genRepresent: true,
  ).obs;

  // imageCarousel 에 보일 전체 images
  RxList<String> fullImages = [""].obs;

  // 해당 실종 정보 글에 달린 제보 댓글들
  RxList<Comment> commentList = <Comment>[].obs;
  RxInt currentIndex = 0.obs; // 댓글 별 이미지 슬라이드

  Rx<Comment> targetComment = Comment(
          cid: 0,
          address: '',
          latitude: 0.0,
          longitude: 0.0,
          images: [''],
          discoveredAt: '',
          createdAt: '',
          author: false)
      .obs;
  RxBool targetVisible = false.obs;

  RxBool isFilterOn = true.obs;

  void setPid(int argumentPid) {
    postId.value = argumentPid;
  }

  Future<void> loadData(int? argumentPid) async {
    // /post/{post_id}
    try {
      final dio = createDio();
      final PostRepository infoRepository = PostRepository(dio);
      final response =
          await infoRepository.getPost(argumentPid ?? postId.value);

      post.value = response;
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  Future<void> loadComments() async {
    // /post/{post_id}/comments
    int filterNum = 0;
    if (isFilterOn.value) {
      filterNum = Config.filterCriteria;
    } //

    try {
      final dio = createDio();
      final CommentRepository comtRepository = CommentRepository(dio);
      final response =
          await comtRepository.getCommentList(postId.value, filterNum);

      commentList.value = response;
      // commentList.refresh();
    } catch (error) {
      // 에러 처리s
      print('Error fetching info detail: $error');
    }
  }

  void deleteComment(int cid) async {
    final dio = createDio();
    CommentRepository commentRepository = CommentRepository(dio);
    await commentRepository.deleteComment(cid).then((resp) {
      // Error 발생 안 하면 성공
      customSnackBar(
          title: '제보 댓글 삭제', message: '제보 댓글을 삭제하였습니다.');
      loadComments();
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  void changeImgSlideIdx(int index) {
    currentIndex.value = index;
  }

  void setTargetComment(Comment data) {
    targetComment.value = data;
    targetVisible.value = true;
  }

  void unVisibleTargetComment() {
    targetVisible.value = false;
  }
}
