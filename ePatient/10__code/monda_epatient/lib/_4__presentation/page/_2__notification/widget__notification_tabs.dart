import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_9__modify/bubble_tab_indicator__0_1_6/bubble_tab_indicator.dart';
import 'package:monda_epatient/_9__modify/flutter/custom_tabs.dart';

class NotificationTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: ScreenUtil.heightInPercent(5),
              child: CustomTabBar(
                indicator: BubbleTabIndicator(
                  indicatorHeight: ScreenUtil.heightInPercent(5),
                  indicatorColor: Style.colorPrimary,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  insets: EdgeInsets.zero,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                tabs: [
                  Tab(text: 'Notifications'),
                  Tab(text: 'Medication Alerts'),
                ],
              ),
            ),
            Container(
              height: 120,
              child: CustomTabBarView(
                children: <Widget>[
                  Container(child: Center(child: Text('Notifications'),),),
                  Container(child: Center(child: Text('Medication Alerts'),),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
