import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_1__model/appointment.dart';

class PastAppointmentCard extends StatelessWidget {
  final Appointment appointment;

  PastAppointmentCard({required this.appointment,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        child: _firstRow(context),
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);
    Color statusColor = appointment.status == AppointmentStatus.PRESCRIBED ? Style.colorPrimary : Colors.grey;

    return Container(
      height: ScreenUtil.heightInPercent(17),
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
                backgroundImage: appointment.doctor!.imageUrl == null ? noImage : NetworkImage(appointment.doctor!.imageUrl!),
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
                  Text(appointment.doctor!.nameNonNull, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_sharp, color: Style.colorPrimary, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(2),),
                      Text('${appointment.dayLabel} | ${appointment.dateLabel}', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.heightInPercent(1.5),),
                  Row(
                    children: [
                      Icon(Icons.watch_later, color: Style.colorPrimary, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(2),),
                      Text('${appointment.timeLabel}', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.heightInPercent(1.5),),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(3),),
                      child: Text(appointment.status!.capitalizeFirst!, style: Style.defaultTextStyle(color: statusColor),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}