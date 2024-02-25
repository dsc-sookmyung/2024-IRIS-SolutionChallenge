import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';

class MapItem extends StatefulWidget {
  const MapItem({super.key});

  @override
  State<MapItem> createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  PostController postController = Get.find<PostController>();

  late LatLng missingSpot;

  @override
  void initState() {
    super.initState();
    missingSpot = LatLng(postController.post.value.latitude,
        postController.post.value.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
        },
        initialCameraPosition:
            CameraPosition(target: missingSpot, zoom: Config.initZoom),
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        // min max zoom 제한
        minMaxZoomPreference:
            MinMaxZoomPreference(Config.minZoom, Config.maxZoom),
        // 기울기 제스처 false
        tiltGesturesEnabled: false,
        // 현재 위치 표시 버튼 true
        myLocationButtonEnabled: true,
        // 현재 위치 표시 true
        myLocationEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId('missing spot'),
              position: missingSpot,
              icon:
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(
                title: "실종 위치",
                snippet: postController.post.value.address,
              )),
          ...postController.commentList
              .map((comment) => Marker(
                  markerId: MarkerId(comment.cid.toString()),
                  position: LatLng(comment.latitude, comment.longitude),
                  onTap: () {
                    postController.setTargetComment(comment);
                  }))
              .toSet()
        },
      ),
    );
  }

  // Future<void> getLocationUpdates() async {
  //   // 사용자의 위치에 맞게
  //   bool serviceEnabled;
  //   PermissionStatus permissionsGranted;
  //
  //   // 사용자가 위치 사용을 허락했으면
  //   serviceEnabled = await _locationController.serviceEnabled();
  //   if (serviceEnabled) {
  //     serviceEnabled = await _locationController.requestService();
  //   } else {
  //     return;
  //   }
  //
  //   permissionsGranted = await _locationController.hasPermission();
  //   if (permissionsGranted == PermissionStatus.denied) {
  //     permissionsGranted = await _locationController.requestPermission();
  //
  //     if (permissionsGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationController.onLocationChanged
  //       .listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       setState(() {
  //         _currentP =
  //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //       });
  //       print(_currentP);
  //     }
  //   });
  // }
}
