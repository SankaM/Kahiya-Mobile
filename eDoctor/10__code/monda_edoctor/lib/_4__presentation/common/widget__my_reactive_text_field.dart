import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyReactiveTextField extends StatelessWidget {
  final String formControlName;

  final String hintText;

  final IconData iconData;

  final ValidationMessagesFunction validationMessages;

  final TextInputType? keyboardType;

  final TextStyle? style;

  final EdgeInsetsGeometry? contentPadding;

  final int lineCount;

  MyReactiveTextField({required this.formControlName, required this.hintText, required this.iconData, required this.validationMessages, this.keyboardType, this.style, this.contentPadding, this.lineCount = 1});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      keyboardType: keyboardType,
      style: style,
      minLines: lineCount,
      maxLines: lineCount,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        suffixIcon: Icon(iconData, color: Style.colorPrimary,),
        hintText: hintText,
        filled: true,
        fillColor: Style.colorPrimary.withOpacity(0.2),
        focusColor: Style.colorPrimary.withOpacity(0.2),
        hintStyle: TextStyle(color: Style.colorPrimary),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
