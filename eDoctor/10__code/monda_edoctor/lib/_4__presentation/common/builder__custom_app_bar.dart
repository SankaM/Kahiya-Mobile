import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class CustomAppBarBuilder {
  static const backButtonDefault = Icon(Icons.arrow_back, color: Colors.white, size: Style.iconSize_2XL,);

  static PreferredSize build({required BuildContext context, Size? preferredSize, Icon backButtonIcon = backButtonDefault, required Text firstLineLabel, Text? secondLineLabel}) {
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
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: ScreenUtil.widthInPercent(12),
                height: ScreenUtil.heightInPercent(5),
                child: backButtonIcon,
              ),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            Padding(padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(4)), child: firstLineLabel,),
            if(secondLineLabel != null) SizedBox(height: ScreenUtil.heightInPercent(1),),
            if(secondLineLabel != null) Padding(padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(4)), child: secondLineLabel),
          ],
        ),
      ),
    );
  }

  CustomAppBarBuilder._();
}
