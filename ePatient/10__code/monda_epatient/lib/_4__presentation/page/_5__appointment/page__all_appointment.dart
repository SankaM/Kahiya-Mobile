import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/controller__all_appointment.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/widget__past_appointment_card.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/widget__upcoming_appointment_card.dart';

class AllAppointmentPage extends AbstractPageWithBackgroundAndContent {
  AllAppointmentPage() : super(
    title: TextString.page_title__all_appointment,
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
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary, size: Style.iconSize_2XL,),
      firstLineLabel: Text(TextString.label__all, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      secondLineLabel: Text(TextString.label__appointments, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      child: ListView(
        children: [
          _upcomingAppointmentSection(context),
          _pastAppointmentSection(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _upcomingAppointmentSection(BuildContext context) {
    return GetBuilder<AllAppointmentController>(builder: (_) {
      if(_.vReference.upcomingAppointmentList.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(4), right: 0, bottom: ScreenUtil.heightInPercent(2)),
              child: Text(TextString.label__upcoming_appointments, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
            ),
            Center(child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),),
          ],
        );
      }

      List<Widget> children = [];
      children.add(Padding(
        padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(4), right: 0, bottom: ScreenUtil.heightInPercent(2)),
        child: Text(TextString.label__upcoming_appointments, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
      ),);
      children.addAll(_.vReference.upcomingAppointmentList.map((appointment) => UpcomingAppointmentCard(appointment: appointment)).toList());

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children,);
    });
  }

  Widget _pastAppointmentSection(BuildContext context) {
    return GetBuilder<AllAppointmentController>(builder: (_) {
      if(_.vReference.pastAppointmentList.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(4), right: 0, bottom: ScreenUtil.heightInPercent(2)),
              child: Text(TextString.label__past_appointments, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
            ),
            Center(child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),),
          ],
        );
      }

      List<Widget> children = [];
      children.add(Padding(
        padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(4), right: 0, bottom: ScreenUtil.heightInPercent(2)),
        child: Text(TextString.label__past_appointments, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
      ),);
      children.addAll(_.vReference.pastAppointmentList.map((appointment) => PastAppointmentCard(appointment: appointment)).toList());

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children,);
    });
  }
}
