import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/controller__notification.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/widget__medication_alert_item.dart';
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
                  Tab(text: TextString.label__notifications),
                  Tab(text: TextString.label__medication_alerts),
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
    return GetBuilder<NotificationController>(
      builder: (_) {
        if(_.vReference.acceptedAppointment.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(ScreenUtil.widthInPercent(10)),
            child: Center(
              child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),
            ),
          );
        }

        List<Widget> children = [];
        _.vReference.acceptedAppointment.forEach((appointment) {
          children.add(NotificationItem(appointment: appointment),);
          children.add(Divider(),);
        });
        children.add(SizedBox(height: ScreenUtil.heightInPercent(20),),);

        return Container(
          height: ScreenUtil.heightInPercent(80),
          child: ListView(children: children),
        );
      },
    );
  }
}

class _MedicationAlertTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (_) {
      if(_.vReference.allTakenMedicine.isEmpty) {
        return Container(
                height: ScreenUtil.heightInPercent(80),
                child: Center(child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[500]!),),),
        );
      }

      List<Widget> children = [];
      _.vReference.allTakenMedicine.forEach((takenMedicine) {
        children.add(MedicationAlertItem(takenMedicine: takenMedicine,));
        children.add(Divider());
      });
      children.add(SizedBox(height: ScreenUtil.heightInPercent(20),),);

      return Container(
        height: ScreenUtil.heightInPercent(80),
        child: ListView(children: children,),
      );
    });
  }
}