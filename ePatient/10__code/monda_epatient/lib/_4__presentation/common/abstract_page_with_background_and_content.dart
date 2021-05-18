import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page.dart';
import 'package:monda_epatient/_4__presentation/common/widget__background.dart';

abstract class AbstractPageWithBackgroundAndContent extends AbstractPage {
  final String backgroundAsset;

  AbstractPageWithBackgroundAndContent({
    required String title,
    required this.backgroundAsset,
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
    return Background(backgroundAsset: backgroundAsset);
    // return SvgPicture.asset(Asset.svg_background01);

  }

  Widget constructContent(BuildContext context) {
    return Center(child: Text(title),);
  }
}
