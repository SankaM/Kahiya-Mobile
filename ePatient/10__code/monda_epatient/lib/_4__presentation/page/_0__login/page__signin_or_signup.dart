import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page.dart';

class SigninOrSignupPage extends AbstractPage {
  SigninOrSignupPage() : super(
    title: TextString.page_title__signin_or_signup,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
  );

  @override
  Widget constructBody(BuildContext context) {
    return Center(
      child: Text(TextString.page_title__signin_or_signup),
    );
  }
}
