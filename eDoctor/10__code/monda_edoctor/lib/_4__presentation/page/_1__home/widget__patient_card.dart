import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class PatientCard extends StatelessWidget {
  final String assetImage;

  final String firstLineText;

  final String secondLineText;

  final String thirdLineText;

  final String assetIcon;

  final double width;

  final double height;

  PatientCard({required this.assetImage, required this.firstLineText, required this.secondLineText, required this.thirdLineText, required this.assetIcon, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoMedicalRecordPage();
        },
        child:Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
                  height: double.infinity,
                  child: GFAvatar(
                    backgroundImage: AssetImage(assetImage),
                    shape: GFAvatarShape.square,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(firstLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                      SizedBox(height: ScreenUtil.heightInPercent(1),),
                      Text(secondLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                      Spacer(),
                      Row(
                        children: [
                          Image.asset(assetIcon, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                          SizedBox(width: ScreenUtil.widthInPercent(1.5),),
                          Text(thirdLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}