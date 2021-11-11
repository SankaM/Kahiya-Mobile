import 'package:intl/intl.dart';

class StringUtil {
  StringUtil._();

  static final _numberFormat = new NumberFormat("#,##0.00");

  static String? capitalize(String? s) {
    if(s != null && s.length > 0) {
      return (s[0].toUpperCase() + s.substring(1).toLowerCase());
    }

    return null;
  }

  static String formatDouble(double d) {
    return _numberFormat.format(d);
  }
}
