import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class FocusButton extends StatelessWidget {
  final double height;

  final double width;

  final GestureTapCallback onTap;

  final String label;

  FocusButton({required this.height, required this.width, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.colorPrimary,
            border: Border.all(color: Style.colorPrimary,),
            borderRadius: BorderRadius.all(Radius.circular(10),),
            boxShadow: [
              BoxShadow(
                color: Style.colorPrimary.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]
          ),
          child: Center(child: Text(label, textAlign: TextAlign.center, style: Style.defaultTextStyle(fontWeight: FontWeight.w500, fontSize: Style.fontSize_L),),),
        ),
      ),
    );
  }
}