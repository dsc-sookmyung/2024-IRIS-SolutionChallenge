import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/post/image_carousel.dart';

class DetailTab extends StatefulWidget {
  const DetailTab({super.key});

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  PostController postController = Get.put(PostController());

  Future<void> _initPostData() async {
    await Get.find<PostController>().loadData(null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initPostData(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ImageCarousel(
                  images: postController.post.value.images,
                  genImage: postController.post.value.genImage,
                  genRepresent: postController.post.value.genRepresent,
                ),
                const Padding(padding: CustomPadding.regularBottom),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  postController.post.value.name,
                                  style: CustomTextStyle.titleBold,
                                ),
                              ),
                              Text(
                                convertDateString(
                                    postController.post.value.createdAt),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              )
                            ]),
                        const Padding(padding: CustomPadding.slimBottom),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: postItem(
                                  "성별",
                                  Config().getGenderText(
                                      postController.post.value.gender)),
                            ),
                            Expanded(
                              child: postItem(
                                  "만 나이", '${postController.post.value.age} 세'),
                            )
                          ],
                        ),
                        const Divider(),
                        if (postController.post.value.height != null ||
                            postController.post.value.weight != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (postController.post.value.height != null)
                                    Expanded(
                                      child: postItem("키",
                                          "${postController.post.value.height} cm"),
                                    ),
                                  if (postController.post.value.weight != null)
                                    Expanded(
                                      child: postItem("몸무게",
                                          "${postController.post.value.weight} kg"),
                                    )
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        postItem("마지막 위치", postController.post.value.address),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            postItem(
                                "실종 당시 옷차림", postController.post.value.clothes),
                            const Divider(),
                          ],
                        ),
                        if (postController.post.value.details != null &&
                            postController.post.value.details != '')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              postItem(
                                  "특이사항", postController.post.value.details),
                              const Divider(),
                            ],
                          ),
                      ]),
                ),
              ],
            ),
          );
        });
  }

  Widget postItem(String title, dynamic context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(context.toString()),
        ],
      );
}
