import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page.dart';

class SplashPage extends AbstractPage {
  SplashPage() : super(
    title: TextString.page_title__splash,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
  );

  @override
  Widget constructBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoSigninOrSignupPage();
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(00),
              margin: EdgeInsets.all(00),
              child: Image.asset(
                Asset.png__background_splash,
                fit: BoxFit.fitWidth,
                width: Get.size.width,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Asset.png__logo,
                    width: Get.size.width / 2,
                  ),
                  Text(TextString.app_name, style: GoogleFonts.montserrat(fontSize: Style.fontSize_8XL, fontWeight: FontWeight.w400, color: Color.fromRGBO(129, 188, 60, 1), letterSpacing: 10),),
                  Text(TextString.app_tagline, style: GoogleFonts.montserrat(fontSize: Style.fontSize_XL, fontWeight: FontWeight.w400, color: Color.fromRGBO(248, 138, 76, 1)),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
