import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class MainController {
  RxList<ShortPost> shortPostList = <ShortPost>[].obs;
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<String?> shortAddress = Rx<String?>(null);

  Future getPositionAndPostList() async {
    await getCurrentPosition();
    getShortAddress(initPosition.value!);
    await loadPostList(initPosition.value!.latitude, initPosition.value!.longitude);
  }

  // 현 위치 얻어오기
  Future getCurrentPosition() async {
    initPosition.value = await MapService.determinePosition();
  }

  // 가공된 (행정) 주소 받아오기
  void getShortAddress(Position currentPosition) async {
    // 전체 (행정) 주소 fullAddress
    final fullAddress = await MapService.getAddrFromLatlng(
        currentPosition.latitude, currentPosition.longitude);
    // 가공
    final fullAddressList = fullAddress.split(' ');
    shortAddress.value = '${fullAddressList[1]} ${fullAddressList[2]}';
  }

  Future loadPostList(double latitude, double longitude) async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .getPostList(latitude, longitude, 'ALL', 0, 0)
        .then((resp) {
      shortPostList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }
}
