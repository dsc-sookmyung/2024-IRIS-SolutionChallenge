import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String combineTimeOfDayWithCurrentDate(TimeOfDay timeOfDay) {
  DateTime now = DateTime.now();
  String dateTimeString = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  ).toUtc().toIso8601String();
  return dateTimeString;
}

String convertDateString(String originalDateString) {
  // 2024-02-09T07:11:42.069Z
  // 2024-02-15T03:18:29.191338

  if (originalDateString != '') {
    DateTime dateTime = DateTime.parse(originalDateString);

    String formattedDateString =
        DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    return formattedDateString;
  } else {
    return '';
  }
}
