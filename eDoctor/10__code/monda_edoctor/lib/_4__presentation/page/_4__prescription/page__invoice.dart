
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__patient_name_section.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__add_prescription.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__invoice.dart';

class InvoicePage extends AbstractPageWithBackgroundAndContent {
  InvoicePage() : super(
    title: TextString.page_title__invoice,
    backgroundAsset: Asset.png__background04,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    InvoiceController.instance.reset();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(17.5)),
      firstLineLabel: Text(TextString.label__invoice, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary, size: Style.iconSize_2XL,),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
        width: double.infinity,
        height: ScreenUtil.heightInPercent(82.5),
        padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.white,
        ),
        child: _InvoiceForm(),
    );
  }
}

class _InvoiceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ----- Patient Name
        _PatientNameSection(),
        SizedBox(height: ScreenUtil.heightInPercent(5),),

        // ----- Drugs
        _DrugSection(),
        SizedBox(height: ScreenUtil.heightInPercent(5),),

        // ----- Treatment
        _TreatmentSection(),
        SizedBox(height: ScreenUtil.heightInPercent(3),),

        // -----
        Divider(),
        SizedBox(height: ScreenUtil.heightInPercent(3),),

        // ----- Subtotal
        _Subtotal(subtotal: 20.75),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        
        // ----- Total
        _Total(total: 20.75),
        SizedBox(height: ScreenUtil.heightInPercent(3),),

        // ----- LinkBox
        _LinkBox(url: 'http://loremipsumdolorsita'),
        SizedBox(height: ScreenUtil.heightInPercent(3),),

        // ----- Send To Patient Button
        _SendToPatientButton(),
        SizedBox(height: ScreenUtil.heightInPercent(3),),

        // -----
        SizedBox(height: ScreenUtil.heightInPercent(25),),
      ],
    );
  }
}

class _PatientNameSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(TextString.label__patients_name, style: TextStyle(color: Colors.grey[500], fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            Icon(Icons.person, color: Colors.grey[500], size: Style.iconSize_Default,),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        PatientNameSection(patientName: '${AddPrescriptionController.instance.patient!.name}', showIcon: false,),
      ],
    );
  }
}

class _DrugSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(TextString.label__drugs, style: TextStyle(color: Colors.grey[500], fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            FaIcon(FontAwesomeIcons.capsules, color: Colors.grey[500], size: Style.iconSize_Default,),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _drugItem(imageAssetName: Asset.png_drug01, drugName: 'iBuprofen', drugWeight: '250mg', drugPricePerItem: 1.25, drugCount: 2),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _drugItem(imageAssetName: Asset.png_drug02, drugName: 'Paracetamol', drugWeight: '500mg', drugPricePerItem: 1.75, drugCount: 2),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _drugItem(imageAssetName: Asset.png_drug03, drugName: 'Robitussin', drugWeight: '200mg', drugPricePerItem: 1.5, drugCount: 2),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        Row(
          children: [
            Text(TextString.label__drugs_total, style: TextStyle(color: Colors.grey[500]),),
            Spacer(),
            Text('\$ 8.75', style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
          ],
        ),
      ],
    );
  }

  Widget _drugItem({required String imageAssetName, required String drugName, required String drugWeight, required double drugPricePerItem, required int drugCount}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  width: ScreenUtil.widthInPercent(20),
                  height: ScreenUtil.widthInPercent(20),
                ),
                Positioned(
                  child: Image.asset(
                    imageAssetName,
                    width: ScreenUtil.widthInPercent(18),
                    height: ScreenUtil.widthInPercent(18),
                  ),
                  top: 5,
                  right: 5,
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Style.colorPrimary,
                    ),
                    child: Text('$drugCount', style: Style.defaultTextStyle(fontSize: Style.fontSize_S, fontWeight: FontWeight.w700),),
                  ),
                  right: 0,
                  top: 0,

                )
              ],
            ),
            SizedBox(width: ScreenUtil.widthInPercent(5),),
            Container(
              height: ScreenUtil.widthInPercent(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(drugName, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Text(drugWeight),
                  Spacer(),
                  Row(
                    children: [
                      Text(TextString.label__price, style: Style.defaultTextStyle(color: Colors.grey),),
                      SizedBox(width: ScreenUtil.widthInPercent(2),),
                      Text('\$ $drugPricePerItem x $drugCount', style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.black),),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              height: ScreenUtil.widthInPercent(20),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(ScreenUtil.widthInPercent(3)),
                child: Text('\$ ${drugPricePerItem * drugCount}', style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w700),),
                decoration: BoxDecoration(
                  color: Style.colorPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        DottedLine(direction: Axis.horizontal, lineLength: double.infinity, dashColor: Colors.grey,),
      ],
    );
  }
}

class _TreatmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(TextString.label__treatment, style: TextStyle(color: Colors.grey[500], fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            FaIcon(FontAwesomeIcons.stethoscope, color: Colors.grey[500], size: Style.iconSize_Default,),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        treatmentItem(illnessName: 'Cough', treatmentName: 'Diagnosed and Prescribed', treatmentCost: 7.0, iconData: FontAwesomeIcons.checkCircle),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        treatmentItem(illnessName: 'Fever', treatmentName: 'Diagnosed and Prescribed', treatmentCost: 5.0, iconData: FontAwesomeIcons.checkCircle),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        Row(
          children: [
            Text(TextString.label__treatment_total, style: TextStyle(color: Colors.grey[500]),),
            Spacer(),
            Text('\$ 8.75', style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
          ],
        ),
      ],
    );
  }

  Widget treatmentItem({required String illnessName, required treatmentName, required double treatmentCost, required IconData iconData}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3), vertical: ScreenUtil.heightInPercent(3)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(illnessName, style: Style.defaultTextStyle(color: Colors.black),),
          SizedBox(height: ScreenUtil.heightInPercent(1),),
          Row(
            children: [
              Text(treatmentName, style: Style.defaultTextStyle(color: Colors.grey),),
              SizedBox(width: ScreenUtil.widthInPercent(3),),
              Icon(iconData, size: Style.iconSize_XS, color: Colors.grey,),
              Spacer(),
              Text('\$ $treatmentCost', style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w700),),
            ],
          )
        ],
      ),
    );
  }
}

class _Subtotal extends StatelessWidget {
  final double subtotal;

  _Subtotal({required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(TextString.label__subtotal, style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w500),),
        Spacer(),
        Text('\$ $subtotal', style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
      ],
    );
  }
}

class _Total extends StatelessWidget {
  final double total;

  _Total({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.colorPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(ScreenUtil.widthInPercent(3)),
      child: Row(
        children: [
          Text(TextString.label__total, style: TextStyle(color: Colors.grey[700], fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500),),
          Spacer(),
          Text('\$ $total', style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w700),),
        ],
      ),
    );
  }
}

class _LinkBox extends StatelessWidget {
  final String url;

  _LinkBox({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Text(url, style: Style.defaultTextStyle(color: Colors.grey),),
          Spacer(),
          FaIcon(FontAwesomeIcons.link, color: Style.colorPrimary, size: Style.iconSize_S,),
        ]
      ),
    );
  }
}

class _SendToPatientButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusButton(
      height: ScreenUtil.heightInPercent(7),
      width: double.infinity,
      onTap: () {},
      label: TextString.label__send_to_patient,
    );
  }
}
