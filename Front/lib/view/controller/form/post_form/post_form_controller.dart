import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/gen_image_resp.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/post_form/post_form_dialog.dart';
import 'package:dio/dio.dart' as dio_package;

class PostFormController {
  RxList<XFile> images = <XFile>[].obs;
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);

  // Rx<Duration?> selectedTime = Rx<Duration?>(null);
  RxBool isChecked = true.obs;

  // validate
  RxBool initValidation = true.obs;

  TextEditingController nameController = TextEditingController();
  RxBool gender = Config.woman.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Rx<String?> address = Rx<String?>(null);
  Rx<double?> latitude = Rx<double?>(null);
  Rx<double?> longitude = Rx<double?>(null);
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  Rx<GenImageResp?> genImageResp = Rx<GenImageResp?>(null);

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker
        .pickMultiImage(
      maxHeight: 500,
      imageQuality: 30,
    )
        .then((value) {
      if (images.length + value.length > Config.maxImagesLength) {
        customErrorSnackBar(
            title: '이미지 최대 선택 초과', message: '이미지는 최대 3개 입력할 수 있습니다.');
      } else {
        images += value;
      }
    }).catchError((error) {
      log('pickImage error: $error');
    });
  }

  bool validateRequiredFields(GlobalKey<FormState> formKey) {
    // 필수 값: images, name, gender, age, disappearedAt, address
    // * gender는 기본 값이 정해져 있음
    // * form Key validation 방식으로 name, age 검증함
    // * images, disappearedAt, address null 여부 검증

    return formKey.currentState!.validate() &&
        images.isNotEmpty &&
        timeOfDay.value != null &&
        address.value != null;
  }

  Future<void> submitPost(dynamic controller) async {
    showPostFormDialog(controller);
  }

  Future<void> postFormAndCreateImg() async {
    // // request body FormData 생성
    final formData = dio_package.FormData.fromMap({
      'name': nameController.text,
      'gender': gender.value,
      'age': ageController.text,
      'height': heightController.text, // * nullable 여부
      'weight': weightController.text,
      'address': address.value,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'disappearedAt': combineTimeOfDayWithCurrentDate(timeOfDay.value!),
      'clothes': clothesController.text,
      'details': detailsController.text.isEmpty ? null : detailsController.text,
    });
    // images 추가
    for (int i = 0; i < images.length; i++) {
      formData.files.add(MapEntry(
        'images',
        await dio_package.MultipartFile.fromFile(images[i].path),
      ));
    }

    final dio = createDio();
    dio.options.contentType = 'multipart/form-data';

    PostRepository postRepository = PostRepository(dio);
    await postRepository.postPost(formData).then((resp) {
      genImageResp.value = resp;
    }).catchError((err) {
      log('[catchError] $err');
    });
  }

  void submitFinalPost() async {
    await setRepresentative();
  }

  Future setRepresentative() async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .setRepresentative(genImageResp.value!.pid, isChecked.value)
        .then((resp) {
      log('성공: ${resp}');
      // get navigation, snackBar
      customSnackBar(title: '실종 정보 등록', message: '실종 정보 등록이 완료되었습니다.');
      Get.offAllNamed(Config.routerPost, arguments: genImageResp.value?.pid);
    }).catchError((err) {
      log('[catchError] $err');
      // 현재는 이 과정에서 Error 발생하면 genImageResp = true로 글 등록됨
      customErrorSnackBar(
          title: '대표 이미지 지정 여부 저장 실패', message: '실종 정보는 정상적으로 등록됩니다.');
      Get.offAllNamed(Config.routerPost, arguments: genImageResp.value?.pid);
    });
  }
}
