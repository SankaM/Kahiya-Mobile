import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/controller__notification.dart';
import 'package:monda_epatient/_4__presentation/page/_3__medical_history/controller__medical_history.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/controller__all_appointment.dart';

class Routes {
  static const String page_blank_before_splash = '/blank-before-splash';

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

  static const String page_appointment_all = '/appointment/all';

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
    NotificationController.instance.init();
    return _goto(Routes.page_notification, forgetBefore: false);
  }

  static Future<dynamic> gotoMedicalHistoryPage() {
    MedicalHistoryController.instance.init();
    return _goto(Routes.page_medical_history, forgetBefore: false);
  }

  static Future<dynamic> gotoAllAppointmentPage() {
    AllAppointmentController.instance.init();
    return _goto(Routes.page_appointment_all, forgetBefore: false);
  }

  static Future<dynamic> gotoDoctorProfilePage({required String doctorId, required String doctorName}) {
    var arguments = {
      'doctorId': doctorId,
      'doctorName': doctorName,
    };

    DoctorProfileController.instance.init(data: arguments);
    return _goto(Routes.page_doctor_profile, forgetBefore: false,);
  }

  static Future<dynamic> gotoConfirmAppointmentPage() {
    return _goto(Routes.page_confirm_appointment, forgetBefore: false,);
  }

  static Future<dynamic> gotoPayAndConfirmPage() {
    return _goto(Routes.page_pay_and_confirm, forgetBefore: false,);
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
