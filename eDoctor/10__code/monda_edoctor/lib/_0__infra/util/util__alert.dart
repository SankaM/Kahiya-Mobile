import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertUtil {
  static void showMessage(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(message),),);
  }
}
