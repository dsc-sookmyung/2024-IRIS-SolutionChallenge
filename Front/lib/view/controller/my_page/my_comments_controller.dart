import 'dart:developer';

import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/my_comments_response.dart';
import 'package:iris_flutter/repository/comment_repository.dart';

class MyCommentsController extends GetxController {
  RxList<MyCommentsResp> commentList = <MyCommentsResp>[].obs;
  RxInt currentIndex = 0.obs;

  Future<void> loadData() async {
    final dio = createDio();
    CommentRepository commentRepository = CommentRepository(dio);
    await commentRepository
        .getMyComments(0, 6)
        .then((resp) {
          commentList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  void changeImgSlideIdx(int index) {
    currentIndex.value = index;
  }
}
