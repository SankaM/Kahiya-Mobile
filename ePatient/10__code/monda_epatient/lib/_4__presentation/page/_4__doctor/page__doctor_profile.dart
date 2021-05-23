import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';

class DoctorProfilePage extends AbstractPageWithBackgroundAndContent {
  DoctorProfilePage()
      : super(
          title: TextString.page_title__doctor_profile,
          backgroundAsset: Asset.png__background03,
          usingSafeArea: true,
          showAppBar: false,
          showFloatingActionButton: true,
          showBottomNavigationBar: true,
          selectedIndexOfBottomNavigationBar: -1,
        );

  @override
  Widget constructContent(BuildContext context) {
    var arguments = Get.arguments;
    if(arguments != null) {
      DoctorProfileController.instance.initializeData(
          assetImage: arguments['assetImage'],
          firstLineText: arguments['firstLineText'],
          secondLineText: arguments['secondLineText'],
          thirdLineText: arguments['thirdLineText'],
          assetIcon: arguments['assetIcon']);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      firstLineLabel: Text(DoctorProfileController.instance.firstLineText, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w700),),
      secondLineLabel: Text('Profile', style: Style.defaultTextStyle()),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Style.colorPrimary.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: ListView(
        children: [
          _firstRowProfile(context),
          _aboutDoctorSection(context),
          _pastHistorySection(context),
          _workHoursSection(context),
          _availableAppointmentHoursSection(context),
          _makeAnAppointmentButton(context),
          SizedBox(height: 125,),
        ],
      ),
    );
  }

  Widget _firstRowProfile(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(ScreenUtil.widthInPercent(1.5)),
              height: double.infinity,
              child: GFAvatar(
                backgroundImage: AssetImage(DoctorProfileController.instance.assetImage),
                shape: GFAvatarShape.square,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1), ScreenUtil.widthInPercent(2), ScreenUtil.heightInPercent(1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DoctorProfileController.instance.firstLineText, style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w700),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Text(DoctorProfileController.instance.secondLineText, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: Colors.grey[500]!),),
                  Spacer(),
                  Text(TextString.label__available_for_appointment, style: Style.defaultTextStyle(fontSize: Style.fontSize_XS, color: Colors.grey[500]!),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Row(
                    children: [
                      Image.asset(DoctorProfileController.instance.assetIcon, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                      SizedBox(width: ScreenUtil.widthInPercent(1),),
                      Text(DoctorProfileController.instance.thirdLineText, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: Colors.grey[700]!, fontWeight: FontWeight.w600),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutDoctorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // padding: EdgeInsets.only(left: 10, top: 30, right: 10),
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__about, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), right: ScreenUtil.widthInPercent(1)),
          child: Text(TextString.label__lorem_ipsum, style: Style.defaultTextStyle(color: Colors.grey[600]!,), textAlign: TextAlign.justify,),
        )
      ],
    );
  }

  Widget _pastHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__past_history, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        _PastHistoryItem(icon: Icons.system_update_tv_outlined, itemLabel: 'Total Diagnostic', itemCount: '25'),
        _PastHistoryItem(icon: Icons.note, itemLabel: 'Total Prescriptions', itemCount: '30'),
        _PastHistoryItem(icon: Icons.person, itemLabel: 'Total Surgeries', itemCount: '15'),
      ],
    );
  }

  Widget _workHoursSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__work_hours, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        Row(
          children: [
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Mon', workHoursLabel: '10 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Tue', workHoursLabel: '11 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Wed', workHoursLabel: '10 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Thu', workHoursLabel: '10 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Fri', workHoursLabel: '12 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Sat', workHoursLabel: '11 AM\n -\n5 PM'),),
            Expanded(flex: 1, child: _WorkHourCard(dayNameLabel: 'Sun', workHoursLabel: 'OFF'),),
          ],
        )
      ],
    );
  }

  Widget _availableAppointmentHoursSection(BuildContext context) {
    List<_OptionHour> optionHourList = [
      _OptionHour(id: 1, dayLabel: 'Mon', timeLabel: '12:00 PM', dateLabel: '17 May, 2021'),
      _OptionHour(id: 2, dayLabel: 'Wed', timeLabel: '3:00 PM', dateLabel: '19 May, 2021'),
      _OptionHour(id: 3, dayLabel: 'Thu', timeLabel: '11:00 AM', dateLabel: '20 May, 2021'),
    ];
    return _AvailableAppointmentHours(optionHourList: optionHourList);
  }

  Widget _makeAnAppointmentButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: GFButton(
        color: Style.colorPrimary,
        size: 50,
        elevation: 3,
        onPressed: () {
          RouteNavigator.gotoConfirmAppointmentPage();
        },
        child: Text(TextString.label__make_an_appointment, style: Style.defaultTextStyle(fontWeight: FontWeight.w700),),
      ),
    );
  }
}

