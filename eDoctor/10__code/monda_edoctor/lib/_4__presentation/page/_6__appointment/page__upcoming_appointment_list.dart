
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_6__appointment/controller__upcoming_appointment_list.dart';

class UpcomingAppointmentListPage extends AbstractPageWithBackgroundAndContent {
  UpcomingAppointmentListPage() : super(
    title: 'Appointment List',
    backgroundAsset: Asset.png__background03,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: 0,
  );

  @override
  Widget constructContent(BuildContext context) {
    UpcomingAppointmentListController.instance.retrieveData();

    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _contentCustomAppBar(context),
          body: _contentBody(context),
        ),
        GetBuilder<UpcomingAppointmentListController>(
          builder: (c) {
            return Visibility(
              child: ProgressIndicatorOverlay(text: 'Retrieving Appointment List'),
              visible: c.progressDialogShow,
            );
          },
        ),
      ],
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    String firstLineLabel = 'Upcoming';

    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(22.5)),
      firstLineLabel: Text('$firstLineLabel', style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w500),),
      secondLineLabel: Text('Appointment', style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL)),
    );
  }

  Widget _contentBody(BuildContext context) {
    return GetBuilder<UpcomingAppointmentListController>(builder: (_) {
      if(_.appointmentList == null || _.appointmentList!.length == 0) {
        return Center(child: Text('No appointment'));
      } else {
        List<Widget> children = [];
        children.add(SizedBox(height: ScreenUtil.heightInPercent(2),));
        children.addAll(_.appointmentList!.map((e) => _AppointmentItem(appointment: e,)).toList());
        children.add(SizedBox(height: ScreenUtil.heightInPercent(20),));

        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Style.colorPrimary.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: ListView(children: children),
        );
      }
    });
  }
}

class _AppointmentItem extends StatelessWidget {
  final Appointment appointment;

  _AppointmentItem({required this.appointment,});

  @override
  Widget build(BuildContext context) {
    Color cardColor = appointment.status == 'ACCEPTED' ? Colors.yellow.shade50 : Colors.white;

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      height: ScreenUtil.heightInPercent(15),
      child: InkWell(
        onTap: () {
          // REQUESTED || DECLINED
          if(appointment.status == AppointmentStatus.REQUESTED || appointment.status == AppointmentStatus.DECLINED) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _upcomingAppointmentActionDialog(context);
              },
            );
          }

          // ACCEPTED
          if(appointment.status == AppointmentStatus.ACCEPTED) {
            RouteNavigator.gotoMedicalRecordPage(patientId: appointment.patient!.id, appointment: appointment);
          }

          // PRESCRIBED
          if(appointment.status == AppointmentStatus.PRESCRIBED && appointment.prescriptionId != null) {
            RouteNavigator.gotoInvoiceDetailPage(prescriptionId: appointment.prescriptionId!);
          }
        },
        child: Card(
          elevation: 5,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(2), horizontal: ScreenUtil.widthInPercent(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${DateFormat('MMM dd').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontSize: Style.fontSize_L, fontWeight: FontWeight.w600, color: Style.colorPrimary),),
                    SizedBox(height: ScreenUtil.heightInPercent(1),),
                    Text('${DateFormat('yyy').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontSize: Style.fontSize_S, fontWeight: FontWeight.w400, color: Style.colorPrimary),),
                    Spacer(),
                    Text('${DateFormat('EEE').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontSize: Style.fontSize_L, fontWeight: FontWeight.w600, color: Style.colorPrimary),),
                  ],
                ),
                SizedBox(width: ScreenUtil.widthInPercent(4),),
                Container(
                  height: ScreenUtil.heightInPercent(10),
                  width: 1,
                  color: Colors.grey[200],
                ),
                SizedBox(width: ScreenUtil.widthInPercent(4),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${appointment.patient!.name}', style: Style.defaultTextStyle(fontSize: Style.fontSize_L, fontWeight: FontWeight.w500, color: Colors.grey[600]!),),
                    SizedBox(height: ScreenUtil.heightInPercent(1),),
                    Text('${DateFormat('hh:mm').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(fontSize: Style.fontSize_S, fontWeight: FontWeight.w400, color: Colors.grey[600]!),),
                    Spacer(),
                    Text('${StringUtil.capitalize(appointment.status)}', style: Style.defaultTextStyle(fontSize: Style.fontSize_Default, fontWeight: FontWeight.w400, color: Colors.grey[600]!),),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _upcomingAppointmentActionDialog(BuildContext context) {
    // set up the buttons
    Widget confirmButton = TextButton(
      child: Text("Accept"),
      onPressed:  () {
        UpcomingAppointmentListController.instance.acceptAppointment(appointment);
      },
    );

    Widget declineButton = TextButton(
      child: Text("Decline"),
      onPressed:  () {
        UpcomingAppointmentListController.instance.declineAppointment(appointment);
      },
    );

    // set up the AlertDialog
    AlertDialog actionDialog = AlertDialog(
      title: Text("${appointment.patient!.name}", style: Style.defaultTextStyle(color: Colors.black, fontSize: Style.fontSize_L, fontWeight: FontWeight.w500),),
      content: Container(
        height: ScreenUtil.heightInPercent(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Schedule at ${DateFormat('EEE MMM dd, yyy hh:mm').format(appointment.appointmentDate!)}', style: Style.defaultTextStyle(color: Colors.black, fontSize: Style.fontSize_Default, height: 1.5),),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            Text('Do you want to accept the appointment?', style: Style.defaultTextStyle(color: Colors.black, fontSize: Style.fontSize_Default, height: 1.5),),
          ],
        )
      ),
      actions: [
        confirmButton,
        declineButton,
      ],
    );

    return actionDialog;
  }
}
