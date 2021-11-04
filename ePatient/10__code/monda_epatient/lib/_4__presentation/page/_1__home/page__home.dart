import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/components/avatar/gf_avatar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_1__model/user.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_epatient/_3__service/service__doctor.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/controller__home.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/widget__doctor_card.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/widget__filter_button.dart';
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
    User? user = UserSecureStorage.instance.user;
    String patientName = user != null ? user.name : '';
    String? imageUrl = user != null ? user.imageUrl != null ? user.imageUrl! : null : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeText(context),
            _patientNameText(context, name: patientName),
          ],
        ),
        Spacer(),
        _accountProfilePicture(context, imageUrl: imageUrl),
      ],
    );
  }

  Widget _accountProfilePicture(BuildContext context, {String? imageUrl}) {
    ImageProvider image = AssetImage(Asset.png__no_image_available);
    if(imageUrl != null && imageUrl.isNotEmpty) {
      image = NetworkImage(imageUrl);
    }

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: GFAvatar(
        backgroundImage: image,
        backgroundColor: Colors.white,
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

  Widget _patientNameText(BuildContext context, {required String name}) {
    name = name.length > 20 ? name.substring(0, 19) : name;

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(8)),
      child: Text(name, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500, color: Style.textColorPrimary),),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(10),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: ReactiveForm(
        formGroup: HomeController.instance.vInput.searchForm,
        child: Row(
          children: [
            Container(
              width: ScreenUtil.widthInPercent(60),
              height: ScreenUtil.heightInPercent(8),
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
              child: FilterButton(
                labels: ['Name', 'Phone', 'Past History'],
                onTap: (menuItemLabel) {
                  if(menuItemLabel == 'Name') {
                    HomeController.instance.vInput.field = SearchDoctorField.NAME;
                  } else if(menuItemLabel == 'Phone') {
                    HomeController.instance.vInput.field = SearchDoctorField.MOBILE_PHONE;
                  }
                },
              ),
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                HomeController.instance.searchDoctors();
                return Container();
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    var width = ScreenUtil.widthInPercent(80);
    var height = ScreenUtil.heightInPercent(17);

    var noDoctorFound = Padding(
      padding: EdgeInsets.all(ScreenUtil.widthInPercent(10)),
      child: Center(
        child: Text(
          TextString.label__no_doctor_found,
          style: Style.defaultTextStyle(color: Colors.grey[500]!),
        ),
      ),
    );

    var builder = GetBuilder<HomeController>(
      builder: (_) {
        List<Widget> children = [];
        children.add(_doctorsTextLabel(context));

        if(_.vReference.doctorList.isEmpty) {
          children.add(noDoctorFound);
        } else {
          children.addAll(_.vReference.doctorList.map((d) => DoctorCard(doctor: d,width: width, height: height,),),);
        }

        children.add(_myAppointmentTextLabel(context));
        children.add(_myAppointmentButton(context));
        children.add(SizedBox(height: ScreenUtil.heightInPercent(10)));

        return ListView(
          children: children,
        );
      },
    );

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: Container(
        height: ScreenUtil.heightInPercent(70),
        child: builder,
      ),
    );
  }

  Widget _doctorsTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(3)),
      child: Text(TextString.label__doctors, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }

  Widget _myAppointmentTextLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(3)),
      child: Text(TextString.label__my_appointments, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w700, color: Colors.grey[500],),),
    );
  }

  Widget _myAppointmentButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1.5)),
      child: GFButton(
        child: Text(TextString.label__view_appointments, style: GoogleFonts.montserrat(color: Style.colorPrimary, fontSize: Style.fontSize_Default),),
        type: GFButtonType.outline,
        color: Style.colorPrimary,
        shape: GFButtonShape.standard,
        size: ScreenUtil.heightInPercent(6.5),
        onPressed: () {
          RouteNavigator.gotoAllAppointmentPage();
        },
      ),
    );
  }
}
