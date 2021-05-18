import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/components/avatar/gf_avatar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/widget__doctor_card.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/widget__filter_button.dart';

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
        SizedBox(height: 20,),
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
      padding: EdgeInsets.only(left: 30, top: 20, right: 30),
      child: GFAvatar(
        backgroundImage: AssetImage(Asset.png__patient01),
        shape: GFAvatarShape.square,
        size: 25,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 20, right: 30),
      child: Text('Welcome,', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Style.textColorPrimary),),
    );
  }

  Widget _patientNameText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 10, right: 30),
      child: Text('Steve,', style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500, color: Style.textColorPrimary),),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 20, right: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextFormField(
                style: TextStyle(color: Style.colorPrimary),
                cursorColor: Style.colorPrimary,
                decoration: InputDecoration(
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
          ),
          SizedBox(width: 10,),
          FilterButton(labels: ['Name', 'Phone', 'Past History'],),
        ],
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    var width = Get.size.width - (20 * 2);

    return Padding(
      padding: EdgeInsets.only(left: 25, top: 20, right: 25),
      child: Container(
        width: Get.size.width - (10 * 2),
        height: Get.size.height * 0.7,
        child: ListView(
          children: [
            _doctorsTextLabel(context),
            DoctorCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Dr. Carl Johnson', secondLineText: 'Skin Care Specialist', thirdLineText: '10:00 AM - 5:00 PM', assetIcon: Asset.png_time01,),
            DoctorCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Dr. Melinda Margot', secondLineText: 'ENT Specialist / Surgeon', thirdLineText: '9:00 AM - 6:00 PM', assetIcon: Asset.png_time02,),
            DoctorCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Dr. William Martin', secondLineText: 'Gynecologist', thirdLineText: '10:00 AM - 7:00 PM', assetIcon: Asset.png_time03,),
            _myAppointmentTextLabel(context),
            _myAppointmentButton(context),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }

  Widget _doctorsTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 30, right: 10),
      child: Text(TextString.label__doctors, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }

  Widget _myAppointmentTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 30, right: 10),
      child: Text(TextString.label__my_appointments, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }

  Widget _myAppointmentButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 20, right: 5),
      child: GFButton(
        text: TextString.label__view_appointments,
        type: GFButtonType.outline,
        color: Style.colorPrimary,
        shape: GFButtonShape.standard,
        size: 50,
        onPressed: () {},
      ),
    );
  }
}
