import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class FocusButton extends StatelessWidget {
  final double height;

  final double width;

  final GestureTapCallback? onTap;

  final String label;

  final Color backgroundColor;

  final Color borderColor;

  final Color? shadowColor;

  final Color textColor;

  FocusButton({
    required this.height,
    required this.width,
    required this.onTap,
    required this.label,
    this.backgroundColor: Style.colorPrimary,
    this.borderColor: Style.colorPrimary,
    this.shadowColor,
    this.textColor: Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Color _shadowColor = ((shadowColor == null) ? Style.colorPrimary.withOpacity(0.2) : shadowColor)!;

    return Container(
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: onTap != null ? backgroundColor : Colors.grey[400],
            border: Border.all(color: onTap != null ? borderColor : Colors.grey[400]!,),
            borderRadius: BorderRadius.all(Radius.circular(10),),
            boxShadow: [
              BoxShadow(
                color: onTap != null ? _shadowColor : Colors.grey[100]!,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Style.defaultTextStyle(fontWeight: FontWeight.w500, fontSize: Style.fontSize_L, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
