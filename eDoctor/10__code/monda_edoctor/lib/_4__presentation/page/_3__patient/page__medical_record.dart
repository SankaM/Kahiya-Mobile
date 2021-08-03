import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/dosage.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__patient/controller__medical_record.dart';

class MedicalRecordPage extends AbstractPageWithBackgroundAndContent {
  MedicalRecordPage() : super(
    title: TextString.page_title__medical_record,
    backgroundAsset: Asset.png__background03,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: 1,
  );

  @override
  Widget constructContent(BuildContext context) {
    if(Get.arguments != null && Get.arguments['patientId'] != null) {
      String patientId = Get.arguments['patientId'];
      MedicalRecordController.instance.retrieveData(patientId: patientId);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        GetBuilder<MedicalRecordController>(
          builder: (c) {
            return Visibility(
              child: c.patient != null ? Scaffold(
                backgroundColor: Colors.transparent,
                appBar: _contentCustomAppBar(context),
                body: _contentBody(context),
              ) : Container(),
              visible: !c.progressDialogShow,
            );
          },
        ),
        GetBuilder<MedicalRecordController>(
          builder: (c) {
            return Visibility(
              child: ProgressIndicatorOverlay(text: TextString.label__retrieving_patient_data,),
              visible: c.progressDialogShow,
            );
          },
        ),
      ],
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(22.5)),
      firstLineLabel: Text('${MedicalRecordController.instance.patient!.firstName} ${MedicalRecordController.instance.patient!.lastName}\'s', style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w500),),
      secondLineLabel: Text(TextString.label__medical_record, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL)),
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
          _pastHistorySection(context),
          _addPrescriptionButton(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _firstRowProfile(BuildContext context) {
    String _generateSecondLine() {
      Patient patient = MedicalRecordController.instance.patient!;
      
      // Second line text
      String? gender = patient.gender != null ? patient.gender! : null;
      String? birthDate = patient.birthDate != null ? patient.birthDate! : null;
      String secondLineText = '';
      if(gender != null) {
        secondLineText += StringUtil.capitalize(gender)!;
      }
      if(gender != null && birthDate != null) {
        secondLineText += ', ';
      }
      if(birthDate != null) {
        secondLineText += '${patient.age} yrs';
      }
      
      return secondLineText;
    }

    return Container(
      height: ScreenUtil.heightInPercent(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(ScreenUtil.widthInPercent(1.5)),
            height: ScreenUtil.heightInPercent(12.5),
            width: ScreenUtil.heightInPercent(12.5),
            child: MedicalRecordController.instance.patient!.imageUrl != null ? GFAvatar(
              backgroundImage: NetworkImage(MedicalRecordController.instance.patient!.imageUrl!),
              shape: GFAvatarShape.square,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ) : Image.asset(Asset.png__no_image_available),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1), ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${MedicalRecordController.instance.patient!.firstName} ${MedicalRecordController.instance.patient!.lastName}', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('${_generateSecondLine()}', style: Style.defaultTextStyle(color: Colors.grey[500]!),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('${MedicalRecordController.instance.patient!.mobilePhone ?? TextString.label__no_phone_info}', style: Style.defaultTextStyle(color: Colors.grey[600]!),),
                if(MedicalRecordController.instance.patient!.currentDiagnosis != null) Spacer(),
                if(MedicalRecordController.instance.patient!.currentDiagnosis != null) Row(
                  children: [
                    Image.asset(Asset.png_prescription02, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                    SizedBox(width: ScreenUtil.widthInPercent(1.5),),
                    Text('${MedicalRecordController.instance.patient!.currentDiagnosis!}', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _medicalDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__medical_description, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), right: ScreenUtil.widthInPercent(1)),
          child: Text('${MedicalRecordController.instance.patient!.healthProfile}', style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5), textAlign: TextAlign.justify,),
        )
      ],
    );
  }

  Widget _currentPrescriptionSection(BuildContext context) {
    List<Widget> children = [];

    children.add(
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__current_prescriptions, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        )
    );

    if(MedicalRecordController.instance.prescriptionList == null || MedicalRecordController.instance.prescriptionList!.isEmpty) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), right: ScreenUtil.widthInPercent(1)),
          child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5),),
        ),
      );
    } else {
      children.addAll(MedicalRecordController.instance.prescriptionList!.map((e) => _CurrentPrescriptionItem(prescription: e)).toList());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );
  }

  Widget _pastHistorySection(BuildContext context) {
    List<Widget> children = [];
    
    children.add(Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
      child: Text(TextString.label__past_diagnostic, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
    ));
    children.addAll(MedicalRecordController.instance.prescriptionList!.map((e) => _PastDiagnosticItem(prescription: e)).toList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );
  }

  Widget _addPrescriptionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5), left: ScreenUtil.widthInPercent(2), right: ScreenUtil.widthInPercent(2)),
      child: GFButton(
        color: Style.colorPrimary,
        size: ScreenUtil.heightInPercent(6),
        elevation: 3,
        onPressed: () {
          if(MedicalRecordController.instance.patient != null) {
            RouteNavigator.gotoAddPrescriptionPage(patient: MedicalRecordController.instance.patient!);
          }
        },
        child: Text(TextString.label__add_prescription, style: Style.defaultTextStyle(fontWeight: FontWeight.w700),),
      ),
    );
  }
}

