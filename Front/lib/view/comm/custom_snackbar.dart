import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({
  required String title,
  required String message,
}) {
  Get.snackbar(
    title,
    message,
    icon: const Icon(Icons.check),
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xffffda66).withOpacity(0.7), //tertiaryContainer
  );
}

void customErrorSnackBar({
  required String title,
  required String message,
}) {
  Get.snackbar(
    title,
    message,
    icon: const Icon(Icons.error_outline),
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xffff8d7a).withOpacity(0.7), //onErrorContainer
  );
}