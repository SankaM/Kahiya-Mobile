import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_1__model/Patient.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__medical_record/controller__medical_record.dart';

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
    String patientId = Get.arguments;

    MedicalRecordController.instance.retrievePatient(patientId: patientId);

    return Stack(
      fit: StackFit.expand,
      children: [
        GetBuilder<MedicalRecordController>(
          builder: (c) {
            return Visibility(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: _contentCustomAppBar(context),
                body: _contentBody(context),
              ),
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
      firstLineLabel: Text('${MedicalRecordController.instance.patient!.name}\'s', style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w500),),
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
      int? age = patient.age;
      String secondLineText = '';
      if(gender != null) {
        secondLineText += gender;
      }
      if(gender != null && age != null) {
        secondLineText += ', ';
      }
      if(age != null) {
        secondLineText += '$age yrs';
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
                Text('${MedicalRecordController.instance.patient!.name}', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('${_generateSecondLine()}', style: Style.defaultTextStyle(color: Colors.grey[500]!),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('${MedicalRecordController.instance.patient!.mobile}', style: Style.defaultTextStyle(color: Colors.grey[600]!),),
                if(MedicalRecordController.instance.patient!.healthProfile != null) Spacer(),
                if(MedicalRecordController.instance.patient!.healthProfile != null) Row(
                  children: [
                    Image.asset(Asset.png_prescription02, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                    SizedBox(width: ScreenUtil.widthInPercent(1.5),),
                    Text('${MedicalRecordController.instance.patient!.healthProfile!}', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
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
          child: Text(TextString.label__lorem_ipsum, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5), textAlign: TextAlign.justify,),
        )
      ],
    );
  }

  Widget _currentPrescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__current_prescriptions, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        _CurrentPrescriptionItem(prescribedFor: 'Flu', prescribedLength: '3 days', severity: 2, severityNotes: 'Medium',  prescribedDrug: 'Relenza', prescribedDrugCount: '1 Tablet', dosage: '3 Days', dosageCount: '2 Times', prescribedBy: 'Dr. Carl',),
        _CurrentPrescriptionItem(prescribedFor: 'Flu', prescribedLength: '2 days', severity: 3, severityNotes: 'Above 100',prescribedDrug: 'Relenza', prescribedDrugCount: '1 Tablet', dosage: '3 Days', dosageCount: '2 Times', prescribedBy: 'Dr. Carl',),
        _CurrentPrescriptionItem(prescribedFor: 'Flu', prescribedLength: '2 days', severity: 2, severityNotes: 'Medium',prescribedDrug: 'Relenza', prescribedDrugCount: '1 Tablet', dosage: '3 Days', dosageCount: '2 Times', prescribedBy: 'Dr. Carl',),
      ],
    );
  }

  Widget _pastHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__past_diagnostic, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        _PastDiagnosticItem(diagnosticLabel: 'Sore Throat', dateLabel: '21 April, 2021', prescribed: true,),
        _PastDiagnosticItem(diagnosticLabel: 'Stomach Ache', dateLabel: '18 Marc, 2021', prescribed: true,),
        _PastDiagnosticItem(diagnosticLabel: 'Dry Cough', dateLabel: '2 Mar, 2021', prescribed: false,),
      ],
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
          RouteNavigator.gotoAddPrescriptionPage();
        },
        child: Text(TextString.label__add_prescription, style: Style.defaultTextStyle(fontWeight: FontWeight.w700),),
      ),
    );
  }
}

class _CurrentPrescriptionItem extends StatelessWidget {
  final String prescribedFor;

  final String prescribedLength;

  final String prescribedDrug;

  final String prescribedDrugCount;

  final String dosage;

  final String dosageCount;

  final String prescribedBy;

  final int severity;

  final String severityNotes;

  _CurrentPrescriptionItem({
    required this.prescribedFor,
    required this.prescribedLength,
    required this.prescribedDrug,
    required this.prescribedDrugCount,
    required this.dosage,
    required this.dosageCount,
    required this.prescribedBy,
    required this.severity,
    required this.severityNotes});

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
                Text(prescribedFor, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: Style.fontSize_L),),
                Spacer(),
                Icon(Icons.calendar_today_rounded, color: Style.colorPrimary,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text(prescribedLength, style: Style.defaultTextStyle(color: Colors.grey),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__severity, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Row(
              children: [
                DotsIndicator(
                  dotsCount: 3,
                  position: severity - 1,
                  decorator: DotsDecorator(
                    size: const Size(18.0, 9.0),
                    activeSize: const Size(18.0, 9.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    color: Style.colorPrimary.withOpacity(0.5),
                    activeColor: Style.colorPrimary
                  ),
                ),
                Spacer(),
                Text(severityNotes, style: Style.defaultTextStyle(color: Colors.black, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__prescribed_drug, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Row(
              children: [
                Text(prescribedDrug, style: Style.defaultTextStyle(color: Colors.black),),
                Spacer(),
                Icon(Icons.mediation, color: Colors.purple, size: Style.iconSize_S,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text(prescribedDrugCount, style: Style.defaultTextStyle(color: Colors.purple, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),

            //-----
            Text(TextString.label__dosage, style: Style.defaultTextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(0.5),),
            Row(
              children: [
                Text(dosage, style: Style.defaultTextStyle(color: Colors.black),),
                Spacer(),
                Icon(Icons.watch_later, color: Colors.green, size: Style.iconSize_S,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text(dosageCount, style: Style.defaultTextStyle(color: Colors.green, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
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
                    backgroundImage: AssetImage(Asset.png_face_doctor),
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
                      Text(prescribedBy, style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_Default),),
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
  final String diagnosticLabel;

  final String dateLabel;

  final bool prescribed;

  _PastDiagnosticItem({required this.diagnosticLabel, required this.dateLabel, this.prescribed = false});

  @override
  Widget build(BuildContext context) {
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
