class StringUtil {
  StringUtil._();

  static String? capitalize(String? s) {
    if(s != null && s.length > 0) {
      return (s[0].toUpperCase() + s.substring(1).toLowerCase());
    }

    return null;
  }
}
