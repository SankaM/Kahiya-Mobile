import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';

class Style {
  static const  Color colorPrimary = Color.fromRGBO(255, 160, 113, 1);

  static const  Color colorPrimary2 = Color.fromRGBO(248, 138, 76, 1);

  static const Color backgroundColor = const Color(0xFFF5F5F5); // Colors.grey[100];

  static const Color textColorPrimary = const Color(0xFFFFFFFF);

  // ignore: non_constant_identifier_names
  static double get fontSize_XS {
    return ScreenUtil.fontSize(3);
  }

  // ignore: non_constant_identifier_names
  static double get fontSize_S {
    return ScreenUtil.fontSize(3.5);
  }

  // ignore: non_constant_identifier_names
  static double get fontSize_Default {
    return ScreenUtil.fontSize(4);
  }

  // ignore: non_constant_identifier_names
  static double get fontSize_L {
    return ScreenUtil.fontSize(4.5);
  }

  // ignore: non_constant_identifier_names
  static double get fontSize_XL {
    return ScreenUtil.fontSize(5);
  }

  static double get fontSize_2XL {
    return ScreenUtil.fontSize(5.5);
  }

  static double get fontSize_3XL {
    return ScreenUtil.fontSize(6);
  }

  static double get fontSize_4XL {
    return ScreenUtil.fontSize(6.5);
  }

  static double get fontSize_5XL {
    return ScreenUtil.fontSize(7);
  }

  static double get fontSize_6XL {
    return ScreenUtil.fontSize(7.5);
  }

  static double get fontSize_7XL {
    return ScreenUtil.fontSize(8);
  }

  static double get fontSize_8XL {
    return ScreenUtil.fontSize(8.5);
  }

  static const double iconSize_S = 16;

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

  static TextStyle defaultTextStyle({double? fontSize, Color color = Style.textColorPrimary, FontWeight fontWeight = FontWeight.w400, double letterSpacing = 0}) {
    if(fontSize == null) fontSize = Style.fontSize_Default;
    return GoogleFonts.montserrat(fontSize: fontSize, color: color, fontWeight: fontWeight, letterSpacing: letterSpacing);
  }
}
