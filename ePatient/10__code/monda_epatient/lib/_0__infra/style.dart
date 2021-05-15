import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  static final Color colorPrimary = Color.fromRGBO(255, 160, 113, 1);

  static final Color backgroundColor = Color(0xFFF5F5F5); // Colors.grey[100];

  static final Color textColorPrimary = Colors.white;

  static const double fontSize_XS = 10;

  static const double fontSize_S = 12;

  static const double fontSize_Default = 14;

  static const double fontSize_L = 16;

  static const double fontSize_XL = 18;

  static const double fontSize_2XL = 20;

  static const double fontSize_3XL = 22;

  static const double fontSize_4XL = 24;

  static const double iconSize_Default = 20;

  static const Map<int, Color> colorPalettes =  {
    50:Color.fromRGBO(255, 160, 113, .3),
    100:Color.fromRGBO(255, 160, 113, .4),
    200:Color.fromRGBO(255, 160, 113, .6),
    300:Color.fromRGBO(255, 160, 113, .8),
    400:Color.fromRGBO(255, 160, 113, 1),
    500:Color.fromRGBO(255, 160, 113, 1),
    600:Color.fromRGBO(255, 160, 113, 1),
    700:Color.fromRGBO(255, 160, 113, 1),
    800:Color.fromRGBO(255, 160, 113, 1),
    900:Color.fromRGBO(255, 160, 113, 1),
  };

  static const MaterialColor appMaterialColor = MaterialColor(0xFF880E4F, colorPalettes);
}
