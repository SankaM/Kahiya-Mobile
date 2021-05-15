import 'package:flutter/material.dart';
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
      color: Colors.red,
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoLoginPage();
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                Asset.png_splash2,
                fit: BoxFit.fitWidth,
              ),
            ),
            Align(
                child: Text(TextString.app_name + ' (' + TextString.app_version + ')',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Style.fontSize_XS),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
        )
      ),
    );
  }
}
