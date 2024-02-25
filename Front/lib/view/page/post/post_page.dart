import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/main/delete_post_dialog.dart';
import 'package:iris_flutter/view/page/post/detail_tab.dart';
import 'package:iris_flutter/view/page/post/comment_tab.dart';
import 'package:iris_flutter/config/config.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostController postController = Get.put(PostController());
  BookmarkController bookmrkController = Get.put(BookmarkController());

  bool isbookmarked = false;

  @override
  void initState() {
    super.initState();
    postController.setPid(Get.arguments);
    isbookmarked = postController.post.value.bookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '실종 정보',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
            // 앱 바 뒷 배경색 제거
            leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 햄버거버튼 아이콘 생성
              onPressed: () {
                if (Get.currentRoute == Config.routerPost) {
                  Get.offAllNamed(Config.routerMain);
                } else {
                  Get.back();
                }
              },
            ),
            actions: [
              IconButton(
                icon: isbookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline), // 장바구니 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  bookmrkController.postAndDeleteBookmark(
                      postController.post.value.bookmarked,
                      postController.postId.value);
                  setState(() {
                    isbookmarked = !isbookmarked;
                  });
                },
              ),
            ],
            bottom: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              labelColor: Colors.white,
              // 배경색
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).colorScheme.primaryContainer),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("상세 내용"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("제보"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const Column(
            children: [
              SizedBox(
                // 탭 바와 본문의 여백을 위해
                height: 12,
              ),
              Expanded(
                child: TabBarView(
                  children: [DetailTab(), CommentTab()],
                ),
              )
            ],
          ),
          floatingActionButton: Obx(() => postController.post.value.author
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // 발견 완료
                    // dialog로 한 번 더 묻고 -> 신고글 삭제
                    showDeletePostDialog(
                        postController.postId.value, moveToMain);
                  },
                  backgroundColor: Colors.red,
                  label: const Text('신고 해제하기'),
                  icon: const Icon(Icons.highlight_off),
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    // log('infoController.missingInfo.value: ${postController.post.value.pid}');
                    Get.toNamed(Config.routerCommentForm,
                        arguments: postController.post.value);
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                  label: const Text('제보하기'),
                  icon: const Icon(Icons.report_gmailerrorred),
                ))),
    );
  }

  void moveToMain() {
    Get.offAllNamed(Config.routerMain);
  }
}
