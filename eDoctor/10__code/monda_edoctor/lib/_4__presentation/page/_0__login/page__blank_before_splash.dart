import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/route.dart';

class BlankBeforeSplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      RouteNavigator.gotoSplashPage();
    });

    return Scaffold(
      body: Container(color: Colors.white),
    );
  }
}
