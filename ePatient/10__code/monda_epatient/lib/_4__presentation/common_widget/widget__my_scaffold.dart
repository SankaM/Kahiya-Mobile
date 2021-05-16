import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';

// =============================================================================
// Scaffold
// =============================================================================
class MyScaffold extends StatelessWidget {
  final autoSizeGroup = AutoSizeGroup();

  final String title;

  final bool usingSafeArea;

  final bool showAppBar;

  final bool showFloatingActionButton;

  final bool showBottomNavigationBar;

  final int selectedIndexOfBottomNavigationBar;

  final PreferredSizeWidget? appBar;

  final Widget? body;

  final Widget? bottomNavigationBar;

  MyScaffold(
    this.title, {
    this.usingSafeArea = false,
    this.showAppBar = false,
    this.showFloatingActionButton = true,
    this.showBottomNavigationBar = true,
    this.selectedIndexOfBottomNavigationBar = -1,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: showAppBar ? _appBar() : null,
      body: _doubleBackToCloseAppBody(),
      floatingActionButton: showFloatingActionButton ? _fab() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: showBottomNavigationBar ? _bottomNavigationBar() : null,
    );

    if (usingSafeArea) {
      return SafeArea(child: scaffold,);
    } else {
      return scaffold;
    }
  }

  PreferredSizeWidget _appBar() {
    if (appBar != null) {
      return appBar!;
    } else {
      return _defaultAppBar();
    }
  }

  PreferredSizeWidget _defaultAppBar() {
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: Style.fontSize_Default),),
    );
  }

  Widget _doubleBackToCloseAppBody() {
    return DoubleBack(
      child: _body(),
      message: TextString.label__double_click_to_close,
    );
  }

  Widget _body() {
    if (body != null) {
      return body!;
    } else {
      return _defaultBody();
    }
  }

  Widget _defaultBody() {
    return Center(
      child: Text(title),
    );
  }

  Widget _bottomNavigationBar() {
    if (bottomNavigationBar != null) {
      return bottomNavigationBar!;
    } else {
      return _defaultBottomNavigationBar();
    }
  }


  FloatingActionButton _fab() {
    return FloatingActionButton(
      child: Icon(Icons.home, color: Colors.white,),
      backgroundColor: Style.colorPalettes[900],
      elevation: 0,
      onPressed: () {
        RouteNavigator.gotoHomePage();
      },
    );
  }

  Widget _defaultBottomNavigationBar() {
    var itemIconList = [Icons.notifications, Icons.notes];
    var itemLabelList = [TextString.page_title__notifications, TextString.page_title__medical_history];

    return AnimatedBottomNavigationBar.builder(
        elevation: 20,
        itemCount: itemIconList.length,
        activeIndex: selectedIndexOfBottomNavigationBar,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        height: 90,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                itemIconList[index],
                size: 24,
                color: Style.colorPrimary,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  itemLabelList[index],
                  maxLines: 1,
                  style: TextStyle(color: Style.colorPrimary),
                  group: autoSizeGroup,
                ),
              ),
              if(isActive) const SizedBox(height: 10),
              if(isActive) DottedLine(
                dashColor: Style.colorPrimary,
                dashLength: 20,
                dashGapLength: 0,
                lineThickness: 4,
                dashRadius: 16,
                lineLength: 20,
              ),
            ],
          );
        },
        onTap: (int i) {
          switch (i) {
            case 0:
              {
                RouteNavigator.gotoNotificationPage();
                break;
              }
            case 1:
              {
                RouteNavigator.gotoMedicalHistoryPage();
                break;
              }
          }
        }
    );
  }
}
