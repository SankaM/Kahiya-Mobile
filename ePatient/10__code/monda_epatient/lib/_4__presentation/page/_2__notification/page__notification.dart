import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/widget__notification_tabs.dart';

class NotificationPage extends AbstractPageWithBackgroundAndContent {
  NotificationPage() : super(
    title: TextString.page_title__notifications,
    backgroundAsset: Asset.png__background04,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: 0,
  );

  @override
  Widget constructContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(15)),
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary, size: Style.iconSize_2XL,),
      firstLineLabel: Text(TextString.label__notifications, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      child: ListView(
        children: [
          NotificationTabs(),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }
}
