import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page.dart';

abstract class AbstractPageWithContent extends AbstractPage {
  AbstractPageWithContent({
    required String title,
    bool usingSafeArea = true,
    bool showAppBar = false,
    bool showFloatingActionButton = false,
    bool showBottomNavigationBar = false,
    int selectedIndexOfBottomNavigationBar = -1})
    : super(
        title: title,
        usingSafeArea: usingSafeArea,
        showAppBar: showAppBar,
        showFloatingActionButton: showFloatingActionButton,
        showBottomNavigationBar: showBottomNavigationBar,
        selectedIndexOfBottomNavigationBar: selectedIndexOfBottomNavigationBar,
  );

  Widget constructBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: constructBackground(context),
          top: 0.0,
        ),
        Positioned(
            child: Container(
              child: constructContent(context),
              width: Get.size.width,
              height: Get.size.height,
            ),
            top: 0.0
        ),
      ],
    );
  }

  Widget constructBackground(BuildContext context) {
    return SvgPicture.asset(Asset.svg_background01);
  }

  Widget constructContent(BuildContext context) {
    return Center(child: Text(title),);
  }
}
