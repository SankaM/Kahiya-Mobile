import 'package:flutter/material.dart';

class MySnackBar {
  static show(BuildContext context, String text,) {
    var snackBar = SnackBar(
      content: Container(padding: EdgeInsets.only(bottom: 20), child:Text(text)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
