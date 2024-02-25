import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/utils/time_diff_utils.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/controller/my_page/my_post_controller.dart';
import 'package:iris_flutter/view/page/main/delete_post_dialog.dart';

class SinglePostItem extends StatefulWidget {
  final dynamic controller;
  final ShortPost post;
  final bool? myPosts;
  final bool? bookmarkPost;

  const SinglePostItem({
    super.key,
    required this.controller,
    required this.post,
    this.myPosts,
    this.bookmarkPost,
  });

  @override
  State<SinglePostItem> createState() => _SinglePostItemState();
}

class _SinglePostItemState extends State<SinglePostItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Config.routerPost, arguments: widget.post.pid);
      },
      child: Padding(
        padding: CustomPadding.thickBottom,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.post.imgUrl,
                      height: 170,
                      width: 380,
                      fit: BoxFit.fitWidth,
                    )),
                widget.myPosts == true // 작성한 실종 정보 일때만 삭제 버튼
                    ? Positioned(
                        right: 3,
                        child: IconButton(
                            onPressed: () {
                              showDeletePostDialog(widget.post.pid, _reloadData);
                            },
                            icon: const Icon(Icons.delete_outline),
                            style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.5))))
                    : const SizedBox()
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${widget.post.name}(${Config().getGenderText(widget.post.gender)},${widget.post.age}세) / ${widget.post.address}",
                    style: CustomTextStyle.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    // 북마크 추가 or 삭제
                    if (await Get.put(BookmarkController()).postAndDeleteBookmark(
                        widget.post.bookmarked, widget.post.pid)) { // 통신 성공 시에만  화면 변경
                      setState(() {
                        widget.post.bookmarked = !widget.post.bookmarked;
                      });
                      // bookmark Post 일 때만 데이터 재로딩
                      if (widget.bookmarkPost != null && widget.bookmarkPost!) {
                        Get.put(BookmarkController()).loadData();
                      }
                    }
                  },
                  icon: Icon(widget.post.bookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const Padding(padding: CustomPadding.slimRight),
                Text(
                  getTimeDifference(widget.post.createdAt),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _reloadData() {
    Get.put(MyPostController()).loadData();
  }
}
