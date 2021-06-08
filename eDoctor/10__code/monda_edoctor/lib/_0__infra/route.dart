import 'dart:async';

import 'package:get/get.dart';

class Routes {
  static const String page_blank_before_splash = '/blank-before-splash';

  static const String page_splash = '/splash';

  static const String page_signin = '/signin';

  static const String page_home = '/home';

  static const String page_invoice = '/invoice';

  static const String page_inventory = '/inventory';

  static const String page_medical_record = '/medical-record';

  Routes._();
}

class RouteNavigator {
  // -------------------------------------------------------------------- Splash
  static Future<dynamic> gotoBlankBeforeSplashPage() {
    return _goto(Routes.page_blank_before_splash, forgetBefore: true);
  }

  static Future<dynamic> gotoSplashPage() {
    return _goto(Routes.page_splash, forgetBefore: true);
  }

  static Future<dynamic> gotoSignInPage() {
    return _goto(Routes.page_signin, forgetBefore: true);
  }

  static Future<dynamic> gotoHomePage() {
    return _goto(Routes.page_home, forgetBefore: true);
  }

  static Future<dynamic> gotoInvoicePage() {
    return _goto(Routes.page_invoice, forgetBefore: true);
  }

  static Future<dynamic> gotoInventoryPage() {
    return _goto(Routes.page_inventory, forgetBefore: true);
  }

  static Future<dynamic> gotoMedicalRecordPage() {
    return _goto(Routes.page_medical_record, forgetBefore: false);
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

  RouteNavigator._();
}
