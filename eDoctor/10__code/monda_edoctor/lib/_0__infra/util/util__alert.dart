import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertUtil {
  static void showMessage(String message, {Duration? duration}) {
    if(duration == null) duration = Duration(seconds: 3);

    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(message), duration: duration,),);
  }
}
