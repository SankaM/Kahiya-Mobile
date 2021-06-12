import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyReactiveTextField extends StatelessWidget {
  final String formControlName;

  final String hintText;

  final IconData iconData;

  final ValidationMessagesFunction validationMessages;

  MyReactiveTextField({required this.formControlName, required this.hintText, required this.iconData, required this.validationMessages});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        suffixIcon: Icon(iconData, color: Style.colorPrimary,),
        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(color: Style.colorPrimary),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        fillColor: Style.colorPrimary.withOpacity(0.2),
        focusColor: Style.colorPrimary.withOpacity(0.2),
      ),
    );
  }
}
