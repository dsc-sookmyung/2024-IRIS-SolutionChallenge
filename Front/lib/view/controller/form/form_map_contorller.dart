import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class FormMapController {
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<LatLng?> selectedPosition = Rx<LatLng?>(null);
  Rx<String?> address = Rx<String?>(null);

  void setInitialPosition() async {
    // 초기 현 위치 설정
    initPosition.value = await MapService.determinePosition();
  }

  void getAddressForSelectedPosition(LatLng loc) async {
    // reverse geocoding process
    final result = await MapService.getAddrFromLatlng(
        loc.latitude, loc.longitude);
    if (result.isNotEmpty) {
      address.value = result;
      selectedPosition.value = loc;
    }
  }
}