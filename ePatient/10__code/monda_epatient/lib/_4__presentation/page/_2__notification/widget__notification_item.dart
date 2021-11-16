import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationItem extends StatelessWidget {
  final Appointment appointment;

  late final String doctorName;

  late final String status;

  late final String dateTime;

  late final String fuzzyDateTime;

  NotificationItem({required this.appointment,});

  @override
  Widget build(BuildContext context) {
    doctorName = appointment.doctor!.nameNonNull;
    status = appointment.statusNonNull.capitalizeFirst!;
    dateTime = appointment.dateLabel + ' | ' + appointment.dateLabel + ' | ' + appointment.timeLabel;
    fuzzyDateTime = appointment.updatedDate != null ? timeago.format(appointment.updatedDate!) : '';
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);

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
            flex: 3,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(fuzzyDateTime, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Container(
                    child: GFAvatar(
                      backgroundImage: appointment.doctor!.imageUrl == null ? noImage : NetworkImage(appointment.doctor!.imageUrl!),
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