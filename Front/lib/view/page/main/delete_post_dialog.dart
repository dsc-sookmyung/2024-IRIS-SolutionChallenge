import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/my_page/my_post_controller.dart';

void showDeletePostDialog(int pid, Function funcAfterDelete) {
  Get.dialog(Dialog(
      child:  DeletePostDialog(
    pid: pid,
    funcAfterDelete: funcAfterDelete,
  )));
}

class DeletePostDialog extends StatelessWidget {
  final int pid;
  final Function funcAfterDelete;
  const DeletePostDialog(
      {super.key, required this.pid, required this.funcAfterDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.dialogInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '실종 정보 삭제',
            style: CustomTextStyle.titleBold
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const Padding(padding: CustomPadding.regularBottom),
          const Text('정말 실종 정보를 삭제하시겠습니까?'),
          const Padding(padding: CustomPadding.mediumBottom),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('닫기')),
              ElevatedButton(
                onPressed: () {
                  Get.put(MyPostController())
                      .deletePost(pid, context, funcAfterDelete);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onErrorContainer),
                child: const Text('삭제'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
