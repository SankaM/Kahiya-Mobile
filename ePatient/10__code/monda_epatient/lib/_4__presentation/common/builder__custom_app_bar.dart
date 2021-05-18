import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarBuilder {
  static const backButtonDefault = Icon(Icons.arrow_back, color: Colors.white,);

  static PreferredSize build({required BuildContext context, Size? preferredSize, Icon backButtonIcon = backButtonDefault, required Text firstLineLabel, Text? secondLineLabel,}) {
    if(preferredSize == null) preferredSize = Size.fromHeight(Get.size.height * 0.25);

    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: backButtonIcon,
            ),
            SizedBox(height: 40,),
            firstLineLabel,
            if(secondLineLabel != null) SizedBox(height: 10,),
            if(secondLineLabel != null) secondLineLabel
          ],
        ),
      ),
    );
  }
}
