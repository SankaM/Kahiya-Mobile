import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';

class NotificationItem extends StatelessWidget {
  final String doctorName;

  final String status;

  final String dateTime;

  final String fuzzyDateTime;

  final String doctorImage;

  NotificationItem({required this.doctorName, required this.status, required this.dateTime, required this.fuzzyDateTime, required this.doctorImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(3), bottom: ScreenUtil.heightInPercent(2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorName, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text(status, style: Style.defaultTextStyle(color: Colors.black),),
                SizedBox(height: ScreenUtil.heightInPercent(0.75),),
                Text(dateTime, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S),),
              ]
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(fuzzyDateTime, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Container(
                    child: GFAvatar(
                      backgroundImage: AssetImage(doctorImage),
                      shape: GFAvatarShape.square,
                      size: ScreenUtil.heightInPercent(3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}