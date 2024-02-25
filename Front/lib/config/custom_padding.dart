import 'package:flutter/cupertino.dart';

class CustomPadding {
  // <특정 위젯 여백>
  // Page 여백
  static const pageInsets = EdgeInsets.only(left: 16, right: 16, bottom: 25);
  // Dialog 여백
  static const dialogInsets = EdgeInsets.all(25);

  // <특정 방향 여백>
  // bottom
  static const slimBottom = EdgeInsets.only(bottom: 6);
  static const regularBottom = EdgeInsets.only(bottom: 12);
  static const mediumBottom = EdgeInsets.only(bottom: 18);
  static const thickBottom = EdgeInsets.only(bottom: 24);
  // right
  static const slimRight = EdgeInsets.only(right: 5);
  static const regularRight = EdgeInsets.only(right: 10);
  // top
  static const mediumTop = EdgeInsets.only(top: 18);
  static const thickTop = EdgeInsets.only(top: 24);
}
