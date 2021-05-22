import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final String backgroundAsset;

  Background({required this.backgroundAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black,
      padding: EdgeInsets.all(00),
      margin: EdgeInsets.all(00),
      child: Image.asset(
        backgroundAsset,
        fit: BoxFit.cover,
        // width: Get.size.width,
      ),
    );
  }
}