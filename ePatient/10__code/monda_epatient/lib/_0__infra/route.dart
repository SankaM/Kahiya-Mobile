import 'dart:async';

import 'package:get/get.dart';

class Routes {
  static const String page_splash = '/splash';

  static const String page_signin_or_signup = '/signin-or-signup';
  
  static const String page_signin = '/signin';

  static const String page_signup = '/signup';

  static const String page_home = '/home';

  static const String page_notification = '/notification';

  static const String page_medical_history = '/medical-history';

  static const String page_doctor_profile = '/doctor-profile';

  static const String page_confirm_appointment = '/confirm-appointment';

  static const String page_pay_and_confirm = '/pay-and-confirm';
}

class RouteNavigator {
  // -------------------------------------------------------------------- Splash
  static Future<dynamic> gotoSplashPage() {
    return _goto(Routes.page_splash, forgetBefore: true);
  }

  static Future<dynamic> gotoSignInOrSignUpPage() {
    return _goto(Routes.page_signin_or_signup, forgetBefore: true);
  }

  static Future<dynamic> gotoSignInPage() {
    return _goto(Routes.page_signin, forgetBefore: true);
  }

  static Future<dynamic> gotoSignUpPage() {
    return _goto(Routes.page_signup, forgetBefore: true);
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

  static Future<dynamic> gotoDoctorProfilePage(
      {required String assetImage,
      required String firstLineText,
      required String secondLineText,
      required String thirdLineText,
      required String assetIcon}) {
    var arguments = {
      'assetImage': assetImage,
      'firstLineText': firstLineText,
      'secondLineText': secondLineText,
      'thirdLineText': thirdLineText,
      'assetIcon': assetIcon,
    };

    return _goto(Routes.page_doctor_profile, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoConfirmAppointmentPage({required String assetImage, required doctorName}) {
    var arguments = {
      'assetImage': assetImage,
      'doctorName': doctorName,
    };

    return _goto(Routes.page_confirm_appointment, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoPayAndConfirmPage() {
    return _goto(Routes.page_pay_and_confirm, forgetBefore: false);
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
