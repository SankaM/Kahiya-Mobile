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
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page_with_content.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/widget__filter_button.dart';

class HomePage extends AbstractPageWithContent {
  HomePage() : super(
    title: TextString.page_title__home,
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
        _welcomeText(context),
        _doctorNameText(context),
        _searchBar(context),
        _patientTextLabel(context),
        _patientList(context),
      ],
    );
  }

  Widget _accountProfilePicture(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 40, right: 30),
      child: GFAvatar(
        backgroundImage: AssetImage(Asset.png_doctor01),
        shape: GFAvatarShape.square,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      )
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 20, right: 30),
      child: Text('Welcome,', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Style.textColorPrimary),),
    );
  }

  Widget _doctorNameText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 10, right: 30),
      child: Text('Dr. Elizabeth,', style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, fontWeight: FontWeight.w700, color: Style.textColorPrimary),),
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
          FilterButton(labels: ['Name', 'Username', 'Email', 'Phone'],),
        ],
      ),
    );
  }

  Widget _patientTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 40, right: 30),
      child: Text('Patients', style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }

  Widget _patientList(BuildContext context) {
    var width = Get.size.width - (20 * 2);

    return Padding(
      padding: EdgeInsets.only(left: 25, top: 20, right: 25),
      child: Container(
        width: Get.size.width - (10 * 2),
        height: Get.size.height * 0.6,
        child: ListView(
          children: [
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            _PatientCard(width: width, assetImage: Asset.png_face01, firstLineText: 'Cavey Scott', secondLineText: 'Male, 24 yrs', thirdLineText: 'Flu, Cough', assetIcon: Asset.png_prescription01,),
            _PatientCard(width: width, assetImage: Asset.png_face02, firstLineText: 'Linda Williams', secondLineText: 'Female, 23 yrs', thirdLineText: 'Flu, Fever, Cough', assetIcon: Asset.png_prescription02,),
            _PatientCard(width: width, assetImage: Asset.png_face03, firstLineText: 'Steve Elliot', secondLineText: 'Male, 26 yrs', thirdLineText: 'Fever, Sore throat', assetIcon: Asset.png_prescription03,),
            SizedBox(height: 160,)
          ],
        ),
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final String assetImage;

  final String firstLineText;

  final String secondLineText;

  final String thirdLineText;

  final String assetIcon;

  final double width;

  _PatientCard({required this.assetImage, required this.firstLineText, required this.secondLineText, required this.thirdLineText, required this.assetIcon, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 125,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                height: double.infinity,
                child: GFAvatar(
                  backgroundImage: AssetImage(assetImage),
                  shape: GFAvatarShape.square,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(firstLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                    SizedBox(height: 5,),
                    Text(secondLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                    Spacer(),
                    Row(
                      children: [
                        Image.asset(assetIcon),
                        SizedBox(width: 10,),
                        Text(thirdLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
