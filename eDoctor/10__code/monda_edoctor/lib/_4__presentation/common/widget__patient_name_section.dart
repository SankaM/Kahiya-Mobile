
import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class PatientNameSection extends StatelessWidget {
  final String patientName;

  final bool showIcon;

  final Color color;

  PatientNameSection({required this.patientName, this.showIcon = true, this.color = Style.colorPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(7),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(5)),
      child: Row(
        children: [
          Expanded(child: Text(patientName, style: Style.defaultTextStyle(color: color, fontWeight: FontWeight.w500),),),
          if(showIcon) Icon(Icons.person, color: color,),
        ],
      ),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
