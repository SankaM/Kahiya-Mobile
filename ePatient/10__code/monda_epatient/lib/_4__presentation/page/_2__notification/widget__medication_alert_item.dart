import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_1__model/taken_medicine.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/controller__notification.dart';
import 'package:timeago/timeago.dart' as timeago;

class MedicationAlertItem extends StatefulWidget {
  final TakenMedicine takenMedicine;

  MedicationAlertItem({required this.takenMedicine});

  @override
  State<MedicationAlertItem> createState() => _MedicationAlertItemState();
}

class _MedicationAlertItemState extends State<MedicationAlertItem> {
  String fuzzyNotificationTime = '';

  String drugName = '';

  String drugSize = '';

  String drugCount = '';

  String medicineTime = '';

  String drugCondition = '';

  @override
  Widget build(BuildContext context) {
    Color color = Style.colorPrimary;
    fuzzyNotificationTime = timeago.format(widget.takenMedicine.scheduledTakenDate!);
    drugName = widget.takenMedicine.dosage!.drug!.name!;
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);
    drugSize = widget.takenMedicine.dosage!.drug!.measurement!.toString() + ' ' + widget.takenMedicine.dosage!.drug!.measurementUnit!;
    drugCount = widget.takenMedicine.dosage!.dosageCount!.toString();
    medicineTime = DateFormat('HH:mm').format(widget.takenMedicine.scheduledTakenDate!);
    drugCondition = widget.takenMedicine.dosage!.dosageRule!.capitalizeFirst!.replaceAll('_', ' ');

    if(widget.takenMedicine.takenStatus != null && widget.takenMedicine.takenStatus == TakenStatus.NOT_TAKEN) {
      color = Colors.red;
    } else if(widget.takenMedicine.takenStatus != null && widget.takenMedicine.takenStatus == TakenStatus.TAKEN) {
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
                  backgroundImage: widget.takenMedicine.dosage!.drug!.imageUrl == null ? noImage : NetworkImage(widget.takenMedicine.dosage!.drug!.imageUrl!),
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
                  if(widget.takenMedicine.takenStatusDate == null) Row(
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
              if(widget.takenMedicine.takenStatus != null && widget.takenMedicine.takenStatus == TakenStatus.TAKEN) Text(TextString.label__taken, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
              if(widget.takenMedicine.takenStatus != null && widget.takenMedicine.takenStatus == TakenStatus.NOT_TAKEN) Text(TextString.label__missed, style: Style.defaultTextStyle(color: color, fontSize: Style.fontSize_S),),
            ],
          ),
          if(widget.takenMedicine.takenStatusDate == null) Row(
              children: [
                _markNotTakenButton(context),
                Spacer(),
                _markTakenButton(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _markTakenButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        color: Colors.white,
        width: ScreenUtil.widthInPercent(40),
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.outline,
          size: ScreenUtil.heightInPercent(6),
          onPressed: () {
            log('====================== markTakenButton');
            NotificationController.instance.markTaken(id: widget.takenMedicine.id);
          },
          child: Text(TextString.label__mark_taken, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
        ),
      ),
    );
  }

  Widget _markNotTakenButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(2.5)),
      child: Container(
        color: Colors.white,
        width: ScreenUtil.widthInPercent(40),
        child: GFButton(
          color: Style.colorPrimary,
          type: GFButtonType.outline,
          size: ScreenUtil.heightInPercent(6),
          onPressed: () {
            log('====================== markNotTakenButton');
            NotificationController.instance.markNotTaken(id: widget.takenMedicine.id);
          },
          child: Text(TextString.label__mark_not_taken, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Style.colorPrimary),),
        ),
      ),
    );
  }
}
