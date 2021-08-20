
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/components/avatar/gf_avatar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/user.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/controller__home.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__filter_button.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__patient_card.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    HomeController.instance.init();

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _accountProfilePicture(context),
              _searchBar(context),
              _scrollableSection(context),
            ],
          ),
        ),
        GetBuilder<HomeController>(
          builder: (c) {
            return Visibility(
              child: ProgressIndicatorOverlay(text: TextString.label__retrieving_patient_list,),
              visible: c.progressDialogShow,
            );
          },
        ),
      ],
    );
  }

  Widget _accountProfilePicture(BuildContext context) {
    User? user = UserSecureStorage.instance.user;
    String doctorName = user != null ? user.name != null ? user.name! : '' : '';
    String? imageUrl = user != null ? user.imageUrl != null ? user.imageUrl! : null : null;
    return Container(
      height: ScreenUtil.heightInPercent(17),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                RouteNavigator.gotoAccountPage();
              },
              child: GFAvatar(
                backgroundImage: imageUrl != null ? NetworkImage(imageUrl, scale: 1.0) : null,
                shape: GFAvatarShape.square,
                size: ScreenUtil.widthInPercent(8),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            Text(TextString.label__welcome, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default,color: Style.textColorPrimary),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            Text(doctorName, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500, color: Style.textColorPrimary),),
          ],
        )
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(10),
      width: ScreenUtil.widthInPercent(100),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: ReactiveForm(
        formGroup: HomeController.instance.searchForm,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              child: ReactiveTextField(
                formControlName: 'queryValue',
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
              child: FilterButton(
                labels: ['Name', 'Username', 'Email', 'Phone'],
                onTap: (menuItemLabel) {
                  if(menuItemLabel == 'Name') {
                    HomeController.instance.field = SearchPatientField.NAME;
                  } else if(menuItemLabel == 'Username') {
                    HomeController.instance.field = SearchPatientField.USERNAME;
                  } else if(menuItemLabel == 'Email') {
                    HomeController.instance.field = SearchPatientField.EMAIL;
                  } else if(menuItemLabel == 'Phone') {
                    HomeController.instance.field = SearchPatientField.MOBILE_PHONE;
                  }
                },
              ),
            ),
            ReactiveFormConsumer(
                builder: (context, form, child) {
                  log('===========================================reactiveFormConsumer - inventory');
                  HomeController.instance.getSearchPatient();
                  return Container();
                }
            )
          ],
        ),
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(73),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: _patientList(context),
    );
  }

  Widget _patientList(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      var width = ScreenUtil.widthInPercent(80);
      var height = ScreenUtil.heightInPercent(15);

      List<Widget> children = [];
      children.add(_patientsTextLabel(context));

      HomeController.instance.patientList.forEach((patient) {
        // First line text
        String patientName = '${patient.firstName} ${patient.lastName}';

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

        // Third line text
        String? thirdLineText = patient.currentDiagnosis;

        // Patient Image
        ImageProvider? patientImage = patient.imageUrl != null ? NetworkImage(patient.imageUrl!) : null;

        PatientCard patientCard = PatientCard(
          patientId: patient.id,
          width: width,
          height: height,
          patientImage: patientImage,
          firstLineText: patientName,
          secondLineText: secondLineText,
          thirdLineText: thirdLineText,
        );

        children.add(patientCard);
      });

      children.add(SizedBox(height: ScreenUtil.heightInPercent(15),));

      return ListView(children: children);
    });
  }

  Widget _patientsTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(3)),
      child: Text(TextString.label__patients, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }
}
