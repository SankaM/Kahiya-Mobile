import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/widget__monda_logo.dart';

class SigninOrSignupPage extends AbstractPageWithBackgroundAndContent {
  SigninOrSignupPage() : super(
    title: TextString.page_title__sign_in_or_sign_up,
    backgroundAsset: Asset.png__background01,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    return Align(
      child: Column(
        children: [
          SizedBox(height: ScreenUtil.heightInPercent(18),),
          MondaLogo(sideLength: ScreenUtil.widthInPercent(35)),
          SizedBox(height: ScreenUtil.heightInPercent(10),),
          Text(TextString.label__join_monda_and_start_asking_doctors, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, fontWeight: FontWeight.w500, color: Style.colorPrimary,),),
          SizedBox(height: ScreenUtil.heightInPercent(4),),
          Container(
            height: ScreenUtil.heightInPercent(6),
            padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(15), right: ScreenUtil.widthInPercent(15)),
            child: GFButton(
              color: Style.colorPrimary,
              onPressed: () {
                RouteNavigator.gotoSignInPage();
              },
              fullWidthButton: true,
              text: TextString.label__sign_in,
              textStyle: GoogleFonts.montserrat(fontSize: Style.fontSize_2XL, color: Colors.white, letterSpacing: 4),
            ),
          ),
          SizedBox(height: ScreenUtil.heightInPercent(2),),
          Container(
            height: ScreenUtil.heightInPercent(6),
            padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(15), right: ScreenUtil.widthInPercent(15)),
            child: GFButton(
              color: Style.colorPrimary,
              onPressed: () {
                RouteNavigator.gotoSignUpPage();
              },
              fullWidthButton: true,
              type: GFButtonType.outline,
              text: TextString.label__sign_up,
              textStyle: GoogleFonts.montserrat(fontSize: Style.fontSize_2XL, color: Style.colorPrimary, letterSpacing: 4),
            ),
          )
        ],
      ),
    );
  }
}
