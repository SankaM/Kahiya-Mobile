import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common_widget/widget__monda_logo.dart';

class SplashPage extends AbstractPageWithBackgroundAndContent {
  SplashPage() : super(
    title: TextString.page_title__splash,
    backgroundAsset: Asset.png__background01,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteNavigator.gotoSignInOrSignUpPage();
      },
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MondaLogo(sideLength: Get.size.width / 2,),
            SizedBox(height: 10,),
            Text(TextString.app_name, style: GoogleFonts.montserrat(fontSize: Style.fontSize_8XL, fontWeight: FontWeight.w400, color: Color.fromRGBO(129, 188, 60, 1), letterSpacing: 12),),
            SizedBox(height: 5,),
            Text(TextString.app_tagline, style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w400, color: Style.colorPrimary,),),
          ],
        ),
      ),
    );
  }
}
