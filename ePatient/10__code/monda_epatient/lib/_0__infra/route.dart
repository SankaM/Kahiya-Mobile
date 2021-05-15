import 'dart:async';

import 'package:get/get.dart';

class Routes {
  static const String page_splash = '/splash';

  static const String page_login = '/login';

  static const String page_home = '/home';

  static const String page_notification = '/notification';

  static const String page_medical_history = '/medical-history';
}

class RouteNavigator {
  // -------------------------------------------------------------------- Splash
  static Future<dynamic> gotoSplashPage() {
    return _goto(Routes.page_splash, forgetBefore: true);
  }

  static Future<dynamic> gotoLoginPage() {
    return _goto(Routes.page_login, forgetBefore: true);
  }

  static Future<dynamic> gotoHomePage() {
    return _goto(Routes.page_home, forgetBefore: true);
  }

  static Future<dynamic> gotoNotificationPage() {
    return _goto(Routes.page_notification, forgetBefore: true);
  }

  static Future<dynamic> gotoMedicalHistoryPage() {
    return _goto(Routes.page_medical_history, forgetBefore: true);
  }

  // -------------------------------------------------------------------- helper
  static Future<dynamic> _goto(String route, {bool forgetBefore = false, dynamic arguments}) {
    var completer = Completer<dynamic>();

    if (forgetBefore) {
      completer.complete(Get.offAllNamed(route, arguments: arguments));
    } else {
      completer.complete(Get.toNamed(route, arguments: arguments));
    }

    return completer.future;
  }
}
