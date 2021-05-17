import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static const  Color colorPrimary = Color.fromRGBO(255, 160, 113, 1);

  static const  Color colorPrimary2 = Color.fromRGBO(248, 138, 76, 1);

  static const Color backgroundColor = const Color(0xFFF5F5F5); // Colors.grey[100];

  static const Color textColorPrimary = const Color(0xFFFFFFFF);

  static const double fontSize_XS = 10;

  static const double fontSize_S = 12;

  static const double fontSize_Default = 14;

  static const double fontSize_L = 16;

  static const double fontSize_XL = 18;

  static const double fontSize_2XL = 20;

  static const double fontSize_3XL = 22;

  static const double fontSize_4XL = 24;

  static const double fontSize_5XL = 26;

  static const double fontSize_6XL = 28;

  static const double fontSize_7XL = 30;

  static const double fontSize_8XL = 32;

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

  static TextStyle defaultTextStyle({double fontSize = Style.fontSize_Default, Color color = Style.textColorPrimary, FontWeight fontWeight = FontWeight.w400, double letterSpacing = 0}) {
    return GoogleFonts.montserrat(fontSize: fontSize, color: color, fontWeight: fontWeight, letterSpacing: letterSpacing);
  }
}
