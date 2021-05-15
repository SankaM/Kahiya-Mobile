import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/widget__my_scaffold.dart';

abstract class AbstractPage extends StatelessWidget {
  final String title;

  final bool usingSafeArea;
  
  final bool showAppBar;

  final bool showFloatingActionButton;

  final bool showBottomNavigationBar;
  
  final int selectedIndexOfBottomNavigationBar;

  AbstractPage({
    this.title = TextString.page_title__default,
    this.usingSafeArea = true,
    this.showAppBar = false,
    this.showFloatingActionButton = false,
    this.showBottomNavigationBar = false,
    this.selectedIndexOfBottomNavigationBar = -1});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title,
      usingSafeArea: usingSafeArea,
      showAppBar: showAppBar,
      showFloatingActionButton: showFloatingActionButton,
      showBottomNavigationBar: showBottomNavigationBar,
      selectedIndexOfBottomNavigationBar: selectedIndexOfBottomNavigationBar,
      appBar: constructAppBar(context),
      body: constructBody(context),
      bottomNavigationBar: constructBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget? constructAppBar(BuildContext context) {
    return null;
  }
  
  Widget? constructBody(BuildContext context) {
    return null;
  }
  
  Widget? constructBottomNavigationBar(BuildContext context) {
    return null;
  }
}
