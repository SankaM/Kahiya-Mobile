import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';

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
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary,),
      firstLineLabel: Text(TextString.label__pay_and, style: Style.defaultTextStyle(fontSize: Style.fontSize_6XL, color: Colors.black),),
      secondLineLabel: Text(TextString.label__confirm, style: Style.defaultTextStyle(fontSize: Style.fontSize_6XL, color: Colors.black),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 30, right: 20),
      child: ListView(
        children: [
          _heroSection(context),
          _paymentMethodsSection(context),
          _cancelButton(context),
          SizedBox(height: 125,)
        ],
      ),
    );
  }

  Widget _heroSection(BuildContext context) {
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                child: Image.asset(DoctorProfileController.instance.assetImage, fit: BoxFit.fitWidth,),
              ),
            ),
            SizedBox(height: 10,),
            Text('Appointment With', style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600]!),),
            SizedBox(height: 5,),
            Text(DoctorProfileController.instance.firstLineText, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: Style.fontSize_L),),
            SizedBox(height: 15,),
            Row(
              children: [
                Icon(Icons.calendar_today_sharp, color: Style.colorPrimary, size: Style.iconSize_S,),
                SizedBox(width: 5,),
                Text('Mon | 17 May, 2021', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.watch_later, color: Style.colorPrimary, size: Style.iconSize_S,),
                SizedBox(width: 5,),
                Text('12:00 PM', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 20),
          child: Text(TextString.label__payment_methods, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        PaymentMethodOption(
          backgroundColor: Colors.blue.withOpacity(0.3),
          label: Text(
            'Pay With Paypal',
            style: Style.defaultTextStyle(color: Colors.blue[600]!, fontWeight: FontWeight.w500),),
          logo: Image.asset(Asset.png__logo__paypal, width: 25,),
        ),
        PaymentMethodOption(
          backgroundColor: Style.colorPrimary.withOpacity(0.3),
          label: Text(
            'Pay With Credit Card',
            style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
          logo: Image.asset(Asset.png__logo_cc, width: 25,),
        ),
      ],
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.outline,
          size: 50,
          onPressed: () {
            Get.back();
          },
          child: Text(TextString.label__cancel, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
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
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10, bottom: 10),
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
