import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';

class ConfirmAppointmentPage extends AbstractPageWithBackgroundAndContent {
  ConfirmAppointmentPage()
      : super(
          title: TextString.page_title__confirm_appointment,
          backgroundAsset: Asset.png__background04,
          usingSafeArea: true,
          showAppBar: false,
          showFloatingActionButton: true,
          showBottomNavigationBar: true,
          selectedIndexOfBottomNavigationBar: -1,
        );

  @override
  Widget constructContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary, size: Style.iconSize_2XL),
      firstLineLabel: Text(TextString.label__confirm, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      secondLineLabel: Text(TextString.label__appointment, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      child: ListView(
        children: [
          _heroSection(context),
          _confirmAppointmentButton(context),
          _cancelButton(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _heroSection(BuildContext context) {
    var noImage = Image.asset(Asset.png__no_image_available, fit: BoxFit.fitWidth,);
    var dayLabel = DoctorProfileController.instance.vInput.selectedAppointmentOptionHour!.dayLabel;
    var dateLabel = DoctorProfileController.instance.vInput.selectedAppointmentOptionHour!.dateLabel;
    var timeLabel = DateFormat('HH:mm').format(DoctorProfileController.instance.vInput.selectedAppointmentOptionHour!.time);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        // padding: EdgeInsets.all(20),
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                child: DoctorProfileController.instance.vReference.doctor!.imageUrl == null ? noImage : Image.network(DoctorProfileController.instance.vReference.doctor!.imageUrl!, fit: BoxFit.fitWidth,),
              ),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            Text(TextString.label__appointment_with, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600]!),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            Text(DoctorProfileController.instance.vReference.doctor!.nameNonNull, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: Style.fontSize_L),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            Row(
              children: [
                Icon(Icons.calendar_today_sharp, color: Style.colorPrimary, size: Style.iconSize_Default,),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Text('$dayLabel | $dateLabel', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            Row(
              children: [
                Icon(Icons.watch_later, color: Style.colorPrimary, size: Style.iconSize_S,),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Text(timeLabel, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmAppointmentButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        width: double.infinity,
        child: GFButton(
          color: Style.colorPrimary,
          size: ScreenUtil.heightInPercent(6),
          elevation: 3,
          onPressed: () {
            DoctorProfileController.instance.generateAppointment();
          },
          child: Text(TextString.label__confirm_appointment, style: Style.defaultTextStyle(fontWeight: FontWeight.w700),),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.outline,
          size: ScreenUtil.heightInPercent(6),
          onPressed: () {
            Get.back();
          },
          child: Text(TextString.label__cancel, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
        ),
      ),
    );
  }
}
