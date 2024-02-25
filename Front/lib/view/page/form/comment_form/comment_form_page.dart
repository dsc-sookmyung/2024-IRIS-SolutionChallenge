import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/form/comment_form/comment_form_controller.dart';
import 'package:iris_flutter/view/page/form/address_form.dart';
import 'package:iris_flutter/view/page/form/image_carousel_form.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';
import 'package:iris_flutter/view/page/form/text_form.dart';
import 'package:iris_flutter/view/page/form/time_form.dart';

class CommentFormPage extends StatefulWidget {
  const CommentFormPage({Key? key}) : super(key: key);

  @override
  State<CommentFormPage> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentFormPage> {
  @override
  void initState() {
    log('Get.arguments: ${Get.arguments}');
    Get.put(CommentFormController()).savePostData(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CommentFormController());
    final commentController = Get.find<CommentFormController>();

    return Scaffold(
      appBar: customAppBar(
          title: '제보하기',
          actions: SubmitButton(onPressed: () {
            // validate image, time, location
            commentController.initValidation.value = false;
            if (commentController.validateRequiredFields()) {
              commentController.submitComment();
            }
          })),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPadding.pageInsets,
          child: Column(
            children: [
              // 실종 정보 글 간략 정보 보여주는 Card
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          commentController.postImage.value,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const Padding(padding: CustomPadding.regularRight),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Text(
                            '${commentController.postName.value} / ${Config().getGenderText(commentController.postGender.value)} / ${commentController.postAge.value}세 / ${commentController.postAddress.value}',
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.basic),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: CustomPadding.mediumBottom),

              // 제보 사진 추가
              ImageCarouselForm(
                title: '제보',
                controller: commentController,
              ),
              // 발견 당시 시간
              TimeForm(title: '발견 당시 시간', controller: commentController),
              // 발견 당시 위치
              AddressForm(title: '발견 당시 위치', controller: commentController),
              // 발견 당시 옷차림
              TextForm(
                  textEditingController: commentController.clothesController,
                  title: '발견 당시 옷차림',
                  isRequired: false,
                  hintText: '상•하의 모양, 색상, 액세서리 등 당시 옷차림에 대해 적어주세요.',
                  maxLength: 20),
              // 발견 당시 상황
              TextForm(
                textEditingController: commentController.detailsController,
                title: '발견 당시 상황',
                isRequired: false,
                hintText: '발견 당시 실종자의 주변인, 행동, 상황 등을 상세히 적어주세요.',
                maxLength: 300,
                maxLengths: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
