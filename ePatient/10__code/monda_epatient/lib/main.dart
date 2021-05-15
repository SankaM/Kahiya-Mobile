import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signin.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signin_or_signup.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signup.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__splash.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/page__home.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/page__invoice.dart';
import 'package:monda_epatient/_4__presentation/page/_3__medical_history/page__medical_history.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    Phoenix(
      child: MondaEDoctorApp(),
    ),
  );
}

class MondaEDoctorApp extends StatelessWidget {
  Future<void> _onInit() async {
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GetMaterialApp(
        onInit: _onInit,
        title: TextString.app_name,
        initialRoute: Routes.page_splash,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Style.appMaterialColor,
          backgroundColor: Style.backgroundColor,

        ),
        getPages: [
          // --------------------------------------------------------- 0. Splash
          GetPage(name: Routes.page_splash, page: () => SplashPage(),),

          GetPage(name: Routes.page_signin_or_signup, page: () => SigninOrSignupPage(),),

          GetPage(name: Routes.page_signin, page: () => SigninPage(),),

          GetPage(name: Routes.page_signup, page: () => SignupPage(),),

          // ----------------------------------------------------------- 1. Home
          GetPage(name: Routes.page_home, page: () => HomePage(),),

          // --------------------------------------------------- 2. Notification
          GetPage(name: Routes.page_notification, page: () => NotificationPage(),),

          // ------------------------------------------------ 3. Medical History
          GetPage(name: Routes.page_medical_history, page: () => MedicalHistoryPage(),),
        ],
    );
  }
}
