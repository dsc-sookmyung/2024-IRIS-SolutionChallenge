import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';

class MapService {
  // API, Package 에서 가져온 Map 관련 기본 기능 (가공은 Map Controller 에서)

  static Future<Position> determinePosition() async {
    // 현재 위치 받아오기 (서비스, 권한 확인) - Gelocater Package
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getAddrFromLatlng(double lat, double lng) async {
    // Revise Geocoding (convert latLng to Address) - Google Map API
    try {
      String googleMapApiKey = HiddenConfig.googleMapApiKey;
      const String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
      String url = '$baseUrl?latlng=$lat,$lng&key=$googleMapApiKey&language=ko';

      final Dio dio = Dio();
      final response = await dio.get(url);
      if (response.data['status'] == "OK") {
        log('행정 주소 Address: ${response.data['results'][0]['formatted_address']}');
        return response.data['results'][0]['formatted_address'];
      } else {
        if (response.data['status'] == 'ZERO_RESULTS') {
          customErrorSnackBar(title: '반환된 주소 없음', message: '근처 위치로 다시 시도 해주세요.');
        } else {
          customErrorSnackBar(title: 'ERROR CODE: ${response.data['status']}', message: '오류가 지속되면, 관리자에게 문의하세요.');
        }
        throw Exception('Status Exception: ${response.data['status']}');
      }
    } catch (error) {
      log('Error [$error] (getAddrFromLatlng)');
      return '';
    }
  }
}