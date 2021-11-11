import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';

class PastAppointmentCard extends StatelessWidget {
  final String assetImage;

  final String doctorName;

  final String assetIcon;

  final String status;

  final Color statusColor;

  PastAppointmentCard({required this.assetImage, required this.doctorName, required this.assetIcon, required this.status, required this.statusColor});

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
                  Text(doctorName, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_sharp, color: Style.colorPrimary, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(2),),
                      Text('Mon | 17 May, 2021', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.heightInPercent(1.5),),
                  Row(
                    children: [
                      Icon(Icons.watch_later, color: Style.colorPrimary, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(2),),
                      Text('12:00 PM', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.heightInPercent(1.5),),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(3),),
                      child: Text(status, style: Style.defaultTextStyle(color: statusColor),),
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