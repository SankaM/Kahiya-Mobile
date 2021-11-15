import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';
import 'package:monda_epatient/config.dart';

class PayAndConfirmPage extends AbstractPageWithBackgroundAndContent {
  PayAndConfirmPage() : super(
    title: TextString.page_title__pay_and_confirm,
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
      firstLineLabel: Text(TextString.label__pay_and, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      secondLineLabel: Text(TextString.label__confirm, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      showBackButton: false,
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), right: ScreenUtil.widthInPercent(8)),
      child: ListView(
        children: [
          _heroSection(context),
          SizedBox(height: ScreenUtil.heightInPercent(1),),
          _paymentInformation(context),
          _payNowButton(context),
          _payLaterButton(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _heroSection(BuildContext context) {
    var noImage = Image.asset(Asset.png__no_image_available);
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
            SizedBox(height: 10,),
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

  Widget _paymentInformation(BuildContext context) {
    return GetBuilder<DoctorProfileController>(builder: (_) {
      if (_.vReference.generatedAppointment == null) {
        return SizedBox();
      }

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(2), right: 0, bottom: ScreenUtil.heightInPercent(2)),
                child: Text(TextString.label__payment_information, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
              ),
              Text('${_.vReference.generatedAppointment!.payment!.orderNumber}', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w700, fontSize: Style.fontSize_L),),
              SizedBox(height: ScreenUtil.heightInPercent(2),),
              Text('${TextString.label__amount}: ${Config.PAYHERE__CURRENCY} ${_.vReference.generatedAppointment!.payment!.amount}', style: Style.defaultTextStyle(color: Colors.black),),
              SizedBox(height: ScreenUtil.heightInPercent(2),),
              Text('Payment for doctor ${_.vReference.generatedAppointment!.doctor!.nameNonNull} for appointment ${_.vReference.generatedAppointment!.dateLabel} ${_.vReference.generatedAppointment!.timeLabel}', style: Style.defaultTextStyle(height: 1.25, color: Colors.black),),
            ],
          ),
        ),
      );
    });
  }

  // Widget _paymentMethodsSection(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 0, top: ScreenUtil.heightInPercent(4), right: 0, bottom: ScreenUtil.heightInPercent(2)),
  //         child: Text(TextString.label__payment_methods, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
  //       ),
  //       PaymentMethodOption(
  //         backgroundColor: Colors.blue.withOpacity(0.3),
  //         label: Text(
  //           TextString.label__pay_with_paypal,
  //           style: Style.defaultTextStyle(color: Colors.blue[600]!, fontWeight: FontWeight.w500),),
  //         logo: Image.asset(Asset.png__logo__paypal, width: ScreenUtil.widthInPercent(5),),
  //       ),
  //       PaymentMethodOption(
  //         backgroundColor: Style.colorPrimary.withOpacity(0.3),
  //         label: Text(
  //           TextString.label__pay_with_credit_card,
  //           style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
  //         logo: Image.asset(Asset.png__logo_cc, width: ScreenUtil.widthInPercent(5),),
  //       ),
  //     ],
  //   );
  // }

  Widget _payNowButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.solid,
          size: ScreenUtil.heightInPercent(6),
          onPressed: () {
            DoctorProfileController.instance.requestPayment();
          },
          child: Text(TextString.label__pay_now, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Colors.white),),
        ),
      ),
    );
  }

  Widget _payLaterButton(BuildContext context) {
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
            RouteNavigator.gotoHomePage();
          },
          child: Text(TextString.label__pay_later, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
        ),
      ),
    );
  }
}

class PaymentMethodOption extends StatelessWidget {
  final Color backgroundColor;

  final Widget label;

  final Widget logo;

  PaymentMethodOption({required this.backgroundColor, required this.label, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: Row(
        children: [
          label,
          Spacer(),
          logo
        ],
      ),
    );
  }
}
