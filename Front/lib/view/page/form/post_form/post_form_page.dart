import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/form/post_form/post_form_controller.dart';
import 'package:iris_flutter/view/page/form/address_form.dart';
import 'package:iris_flutter/view/page/form/basic_form.dart';
import 'package:iris_flutter/view/page/form/form_title.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';
import 'package:iris_flutter/view/page/form/text_form.dart';
import 'package:iris_flutter/view/page/form/image_carousel_form.dart';
import 'package:iris_flutter/view/page/form/time_form.dart';

class PostFormPage extends StatefulWidget {
  const PostFormPage({Key? key}) : super(key: key);

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(PostFormController());
    final postController = Get.find<PostFormController>();

    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: customAppBar(
            title: '실종자 등록',
            actions: SubmitButton(onPressed: () {
              // validate image, location
              postController.initValidation.value = false;
              if (postController.validateRequiredFields(_formKey)) {
                // 정보 등록 (저장)
                postController.submitPost(postController);
              }
            })),
        body: SingleChildScrollView(
          child: Padding(
            padding: CustomPadding.pageInsets,
            child: Column(
              children: [
                // 사진
                ImageCarouselForm(
                  title: '실종자',
                  controller: postController,
                ),
                // 실종자 이름
                TextForm(
                    textEditingController: postController.nameController,
                    title: '실종자 이름',
                    isRequired: true,
                    validatorText: '이름을 입력해주세요.',
                    hintText: '실종자 이름을 입력해주세요.',
                    maxLength: 20),

                // 성별, 만 나이
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: BasicForm(
                          title: '성별',
                          isRequired: true,
                          widget: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                genderButton(title: '여자', gender: Config.woman),
                                genderButton(title: '남자', gender: Config.man),
                              ],
                            ),
                          ),
                        )),
                    const Padding(padding: CustomPadding.regularRight),
                    Flexible(
                      flex: 1,
                      child: numberField(
                          textEditingController: postController.ageController,
                          title: '만 나이',
                          isRequired: true,
                          unitText: '세'),
                    )
                  ],
                ),
                // 키, 몸무게
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: numberField(
                            textEditingController:
                                postController.heightController,
                            title: '키',
                            isRequired: false,
                            unitText: 'cm')),
                    const Padding(padding: CustomPadding.regularRight),
                    Flexible(
                        flex: 1,
                        child: numberField(
                            textEditingController:
                                postController.weightController,
                            title: '몸무게',
                            isRequired: false,
                            unitText: 'kg')),
                  ],
                ),

                // 실종 시각
                TimeForm(title: '실종 시각', controller: postController),
                // 마지막 위치
                AddressForm(title: '마지막 위치', controller: postController),

                // 실종 당시 옷차림
                TextForm(
                  textEditingController: postController.clothesController,
                  title: '실종 당시 옷차림',
                  isRequired: true,
                  validatorText: '옷차림을 입력해주세요.',
                  hintText: '상•하의 종류와 색상을 적어주세요. (ex.노란니트, 검정바지)',
                  maxLength: 40,
                ),
                // 특이사항
                TextForm(
                    textEditingController: postController.detailsController,
                    title: '특이사항',
                    isRequired: false,
                    hintText: '실종자의 체격, 얼굴형, 특이 행동, 질병, 상세 옷차림 등을 적어주세요.',
                    maxLength: 300,
                    maxLengths: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column numberField(
      {required TextEditingController textEditingController,
      required String title,
      required bool isRequired,
      required String unitText}) {
    return Column(
      children: [
        FormTitle(title: title, isRequired: isRequired),
        Stack(children: [
          TextFormField(
            controller: textEditingController,
            maxLength: 3,
            decoration: InputDecoration(
              isDense: true,
              counterText: '',
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.outline)),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty && isRequired) {
                return '만 나이를 입력해 주세요.';
              }
              return null;
            },
          ),
          Positioned(
              top: 18,
              right: 12,
              child: Center(
                  child: Text(
                unitText,
                style: CustomTextStyle.basic
                    .copyWith(color: Theme.of(context).colorScheme.outline),
              ))),
        ]),
        const Padding(padding: CustomPadding.mediumBottom),
      ],
    );
  }

  Widget genderButton({required String title, required bool gender}) {
    Get.put(PostFormController());
    final infoFormController = Get.find<PostFormController>();

    return OutlinedButton(
      onPressed: () {
        infoFormController.gender.value = gender;
      },
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(double.infinity, 55),
          textStyle: CustomTextStyle.basic,
          foregroundColor: infoFormController.gender.value == gender
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onBackground,
          side: BorderSide(
            color: infoFormController.gender.value == gender
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      child: Text(title),
    );
  }
}
