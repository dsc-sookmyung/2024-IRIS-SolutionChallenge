import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/my_page/my_post_controller.dart';
import 'package:iris_flutter/view/page/main/single_post_item.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final postController = Get.put(MyPostController());
  @override
  void initState() {
    postController.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "작성한 실종 정보"),
        body: SafeArea(
          child: Obx(
            () => postController.postList.isNotEmpty
                ? Padding(
                    padding: CustomPadding.pageInsets,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 180,
                            child: ListView.builder(
                                itemCount: postController.postList.length,
                                itemBuilder: (BuildContext context, int idx) {
                                  return SinglePostItem(
                                      controller: postController,
                                      post: postController.postList[idx],
                                  myPosts: true,);
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text("작성한 실종 정보가 없습니다."),
                  ),
          ),
        ));
  }
}
