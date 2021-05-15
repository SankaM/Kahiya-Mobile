import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/asset.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(00),
      margin: EdgeInsets.all(00),
      child: Image.asset(
        Asset.png__background,
        fit: BoxFit.fitWidth,
        width: Get.size.width,
      ),
    );
  }
}