import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';

class AppointmentInfo extends StatelessWidget {
  final Appointment appointment;

  AppointmentInfo({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
        padding: EdgeInsets.all(ScreenUtil.heightInPercent(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Style.colorPrimary.withOpacity(0.10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text('${DateFormat('MMM dd, yyy').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontWeight: FontWeight.w400, color: Colors.black, letterSpacing: 0.5, fontSize: Style.fontSize_Default),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('${DateFormat('EEE, hh:mm').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontWeight: FontWeight.w400, color: Colors.black, letterSpacing: 0.5, fontSize: Style.fontSize_Default),),
              ],
            ),
            Spacer(),
            Text('Appointment', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
          ],
        )
    );
  }
}
