import 'package:flutter/material.dart';

class ScreenUtil {
  static bool _alreadyInitialized = false;

  static late final MediaQueryData _mediaQueryData;

  static late final double _realScreenWidth;

  static late final double _realScreenHeight;

  static late final double _blockScreenWidth;

  static late final double _blockScreenHeight;

  static late final double _safeAreaHorizontal;

  static late final double _safeAreaVertical;

  static late final double _safeBlockHorizontal;

  static late final double _safeBlockVertical;

  // ignore: unused_element
  ScreenUtil._();

  ScreenUtil.init(BuildContext context) {
    print('================== textScaleFactor : ${MediaQuery.of(context).textScaleFactor}');
    print('================== devicePixelRatio: ${MediaQuery.of(context).devicePixelRatio}');

    if(!_alreadyInitialized) {
      _mediaQueryData = MediaQuery.of(context);
      _realScreenWidth = _mediaQueryData.size.width;
      _realScreenHeight = _mediaQueryData.size.height;
      _blockScreenWidth = _realScreenWidth / 100;
      _blockScreenHeight = _realScreenHeight / 100;

      _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      _safeBlockHorizontal = (_realScreenWidth - _safeAreaHorizontal) / 100;
      _safeBlockVertical = (_realScreenHeight - _safeAreaVertical) / 100;

      _alreadyInitialized = true;
    }

    print('=================================');
    print('realSCreenWidth     : $_realScreenWidth');
    print('realSCreenHeight    : $_realScreenHeight');
    print('blockSCreenWidth    : $_blockScreenWidth');
    print('blockSCreenHeight   : $_blockScreenHeight');
    print('');
    print('safeAreaHorizontal  : $_safeAreaHorizontal');
    print('safeAreaVertical    : $_safeAreaVertical');
    print('safeBlockHorizontal : $_safeBlockHorizontal');
    print('safeBlockVertical   : $_safeBlockVertical');
    print('=================================');
  }

  static double widthInPercent(double percent) {
    return percent * _safeBlockHorizontal;
  }

  static double heightInPercent(double percent) {
    return percent * _safeBlockVertical;
  }

  static double fontSize(double size) {
    // return size * _safeBlockHorizontal;
    return size * _safeBlockVertical;
  }
}