import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/controller__all_appointment.dart';
import 'package:simple_html_css/simple_html_css.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final Appointment appointment;

  UpcomingAppointmentCard({required this.appointment,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        child: Column(
          children: [
            _firstRow(context),
            if(appointment.statusNonNull == AppointmentStatus.ACCEPTED || appointment.statusNonNull == AppointmentStatus.REQUESTED) _cancelAppointmentButton(context),
            SizedBox(height: ScreenUtil.heightInPercent(1),)
          ],
        ),
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);

    return Container(
      height: ScreenUtil.heightInPercent(17.5),
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
                  Text(TextString.label__appointment_with, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
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
                  Text(appointment.statusNonNull.capitalizeFirst!, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cancelAppointmentButton(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(2), right: ScreenUtil.widthInPercent(2)),
      child: GFButton(
        color: Style.colorPrimary,
        type: GFButtonType.outline,
        size: ScreenUtil.heightInPercent(5),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _CancelAppointmentDialog(
              appointmentId: appointment.id,
              doctorName: appointment.doctor!.nameNonNull,
              date: '${appointment.dayLabel}, ${appointment.dateLabel}',
              time: '${appointment.timeLabel}'),
          );
        },
        child: Text(TextString.label__cancel_appointment, style: Style.defaultTextStyle(color: Style.colorPrimary),),
      ),
    );
  }
}

class _CancelAppointmentDialog extends StatelessWidget {
  final String appointmentId;

  final String doctorName;

  final String date;

  final String time;

  _CancelAppointmentDialog({required this.appointmentId, required this.doctorName, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    String info = '<center>Are you sure want to cancel appointment with <b>$doctorName</b> due on <b>$date</b> at <b>$time</b> ?</center>';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        height: ScreenUtil.heightInPercent(22.5),
        width: ScreenUtil.widthInPercent(80),
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(4)),
        child: Column(
          children: [
            RichText(text: HTML.toTextSpan(context, info, defaultTextStyle: Style.defaultTextStyle(color: Colors.black, height: 1.5),), textAlign: TextAlign.center,),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 1, child: _yesButton(context),),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Expanded(flex: 1, child: _noButton(context),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _yesButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil.heightInPercent(5),
      child: GFButton(
        color: Style.colorPrimary,
        size: ScreenUtil.heightInPercent(6),
        elevation: 0,
        onPressed: () {
          AllAppointmentController.instance.cancelAppointment(appointmentId: appointmentId);
          Navigator.pop(context);
        },
        child: Text(
          TextString.label__yes,
          style: Style.defaultTextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _noButton(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil.heightInPercent(5),
      child: GFButton(
        color: Style.colorPrimary,
        type: GFButtonType.outline,
        size: ScreenUtil.heightInPercent(6),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          TextString.label__no,
          style: Style.defaultTextStyle(
              fontWeight: FontWeight.w700, color: Style.colorPrimary),
        ),
      ),
    );
  }
}
