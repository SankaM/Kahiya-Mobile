import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyReactiveDatePickerContainer extends StatelessWidget {
  final String formControlName;
  
  final String fieldLabelText;
  
  MyReactiveDatePickerContainer({required this.formControlName, required this.fieldLabelText});
  
  @override
  Widget build(BuildContext context) {
    return ReactiveDatePicker(
      formControlName: formControlName,
      fieldLabelText: fieldLabelText,
      firstDate: DateTime.utc(1960),
      lastDate: DateTime.now(),
      builder: (context, picker, child) {
        return GestureDetector(
          onTap: picker.showPicker,
          child: Container(
            decoration: BoxDecoration(
              color: Style.colorPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(10),),
              border: Border.all(color: Style.colorPrimary.withOpacity(0.2),),
            ),
            padding: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(3), horizontal: ScreenUtil.widthInPercent(2),),
            child: ReactiveFormConsumer(
                builder: (context, form, child) {
                  return Text(
                      form.control(formControlName).value == null ? fieldLabelText : new DateFormat.yMMMd().format(form.control(formControlName).value,),
                      style: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary,),);
                }
            ),
          ),
        );
      },
    );
  }
}
