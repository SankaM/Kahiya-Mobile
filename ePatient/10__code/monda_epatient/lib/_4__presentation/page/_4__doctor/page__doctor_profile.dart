import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_1__model/appointment_option_hour.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context, doctorName: DoctorProfileController.instance.vReference.doctorName!),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context, {required String doctorName}) {
    return CustomAppBarBuilder.build(
      context: context,
      firstLineLabel: Text(doctorName, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, fontWeight: FontWeight.w700),),
      secondLineLabel: Text(TextString.label__profile, style: Style.defaultTextStyle()),
    );
  }

  Widget _contentBody(BuildContext context) {
    var firstRowProfile = GetBuilder<DoctorProfileController>(builder: (_) {
      if(_.vReference.doctor != null) {
        return _firstRowProfile(context);
      }

      return Container();
    });

    var aboutDoctorSection = GetBuilder<DoctorProfileController>(builder: (_) {
      if(_.vReference.doctor != null) {
        return _aboutDoctorSection(context);
      }

      return Container();
    });

    var pastHistorySection = GetBuilder<DoctorProfileController>(builder: (_) {
      if(_.vReference.doctorStatistic != null) {
        return _pastHistorySection(context);
      }

      return Container();
    });

    var workHoursSection = GetBuilder<DoctorProfileController>(builder: (_) {
      if(_.vReference.workHours.isNotEmpty) {
        return _workHoursSection(context);
      }

      return Container();
    });

    var availableAppointmentHoursSection = GetBuilder<DoctorProfileController>(builder: (_) {
      if(_.vReference.workHours.isNotEmpty) {
        return _availableAppointmentHoursSection(context);
      }

      return Container();
    });

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
          firstRowProfile,
          aboutDoctorSection,
          pastHistorySection,
          workHoursSection,
          availableAppointmentHoursSection,
          _makeAnAppointmentButton(context),
          SizedBox(height: ScreenUtil.heightInPercent(20),),
        ],
      ),
    );
  }

  Widget _firstRowProfile(BuildContext context) {
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);

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
                backgroundImage: DoctorProfileController.instance.vReference.doctor!.imageUrl == null ? noImage : NetworkImage(DoctorProfileController.instance.vReference.doctor!.imageUrl!),
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
                  Text(DoctorProfileController.instance.vReference.doctor!.nonNullName, style: Style.defaultTextStyle(color: Colors.grey[700]!, fontWeight: FontWeight.w700),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Text(DoctorProfileController.instance.vReference.doctor!.nonNullSpeciality, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: Colors.grey[500]!),),
                  Spacer(),
                  Text(TextString.label__available_for_appointment, style: Style.defaultTextStyle(fontSize: Style.fontSize_XS, color: Colors.grey[500]!),),
                  SizedBox(height: ScreenUtil.heightInPercent(1),),
                  Row(
                    children: [
                      Image.asset(Asset.png_time01, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                      SizedBox(width: ScreenUtil.widthInPercent(1),),
                      Text(DoctorProfileController.instance.vReference.doctor!.nonNullGeneralWorkHour, style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: Colors.grey[700]!, fontWeight: FontWeight.w600),),
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
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__about, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), right: ScreenUtil.widthInPercent(1)),
          child: Text(DoctorProfileController.instance.vReference.doctor!.nonNullProfile, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5), textAlign: TextAlign.justify,),
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
        _PastHistoryItem(icon: Icons.system_update_tv_outlined, itemLabel: TextString.label__total_diagnostics, itemCount: DoctorProfileController.instance.vReference.doctorStatistic!.nonNullTotalDiagnostics),
        _PastHistoryItem(icon: Icons.note, itemLabel: TextString.label__total_prescriptions, itemCount: DoctorProfileController.instance.vReference.doctorStatistic!.nonNullTotalPrescriptions),
        // _PastHistoryItem(icon: Icons.person, itemLabel: 'Total Surgeries', itemCount: '15'),
      ],
    );
  }

  Widget _workHoursSection(BuildContext context) {
    var monWidget = _WorkHourCard(dayNameLabel: 'Mon', workHoursLabel: 'OFF');
    var tueWidget = _WorkHourCard(dayNameLabel: 'Tue', workHoursLabel: 'OFF');
    var wedWidget = _WorkHourCard(dayNameLabel: 'Wed', workHoursLabel: 'OFF');
    var thuWidget = _WorkHourCard(dayNameLabel: 'Thu', workHoursLabel: 'OFF');
    var friWidget = _WorkHourCard(dayNameLabel: 'Fri', workHoursLabel: 'OFF');
    var satWidget = _WorkHourCard(dayNameLabel: 'Sat', workHoursLabel: 'OFF');
    var sunWidget = _WorkHourCard(dayNameLabel: 'Sun', workHoursLabel: 'OFF');

    WorkHour? monWorkHour = DoctorProfileController.instance.findWorkHour('MONDAY');
    if(monWorkHour != null && monWorkHour.time != null) {
      monWidget = monWidget = _WorkHourCard(dayNameLabel: 'Mon', workHoursLabel: monWorkHour.time!.split('-')[0] + '\n - \n' + monWorkHour.time!.split('-')[1]);
    }

    WorkHour? tueWorkHour = DoctorProfileController.instance.findWorkHour('TUESDAY');
    if(tueWorkHour != null && tueWorkHour.time != null) {
      tueWidget = tueWidget = _WorkHourCard(dayNameLabel: 'Tue', workHoursLabel: tueWorkHour.time!.split('-')[0] + '\n - \n' + tueWorkHour.time!.split('-')[1]);
    }

    WorkHour? wedWorkHour = DoctorProfileController.instance.findWorkHour('WEDNESDAY');
    if(wedWorkHour != null && wedWorkHour.time != null) {
      wedWidget = wedWidget = _WorkHourCard(dayNameLabel: 'Wed', workHoursLabel: wedWorkHour.time!.split('-')[0] + '\n - \n' + wedWorkHour.time!.split('-')[1]);
    }

    WorkHour? thuWorkHour = DoctorProfileController.instance.findWorkHour('THURSDAY');
    if(thuWorkHour != null && thuWorkHour.time != null) {
      thuWidget = thuWidget = _WorkHourCard(dayNameLabel: 'Thu', workHoursLabel: thuWorkHour.time!.split('-')[0] + '\n - \n' + thuWorkHour.time!.split('-')[1]);
    }

    WorkHour? friWorkHour = DoctorProfileController.instance.findWorkHour('FRIDAY');
    if(friWorkHour != null && friWorkHour.time != null) {
      friWidget = friWidget = _WorkHourCard(dayNameLabel: 'Fri', workHoursLabel: friWorkHour.time!.split('-')[0] + '\n - \n' + friWorkHour.time!.split('-')[1]);
    }

    WorkHour? satWorkHour = DoctorProfileController.instance.findWorkHour('SATURDAY');
    if(satWorkHour != null && satWorkHour.time != null) {
      satWidget = satWidget = _WorkHourCard(dayNameLabel: 'Sat', workHoursLabel: satWorkHour.time!.split('-')[0] + '\n - \n' + satWorkHour.time!.split('-')[1]);
    }

    WorkHour? sunWorkHour = DoctorProfileController.instance.findWorkHour('SUNDAY');
    if(sunWorkHour != null && sunWorkHour.time != null) {
      sunWidget = sunWidget = _WorkHourCard(dayNameLabel: 'Sun', workHoursLabel: sunWorkHour.time!.split('-')[0] + '\n - \n' + sunWorkHour.time!.split('-')[1]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(2.5)),
          child: Text(TextString.label__work_hours, style: Style.defaultTextStyle(color: Colors.grey[500]!, fontWeight: FontWeight.w700,),),
        ),
        Row(
          children: [
            Expanded(flex: 1, child: monWidget,),
            Expanded(flex: 1, child: tueWidget,),
            Expanded(flex: 1, child: wedWidget,),
            Expanded(flex: 1, child: thuWidget,),
            Expanded(flex: 1, child: friWidget,),
            Expanded(flex: 1, child: satWidget,),
            Expanded(flex: 1, child: sunWidget,),
          ],
        )
      ],
    );
  }

  Widget _availableAppointmentHoursSection(BuildContext context) {
    return _AvailableAppointmentHours(optionHourList: DoctorProfileController.instance.vState.appointmentOptionHours);
  }

  Widget _makeAnAppointmentButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: GFButton(
        color: Style.colorPrimary,
        size: ScreenUtil.heightInPercent(6),
        elevation: 3,
        onPressed: () {
          DoctorProfileController.instance.makeAppointment();
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
          Text(workHoursLabel, textAlign: TextAlign.center, style: Style.defaultTextStyle(fontSize: Style.fontSize_2XS),),
        ],
      ),
    );
  }
}

class _AvailableAppointmentHours extends StatefulWidget {
  final List<AppointmentOptionHour> optionHourList;

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
        padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(1), top: ScreenUtil.heightInPercent(3), right: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
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

  Widget _optionItemWidget(BuildContext context, AppointmentOptionHour _optionHour) {
    Color color1 = (selectedId == _optionHour.id) ? Colors.grey[700]! : Colors.grey[500]!;
    Color color2 = (selectedId == _optionHour.id) ? Colors.grey[600]! : Colors.grey[400]!;

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1.5), left: ScreenUtil.widthInPercent(1), bottom: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1)),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(3), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(3)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10),),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedId = _optionHour.id;
            DoctorProfileController.instance.selectOptionHour(_optionHour);
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
                SizedBox(height: ScreenUtil.heightInPercent(1),),
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
