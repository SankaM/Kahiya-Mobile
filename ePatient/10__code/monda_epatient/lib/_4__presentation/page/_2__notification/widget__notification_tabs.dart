import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/widget__notification_item.dart';
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
                  padding: EdgeInsets.zero
                ),
                labelPadding: EdgeInsets.zero,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: Style.defaultTextStyle(letterSpacing: 0, fontWeight: FontWeight.w500),
                tabs: [
                  Tab(text: 'Notifications'),
                  Tab(text: 'Medication Alerts'),
                ],
              ),
            ),
            Container(
              height: ScreenUtil.heightInPercent(75),
              child: CustomTabBarView(
                children: <Widget>[
                  _NotificationTab(),
                  _MedicationAlertTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: ScreenUtil.heightInPercent(80),
      child: ListView(
        children: [
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          NotificationItem(doctorName: 'Dr. Melinda Margot', status: 'Appointment Confirmed', dateTime: 'Mon | 17 May, 2021 | 12:00 PM', fuzzyDateTime: 'Just Now', doctorImage: Asset.png_face01,),
          Divider(),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }
}

class _MedicationAlertTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Medication Alerts'),),);
  }
}