
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/components/avatar/gf_avatar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__patient_card.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__filter_button.dart';

class HomePage extends AbstractPageWithBackgroundAndContent {
  HomePage() : super(
    title: TextString.page_title__home,
    backgroundAsset: Asset.png__background02,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _accountProfilePicture(context),
        _searchBar(context),
        _scrollableSection(context),
      ],
    );
  }

  Widget _accountProfilePicture(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(17),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GFAvatar(
              backgroundImage: AssetImage(Asset.png_face_doctor),
              shape: GFAvatarShape.square,
              size: ScreenUtil.widthInPercent(8),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            Text(TextString.label__welcome, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default,color: Style.textColorPrimary),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            Text('Dr. Elizabeth', style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500, color: Style.textColorPrimary),),
          ],
        )
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(10),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: Row(
        children: [
          Container(
            width: ScreenUtil.widthInPercent(60),
            height: ScreenUtil.heightInPercent(8),
            decoration:  BoxDecoration(
              borderRadius: new BorderRadius.circular(15.0),
              boxShadow: [
                  BoxShadow(color: Colors.grey[100]!, blurRadius: 10.0, spreadRadius: 0.1)
              ]
            ),
            child: TextFormField(
              style: TextStyle(color: Style.colorPrimary),
              cursorColor: Style.colorPrimary,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: ScreenUtil.heightInPercent(8)),
                prefixIcon: Icon(Icons.search, color: Style.colorPrimary,),
                hintText: TextString.label__search,
                hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPalettes[300], fontWeight: FontWeight.w400),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: ScreenUtil.heightInPercent(8),
            height: ScreenUtil.heightInPercent(8),
            decoration:  BoxDecoration(
                borderRadius: new BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(color: Style.colorPrimary, blurRadius: ScreenUtil.widthInPercent(10), spreadRadius: 0.1)
                ]
            ),
            child: FilterButton(labels: ['Name', 'Username', 'Email', 'Phone'],),
          )
        ],
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    var width = ScreenUtil.widthInPercent(80);
    var height = ScreenUtil.heightInPercent(15);

    return Container(
      height: ScreenUtil.heightInPercent(73),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: ListView(
        children: [
          _patientsTextLabel(context),
          PatientCard(width: width, height: height, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
          PatientCard(width: width, height: height, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
          PatientCard(width: width, height: height, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
          PatientCard(width: width, height: height, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
          PatientCard(width: width, height: height, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
          PatientCard(width: width, height: height, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
          SizedBox(height: ScreenUtil.heightInPercent(15),),
        ],
      ),
    );
  }

  Widget _patientsTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(3)),
      child: Text(TextString.label__patients, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }
}
