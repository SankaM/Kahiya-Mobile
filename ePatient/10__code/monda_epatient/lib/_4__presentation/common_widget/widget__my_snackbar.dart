import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/style.dart';

class MySnackBar {
  static show(BuildContext context, String text) {
    var snackBar = SnackBar(
      content: Container(color: Style.colorPrimary, padding: EdgeInsets.only(bottom: 20), child:Text(text)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