class _PastHistoryItem extends StatelessWidget {
  final IconData icon;

  final String itemLabel;

  final String itemCount;

  _PastHistoryItem({required this.icon, required this.itemLabel, required  this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
      padding: EdgeInsets.all(ScreenUtil.heightInPercent(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Style.colorPrimary.withOpacity(0.10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Style.colorPrimary, size: Style.iconSize_2XL,),
          SizedBox(width: ScreenUtil.heightInPercent(1.5),),
          Text(itemLabel, style: Style.defaultTextStyle(fontWeight: FontWeight.w600, color: Style.colorPrimary, letterSpacing: 0.5),),
          Spacer(),
          Text(itemCount, style: Style.defaultTextStyle(fontWeight: FontWeight.w600, color: Style.colorPrimary, letterSpacing: 0.5, fontSize: Style.fontSize_2XL),),
        ],
      ),
    );
  }
}

class _WorkHourCard extends StatelessWidget {
  final String dayNameLabel;
  
  final String workHoursLabel;

  final double height;
  
  _WorkHourCard({required this.dayNameLabel, required this.workHoursLabel, this.height = 0});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height == 0) ? ScreenUtil.heightInPercent(10) : height,
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(0.5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Style.colorPrimary.withOpacity(0.75),
      ),
      child: Column(
        children: [
          Text(dayNameLabel, textAlign: TextAlign.center, style: Style.defaultTextStyle(fontSize: Style.fontSize_XS, fontWeight: FontWeight.w700)),
          SizedBox(height: ScreenUtil.heightInPercent(2),),
          Text(workHoursLabel, textAlign: TextAlign.center, style: Style.defaultTextStyle(fontSize: Style.fontSize_XS),),
        ],
      ),
    );
  }
}

class _OptionHour {
  final int id;

  final String dayLabel;

  final String timeLabel;

  final String dateLabel;

  _OptionHour({required this.id, required this.dayLabel, required this.timeLabel, required this.dateLabel});
}

class _AvailableAppointmentHours extends StatefulWidget {
  final List<_OptionHour> optionHourList;

  _AvailableAppointmentHours({required this.optionHourList});

  @override
  State<StatefulWidget> createState() => _AvailableAppointmentHoursState();
}

class _AvailableAppointmentHoursState extends State<_AvailableAppointmentHours> {
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [];
    childrenList.add(
      Padding(
        padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
        child: Text(TextString.label__available_appointment_hours, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
      ),
    );

    widget.optionHourList.forEach((optionHour) {
      childrenList.add(_optionItemWidget(context, optionHour));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrenList
    );
  }

  Widget _optionItemWidget(BuildContext context, _OptionHour _optionHour) {
    Color color1 = (selectedId == _optionHour.id) ? Colors.grey[700]! : Colors.grey[500]!;
    Color color2 = (selectedId == _optionHour.id) ? Colors.grey[600]! : Colors.grey[400]!;

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10),),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedId = _optionHour.id;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_optionHour.dayLabel, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: color1),),
                SizedBox(height: 5,),
                Text(_optionHour.timeLabel, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: color1),),
              ]
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_optionHour.dateLabel, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: color2),),
                Radio(
                  value: _optionHour.id,
                  groupValue: selectedId,
                  onChanged: (id) {
                    setState(() {
                      selectedId = id as int;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
