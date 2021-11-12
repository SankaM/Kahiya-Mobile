import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_1__model/dosage.dart';
import 'package:monda_epatient/_1__model/prescription.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_3__medical_history/controller__medical_history.dart';

class MedicalHistoryPage extends AbstractPageWithBackgroundAndContent {
  MedicalHistoryPage() : super(
    title: TextString.page_title__medical_history,
    backgroundAsset: Asset.png__background03,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: 1,
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
      firstLineLabel: Text(TextString.label__my_medical, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w500),),
      secondLineLabel: Text(TextString.label__record, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL)),
    );
  }

  Widget _contentBody(BuildContext context) {
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
      child: ListView(
        children: [
          _firstRowProfile(context),
          _medicalDescriptionSection(context),
          _currentPrescriptionSection(context),
          _pastDiagnosticSection(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _firstRowProfile(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(builder: (_) {
      if(_.vReference.patient == null) {
        return SizedBox();
      }

      ImageProvider noImage = AssetImage(Asset.png__no_image_available);

      return Container(
        height: ScreenUtil.heightInPercent(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(ScreenUtil.widthInPercent(1.5)),
              height: ScreenUtil.heightInPercent(10),
              width: ScreenUtil.heightInPercent(10),
              child: GFAvatar(
                backgroundImage: _.vReference.patient!.imageUrl == null ? noImage : NetworkImage(_.vReference.patient!.imageUrl!),
                shape: GFAvatarShape.square,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1), ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${_.vReference.patient!.name}', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
                  Text('${_.vReference.patient!.genderNonNull.capitalizeFirst}, ${_.vReference.patient!.age} ${TextString.label__years}', style: Style.defaultTextStyle(color: Colors.grey[500]!),),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _medicalDescriptionSection(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(builder: (_) {
      if(_.vReference.patient == null) {
        return SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
            child: Text(TextString.label__medical_description, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), right: ScreenUtil.widthInPercent(1)),
            child: Text(_.vReference.patient!.healthProfileNonNull, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5), textAlign: TextAlign.justify,),
          )
        ],
      );
    });
  }

  Widget _currentPrescriptionSection(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(builder: (_) {
      if(_.vReference.currentPrescriptionList.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
              child: Text(TextString.label__current_prescriptions, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
            ),
            Center(child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),),
          ],
        );
      }

      List<Widget> children = [];
      children.add(Padding(
        padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
        child: Text(TextString.label__current_prescriptions, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
      ),);
      for(Prescription prescription in _.vReference.currentPrescriptionList) {
        if(prescription.isPrescribed) {
          for(Dosage dosage in prescription.dosageList!) {
            children.add(_CurrentPrescriptionItem(prescription: prescription, dosage: dosage,),);
          }
        }
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    });
  }

  Widget _pastDiagnosticSection(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(builder: (_) {
      if(_.vReference.pastPrescriptionList.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
              child: Text(TextString.label__past_diagnostic, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
            ),
            Center(child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),),
          ],
        );
      }

      List<Widget> children = [];
      children.add(Padding(
        padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
        child: Text(TextString.label__past_diagnostic, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
      ),);
      children.addAll(_.vReference.pastPrescriptionList.map((e) => _PastDiagnosticItem(prescription: e)).toList());

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children,);
    });
  }
}

class _CurrentPrescriptionItem extends StatelessWidget {
  final Prescription prescription;
  
  final Dosage dosage;
  
  late final String prescribedForLabel;

  late final String prescribedDrugLabel;

  late final String prescribedDrugCountLabel;

  late final String dosageLabel;

  late final String timesPerDayLabel;

  late final String prescribedByLabel;

  _CurrentPrescriptionItem({required this.prescription, required this.dosage});

  @override
  Widget build(BuildContext context) {
    prescribedForLabel = prescription.diagnosticNonNull;
    prescribedDrugLabel = dosage.drug!.name!;
    prescribedDrugCountLabel =  '${dosage.dosageCount!} ${dosage.drug!.type!.capitalizeFirst}';
    dosageLabel = '${dosage.treatmentDays} Days';
    timesPerDayLabel = '${dosage.timesPerDay!} Times / Day';
    prescribedByLabel = '${prescription.doctor!.nameNonNull}';
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: ScreenUtil.heightInPercent(2)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-----
            Text(TextString.label__prescribed_for, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Text(prescribedForLabel, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: Style.fontSize_L),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__prescribed_drug, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Row(
              children: [
                Text(prescribedDrugLabel, style: Style.defaultTextStyle(color: Colors.black),),
                Spacer(),
                Icon(Icons.mediation, color: Colors.purple, size: Style.iconSize_S,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text(prescribedDrugCountLabel, style: Style.defaultTextStyle(color: Colors.purple, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__dosage, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Row(
              children: [
                Text(dosageLabel, style: Style.defaultTextStyle(color: Colors.black),),
                Spacer(),
                Icon(Icons.watch_later, color: Colors.green, size: Style.iconSize_S,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text(timesPerDayLabel, style: Style.defaultTextStyle(color: Colors.green, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenUtil.heightInPercent(6),
                  width: ScreenUtil.heightInPercent(6),
                  child: GFAvatar(
                    backgroundImage: prescription.doctor!.imageUrl == null ? noImage : NetworkImage(prescription.doctor!.imageUrl!),
                    shape: GFAvatarShape.square,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1), ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(TextString.label__prescribed_by, style: Style.defaultTextStyle(color: Colors.grey[500]!),),
                      SizedBox(height: ScreenUtil.heightInPercent(0.5),),
                      Text(prescribedByLabel, style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_Default),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PastDiagnosticItem extends StatelessWidget {
  final Prescription prescription;

  late final String diagnosticLabel;

  late final String dateLabel;

  late final bool prescribed;

  _PastDiagnosticItem({required this.prescription});

  @override
  Widget build(BuildContext context) {
    diagnosticLabel = prescription.diagnosticNonNull;
    dateLabel = prescription.prescriptionDateNonNull;
    prescribed = prescription.isPrescribed;
    Color prescribedColor = prescribed ? Style.colorPrimary : Style.colorPrimary.withOpacity(0.4);

    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
      padding: EdgeInsets.all(ScreenUtil.heightInPercent(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Style.colorPrimary.withOpacity(0.10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(diagnosticLabel, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: 0.5, fontSize: Style.fontSize_XL),),
              Spacer(),
              Text(dateLabel, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(height: ScreenUtil.heightInPercent(2),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.speaker_notes_rounded, color: prescribedColor, size: Style.iconSize_Default,),
              SizedBox(width: ScreenUtil.widthInPercent(3),),
              Text(prescribed ? TextString.label__prescribed : TextString.label__not_prescribed, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: prescribedColor),),
            ],
          )
        ],
      )
    );
  }
}
