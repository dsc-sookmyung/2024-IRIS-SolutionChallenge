import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/form/comment_form/comment_form_controller.dart';

void showCommentFormDialog() {
  Get.dialog(
      barrierDismissible: false,
      const Dialog(
        child: CommentFormDialog(),
      ));
}

class CommentFormDialog extends StatelessWidget {
  const CommentFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.dialogInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '제보 사진의 일치율을 판별 중 입니다.',
            style: CustomTextStyle.titleBold,
            textAlign: TextAlign.center,
          ),
          const Padding(padding: CustomPadding.mediumBottom),
          Stack(alignment: AlignmentDirectional.center, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  File(Get.put(CommentFormController()).images.first.path),
                  height: 200,
                  fit: BoxFit.fitHeight,
                )),
            const CircularProgressIndicator(),
          ]),
          const Padding(padding: CustomPadding.regularBottom),
          const Text(
            '일치율 판별이 완료되면\n제보 댓글이 등록됩니다.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