class _CurrentPrescriptionItem extends StatelessWidget {
  final Prescription prescription;

  final String prescribedLength = '111';

  final String prescribedDrug = '222';

  final String prescribedDrugCount = '333';

  final String dosage = '444';

  final String dosageCount = '555';

  _CurrentPrescriptionItem({required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: ScreenUtil.heightInPercent(2)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-----
            Row(
              children: [
                Text(prescription.diagnosis!.name!, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: Style.fontSize_L),),
                Spacer(),
                Icon(Icons.calendar_today_rounded, color: Style.colorPrimary,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text('${prescription.prescriptionDate != null ? DateFormat('MMM dd, yyyy').format(prescription.prescriptionDate!) : ''}', style: Style.defaultTextStyle(color: Colors.grey),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__severity, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            DotsIndicator(
              dotsCount: 3,
              position: (prescription.illnessSeverityAsInteger - 1).toDouble(),
              decorator: DotsDecorator(
                  size: const Size(18.0, 9.0),
                  activeSize: const Size(18.0, 9.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  color: Style.colorPrimary.withOpacity(0.5),
                  activeColor: Style.colorPrimary
              ),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //----
            Text(TextString.label__notes, style: Style.defaultTextStyle(color: Colors.grey),),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(0.5)),
              child: Text('${prescription.notes}', style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5), textAlign: TextAlign.justify,),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2.5),),

            Column(children: prescription.dosageList!.map((e) => _dosageItem(context, e)).toList(),),
            SizedBox(height: ScreenUtil.heightInPercent(2.5),),

            //-----
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenUtil.heightInPercent(6),
                  width: ScreenUtil.heightInPercent(6),
                  child: GFAvatar(
                    backgroundImage: NetworkImage(prescription.doctor!.imageUrl!),
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
                      Text('${prescription.doctor!.name!}', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_Default),),
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

  Column _dosageItem(BuildContext context, Dosage dosage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //-----
        Text(TextString.label__prescribed_drug, style: Style.defaultTextStyle(color: Colors.grey),),
        SizedBox(height: ScreenUtil.heightInPercent(0.5),),
        Row(
          children: [
            Text('${dosage.drug!.completeName}', style: Style.defaultTextStyle(color: Colors.black),),
            Spacer(),
            Icon(Icons.mediation, color: Colors.purple, size: Style.iconSize_S,),
            SizedBox(width: ScreenUtil.widthInPercent(1),),
            Text('${dosage.dosageCount!.toInt().toString()}', style: Style.defaultTextStyle(color: Colors.purple, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(1.5),),

        //-----
        Text(TextString.label__dosage, style: Style.defaultTextStyle(color: Colors.grey),),
        SizedBox(height: ScreenUtil.heightInPercent(0.5),),
        Row(
          children: [
            Text('${dosage.treatmentDays} ${TextString.label__days}', style: Style.defaultTextStyle(color: Colors.black),),
            Spacer(),
            Icon(Icons.watch_later, color: Colors.green, size: Style.iconSize_S,),
            SizedBox(width: ScreenUtil.widthInPercent(1),),
            Text('${dosage.timesPerDay} ${TextString.label__times} ${dosage.normalizeDosageRule}', style: Style.defaultTextStyle(color: Colors.green, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(2),),
        Divider(),
      ],
    );
  }
}

class _PastDiagnosticItem extends StatelessWidget {
  final Prescription prescription;

  _PastDiagnosticItem({required this.prescription});

  @override
  Widget build(BuildContext context) {
    Color prescribedColor = prescription.isPrescribed ? Style.colorPrimary : Style.colorPrimary.withOpacity(0.4);

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
              Text(prescription.diagnosis!.name!, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: 0.5, fontSize: Style.fontSize_XL),),
              Spacer(),
              Text('${prescription.prescriptionDate != null ? DateFormat('MMM dd, yyyy').format(prescription.prescriptionDate!) : ''}', style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(height: ScreenUtil.heightInPercent(2),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.speaker_notes_rounded, color: prescribedColor, size: Style.iconSize_Default,),
              SizedBox(width: ScreenUtil.widthInPercent(3),),
              Text(prescription.isPrescribed ? TextString.label__prescribed : TextString.label__not_prescribed, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, color: prescribedColor),),
            ],
          )
        ],
      )
    );
  }
}
