
import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class MyReactiveDropdownField<T> extends StatelessWidget {
  final String formControlName;

  final List<DropdownMenuItem<T>> items;

  final ValidationMessagesFunction validationMessages;

  final String prefixText;

  TextStyle? prefixStyle;

  MyReactiveDropdownField({required this.formControlName, required this.items, required this.validationMessages, this.prefixText = '', this.prefixStyle});

  @override
  Widget build(BuildContext context) {
    if(prefixStyle == null) prefixStyle = Style.defaultTextStyle(color: Colors.grey, fontSize: Style.fontSize_XS);

    return ReactiveDropdownField<T>(
      formControlName: formControlName,
      items: items,
      style: TextStyle(color: Style.colorPrimary),
      icon: Icon(Icons.arrow_drop_down, color: Style.colorPrimary,),
      validationMessages: validationMessages,
      decoration: InputDecoration(
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        filled: true,
        fillColor: Style.colorPrimary.withOpacity(0.2),
        focusColor: Style.colorPrimary.withOpacity(0.2),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
