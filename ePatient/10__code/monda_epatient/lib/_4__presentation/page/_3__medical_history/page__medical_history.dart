import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';

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
          _pastHistorySection(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _firstRowProfile(BuildContext context) {
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
              backgroundImage: AssetImage(Asset.png__patient01),
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
                Text('Steve Elliot', style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w500, fontSize: Style.fontSize_XL),),
                // SizedBox(height: ScreenUtil.heightInPercent(1),),
                Text('Male, 26 yrs', style: Style.defaultTextStyle(color: Colors.grey[500]!),),
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
