import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';

class CustomAppBarBuilder {
  static const backButtonDefault = Icon(Icons.arrow_back, color: Colors.white,);

  static PreferredSize build({required BuildContext context, Size? preferredSize, Icon backButtonIcon = backButtonDefault, required Text firstLineLabel, Text? secondLineLabel,}) {
    if(preferredSize == null) preferredSize = Size.fromHeight(ScreenUtil.heightInPercent(20));

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil.widthInPercent(5.5), ScreenUtil.heightInPercent(5), ScreenUtil.widthInPercent(5.5), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: backButtonIcon,
            ),
            SizedBox(height: ScreenUtil.heightInPercent(4),),
            firstLineLabel,
            if(secondLineLabel != null) SizedBox(height: ScreenUtil.heightInPercent(1),),
            if(secondLineLabel != null) secondLineLabel
          ],
        ),
      ),
    );
  }
}
