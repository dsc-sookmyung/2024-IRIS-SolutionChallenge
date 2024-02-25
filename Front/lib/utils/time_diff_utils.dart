import 'package:iris_flutter/utils/conversion_utils.dart';

String getTimeDifference(String createdAt) {
  // 현재는 무조건 createdAt 사용

  // createdAt을 DateTime으로 파싱
  DateTime givenTime = DateTime.parse(createdAt);

  DateTime now = DateTime.now();
  Duration difference = now.difference(givenTime);

  // 차이를 분 단위로 계산
  int minutesDifference = difference.inMinutes;

  if (minutesDifference < 1) {
    // 차이 1분 이내
    return '방금 전';
  } else if (minutesDifference < 60) {
    // 차이 60분 이내
    return '$minutesDifference분 전';
  } else {
    int hoursDifference = difference.inHours;

    // 차이가 24시간을 넘어가는 경우
    if (hoursDifference >= 24) {
      return convertDateString(createdAt);
    }

    // 차이 24시간 이내
    return '$hoursDifference시간 전';
  }
}
