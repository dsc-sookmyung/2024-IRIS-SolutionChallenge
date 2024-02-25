import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/page/main/single_post_item.dart';

class BookmarkPost extends StatefulWidget {
  const BookmarkPost({super.key});

  @override
  State<BookmarkPost> createState() => _BookmarkPostState();
}

class _BookmarkPostState extends State<BookmarkPost> {
  final bookmarkController = Get.put(BookmarkController());

  @override
  void initState() {
    bookmarkController.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "북마크한 실종 정보"),
        body: Obx(
          () => bookmarkController.shortPostList.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    itemCount: bookmarkController.shortPostList.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return SinglePostItem(
                          controller: bookmarkController,
                          post: bookmarkController.shortPostList[idx],
                      bookmarkPost: true,);
                    }),
              )
              : const Center(
                  child: Text("북마크한 실종 정보가 없습니다."),
                ),
        ));
  }
}
