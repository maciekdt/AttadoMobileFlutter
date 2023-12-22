import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastifiationController {
  static void showTopNotification(
    BuildContext context,
    String title,
    ToastificationType type,
  ) {
    toastification.show(
      context: context,
      title: title,
      margin: const EdgeInsets.only(top: 55, left: 10, right: 10),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topRight,
      showProgressBar: false,
      type: type,
    );
  }
}
