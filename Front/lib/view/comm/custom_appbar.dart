import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar({required String title, Widget? actions}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
    actions: [
      actions ?? const SizedBox(),
    ],
  );
}