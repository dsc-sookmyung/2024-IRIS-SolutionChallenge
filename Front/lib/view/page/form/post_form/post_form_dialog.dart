import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/form/post_form/post_form_controller.dart';

void showPostFormDialog(dynamic controller) {
  Get.dialog(
    barrierDismissible: false,
    Dialog(child: PostFormDialog(controller: controller)),
  );
}

class PostFormDialog extends StatelessWidget {
  final PostFormController controller;

  const PostFormDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: CustomPadding.dialogInsets,
      child: FutureBuilder(
        future: controller.postFormAndCreateImg(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '실종자 정보를 기반으로 \nAI 이미지를 생성하는 중 입니다.',
                  style: CustomTextStyle.titleBold,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: CustomPadding.mediumBottom),
                Stack(alignment: AlignmentDirectional.center, children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(
                        File(controller.images.first.path),
                        height: 200,
                        fit: BoxFit.fitHeight,
                      )),
                  const CircularProgressIndicator(),
                ]),
              ],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '생성된 AI 이미지를 대표\n이미지로 사용하시겠습니까?',
                style: CustomTextStyle.titleBold,
                textAlign: TextAlign.center,
              ),
              const Padding(padding: CustomPadding.mediumBottom),
              Obx(
                () => controller.genImageResp.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          controller.genImageResp.value!.genImgUrl,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ))
                    : const SizedBox(),
              ),
              Obx(
                () => CheckboxMenuButton(
                  value: controller.isChecked.value,
                  onChanged: (value) {
                    controller.isChecked.value = value!;
                  },
                  child: const Text('대표 이미지로 사용하기'),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // AI 이미지 추가
                      controller.submitFinalPost();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    child: const Text('등록하기'),
                  )),
            ],
          );
        },
      ),
    );
  }
}
