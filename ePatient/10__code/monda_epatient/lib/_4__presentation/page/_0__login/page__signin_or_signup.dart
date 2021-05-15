import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/widget__background.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/widget__monda_logo.dart';

class SigninOrSignupPage extends AbstractPage {
  SigninOrSignupPage() : super(
    title: TextString.page_title__sign_in_or_sign_up,
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
            Background(),
            Align(
              child: Column(
                children: [
                  SizedBox(height: 175,),
                  MondaLogo(sideLength: Get.size.width / 3),
                  SizedBox(height: 50,),
                  Text(TextString.label__join_monda_and_start_asking_doctors, style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w400, color: Style.colorPrimary,),),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: GFButton(
                      color: Style.colorPrimary,
                      onPressed: () {
                        RouteNavigator.gotoSigninPage();
                      },
                      fullWidthButton: true,
                      text: TextString.label__sign_in,
                      textStyle: GoogleFonts.montserrat(fontSize: Style.fontSize_2XL, color: Colors.white, letterSpacing: 4),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: GFButton(
                      color: Style.colorPrimary,
                      onPressed: () {
                        RouteNavigator.gotoSignupPage();
                      },
                      fullWidthButton: true,
                      type: GFButtonType.outline,
                      text: TextString.label__sign_up,
                      textStyle: GoogleFonts.montserrat(fontSize: Style.fontSize_2XL, color: Style.colorPrimary, letterSpacing: 4),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
