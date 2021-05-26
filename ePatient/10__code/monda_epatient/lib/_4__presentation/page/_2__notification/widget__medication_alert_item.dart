import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';

class MedicationAlertItem extends StatelessWidget {
  final MedicationAlertItemType type;

  final String fuzzyNotificationTime;   // 'Just Now'

  final String drugName;                // 'Paracetamol'

  final String drugImage;               // 'assets/blablabla.png'

  final String drugSize;                // '500mg'

  final String drugCount;               // '2 Tablets

  final String medicineTime;            // 'Within an hour'

  final String drugCondition;           // 'Before Meal'

  MedicationAlertItem({
    required this.type,
    required this.fuzzyNotificationTime,
    required this.drugName,
    required this.drugImage,
    required this.drugSize,
    required this.drugCount,
    required this.medicineTime,
    required this.drugCondition,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Style.colorPrimary;
    if(type == MedicationAlertItemType.missed) {
      color = Colors.red;
    } else if(type == MedicationAlertItemType.taken) {
      color = Colors.green;
    }

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(3), bottom: ScreenUtil.heightInPercent(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(TextString.label__time_for + ' ' + drugName, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
              SizedBox(width: ScreenUtil.widthInPercent(2)),
              Text(fuzzyNotificationTime, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
              Spacer(),
              Container(
                child: GFAvatar(
                  backgroundImage: AssetImage(drugImage),
                  shape: GFAvatarShape.square,
                  size: ScreenUtil.heightInPercent(3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil.heightInPercent(2.5),),

          // --------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.label__take, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                  SizedBox(height: ScreenUtil.heightInPercent(1)),
                  Text(drugName, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                  SizedBox(height: ScreenUtil.heightInPercent(1)),
                  Text(drugSize, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.label, color: color, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(1),),
                      Text(drugCount, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.heightInPercent(1)),
                  if(type == MedicationAlertItemType.mark_taken) Row(
                    children: [
                      Icon(Icons.watch_later, color: color, size: Style.iconSize_S,),
                      SizedBox(width: ScreenUtil.widthInPercent(1),),
                      Text(medicineTime, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenUtil.heightInPercent(2.5),),

          // --------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.label__when, style: Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_S, fontWeight: FontWeight.w500),),
                  SizedBox(height: ScreenUtil.heightInPercent(1)),
                  Text(drugCondition, style: Style.defaultTextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                ],
              ),
              Spacer(),
              if(type == MedicationAlertItemType.taken) Text(TextString.label__taken, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
              if(type == MedicationAlertItemType.missed) Text(TextString.label__missed, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
            ],
          ),
          if(type == MedicationAlertItemType.mark_taken) _markTakenButton(context),
        ],
      ),
    );
  }

  Widget _markTakenButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.outline,
          size: ScreenUtil.heightInPercent(6),
          onPressed: () {
          },
          child: Text('Mark Taken', style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
        ),
      ),
    );
  }
}

enum MedicationAlertItemType { taken, missed, mark_taken }
