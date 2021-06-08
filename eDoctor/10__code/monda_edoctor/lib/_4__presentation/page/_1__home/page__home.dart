
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
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__doctor_card.dart';
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
        SizedBox(height: ScreenUtil.heightInPercent(2.5),),
        _welcomeAccountRow(context),
        _searchBar(context),
        _scrollableSection(context),
      ],
    );
  }

  Widget _welcomeAccountRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeText(context),
            _patientNameText(context),
          ],
        ),
        Spacer(),
        _accountProfilePicture(context),
      ],
    );
  }

  Widget _accountProfilePicture(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: GFAvatar(
        backgroundImage: AssetImage(Asset.png__patient01),
        shape: GFAvatarShape.square,
        size: ScreenUtil.widthInPercent(7),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: Text(TextString.label__welcome, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Style.textColorPrimary),),
    );
  }

  Widget _patientNameText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(8)),
      child: Text('Steve,', style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500, color: Style.textColorPrimary),),
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
            child: FilterButton(labels: ['Name', 'Phone', 'Past History'],),
          )
        ],
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    var width = ScreenUtil.widthInPercent(80);
    var height = ScreenUtil.heightInPercent(17);

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: Container(
        height: ScreenUtil.heightInPercent(70),
        child: ListView(
          children: [
            _doctorsTextLabel(context),
            DoctorCard(width: width, height: height, assetImage: Asset.png_face01, firstLineText: 'Dr. Carl Johnson', secondLineText: 'Skin Care Specialist', thirdLineText: '10:00 AM - 5:00 PM', assetIcon: Asset.png_time01,),
            DoctorCard(width: width, height: height, assetImage: Asset.png_face02, firstLineText: 'Dr. Melinda Margot', secondLineText: 'ENT Specialist / Surgeon', thirdLineText: '9:00 AM - 6:00 PM', assetIcon: Asset.png_time02,),
            DoctorCard(width: width, height: height, assetImage: Asset.png_face03, firstLineText: 'Dr. William Martin', secondLineText: 'Gynecologist', thirdLineText: '10:00 AM - 7:00 PM', assetIcon: Asset.png_time03,),
            SizedBox(height: ScreenUtil.heightInPercent(10),),
          ],
        ),
      ),
    );
  }

  Widget _doctorsTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(3)),
      child: Text(TextString.label__doctors, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }
}
