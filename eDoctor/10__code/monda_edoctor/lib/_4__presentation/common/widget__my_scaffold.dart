
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';

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

  final Widget? floatingActionButton;

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
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: showAppBar ? _appBar() : null,
      body: _body(),
      floatingActionButton: showFloatingActionButton ? _fab() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          showBottomNavigationBar ? _bottomNavigationBar() : null,
    );

    if (usingSafeArea) {
      return SafeArea(
        child: scaffold,
      );
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
      title: Text(
        title,
        style: TextStyle(fontSize: Style.fontSize_Default),
      ),
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
      child: Text(title, style: TextStyle(fontSize: Style.fontSize_Default),),
    );
  }

  Widget _bottomNavigationBar() {
    if (bottomNavigationBar != null) {
      return bottomNavigationBar!;
    } else {
      return _defaultBottomNavigationBar();
    }
  }

  Widget _fab() {
    var sideSize = ScreenUtil.widthInPercent(14).floor();
    var margin = ScreenUtil.widthInPercent(1).floor();

    return Container(
      width: sideSize.toDouble(),
      height: sideSize.toDouble(),
      margin: EdgeInsets.all(margin.toDouble()),
      child: floatingActionButton == null ? FloatingActionButton(
        child: Icon(
          Icons.person_add,
          color: Colors.white,
          size: ScreenUtil.widthInPercent(7),
        ),
        backgroundColor: Style.colorPalettes[900],
        elevation: 0,
        onPressed: () {
          RouteNavigator.gotoRegisterPatientPage();
        },
      ) : floatingActionButton,
    );
  }

  Widget _defaultBottomNavigationBar() {
    var itemIconList = [Icons.notes, Icons.store];
    var itemLabelList = [
      TextString.page_title__invoice,
      TextString.page_title__inventory
    ];

    return AnimatedBottomNavigationBar.builder(
        elevation: 20,
        itemCount: itemIconList.length,
        activeIndex: selectedIndexOfBottomNavigationBar,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        height: ScreenUtil.heightInPercent(10),
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                itemIconList[index],
                size: ScreenUtil.heightInPercent(3.5),
                color: Style.colorPrimary,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  itemLabelList[index],
                  maxLines: 1,
                  style: TextStyle(
                      color: Style.colorPrimary,
                      fontSize: Style.fontSize_Default),
                  group: autoSizeGroup,
                ),
              ),
              if (isActive) SizedBox(height: ScreenUtil.heightInPercent(0.8)),
              if (isActive)
                DottedLine(
                  dashColor: Style.colorPrimary,
                  dashLength: ScreenUtil.widthInPercent(4),
                  dashGapLength: 0,
                  lineThickness: ScreenUtil.widthInPercent(1),
                  dashRadius: 16,
                  lineLength: ScreenUtil.widthInPercent(5),
                ),
            ],
          );
        },
        onTap: (int i) {
          switch (i) {
            case 0:
              {
                RouteNavigator.gotoInvoicePage();
                break;
              }
            case 1:
              {
                RouteNavigator.gotoInventoryPage();
                break;
              }
          }
        });
  }
}
