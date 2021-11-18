import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_2__datasource/api/api__account.dart';
import 'package:monda_epatient/_2__datasource/api/api__appointment.dart';
import 'package:monda_epatient/_2__datasource/api/api__diagnosis.dart';
import 'package:monda_epatient/_2__datasource/api/api__doctor.dart';
import 'package:monda_epatient/_2__datasource/api/api__drug.dart';
import 'package:monda_epatient/_2__datasource/api/api__patient.dart';
import 'package:monda_epatient/_2__datasource/api/api__payment.dart';
import 'package:monda_epatient/_2__datasource/api/api__prescription.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_epatient/_3__service/service__account.dart';
import 'package:monda_epatient/_3__service/service__appointment.dart';
import 'package:monda_epatient/_3__service/service__doctor.dart';
import 'package:monda_epatient/_3__service/service__patient.dart';
import 'package:monda_epatient/_3__service/service__payment.dart';
import 'package:monda_epatient/_3__service/service__prescription.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/controller__signin.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/controller__signup.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__blank_before_splash.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signin.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signin_or_signup.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__signup.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/page__splash.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/controller__home.dart';
import 'package:monda_epatient/_4__presentation/page/_1__home/page__home.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/controller__notification.dart';
import 'package:monda_epatient/_4__presentation/page/_2__notification/page__notification.dart';
import 'package:monda_epatient/_4__presentation/page/_3__medical_history/controller__medical_history.dart';
import 'package:monda_epatient/_4__presentation/page/_3__medical_history/page__medical_history.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/controller__doctor_profile.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/page__confirm_appointment.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/page__doctor_profile.dart';
import 'package:monda_epatient/_4__presentation/page/_4__doctor/page__pay_and_confirm.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/controller__all_appointment.dart';
import 'package:monda_epatient/_4__presentation/page/_5__appointment/page__all_appointment.dart';
import 'package:monda_epatient/_8__notif/local_notification_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationApi.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return runApp(
      Phoenix(
        child: MondaEPatientApp(),
      ),
    );
  });
}

class MondaEPatientApp extends StatelessWidget {
  Future<void> _onInit() async {
    // API
    Get.put(AccountApi.newInstance());
    Get.put(PatientApi.newInstance());
    Get.put(DrugApi.newInstance());
    Get.put(DiagnosisApi.newInstance());
    Get.put(DoctorApi.newInstance());
    Get.put(AppointmentApi.newInstance());
    Get.put(PaymentApi.newInstance());
    Get.put(PrescriptionApi.newInstance());

    // Secure Storage
    Get.put(UserSecureStorage.newInstance());
    UserSecureStorage.instance.init();

    // Service
    Get.put(AccountService.newInstance());
    Get.put(AppointmentService.newInstance());
    Get.put(PatientService.newInstance());
    Get.put(PrescriptionService.newInstance());
    Get.put(DoctorService.newInstance());
    Get.put(PaymentService.newInstance());
    Get.put(PrescriptionService.newInstance());

    // Initialize all controller
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(HomeController());
    Get.put(DoctorProfileController());
    Get.put(AllAppointmentController());
    Get.put(MedicalHistoryController());
    Get.put(NotificationController());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: _onInit,
      title: TextString.app_name,
      initialRoute: Routes.page_blank_before_splash,
      // initialRoute: Routes.page_appointment_all,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Style.appMaterialColor,
        backgroundColor: Style.backgroundColor,
        primaryColorLight: Style.colorPrimary,
      ),
      getPages: [
          // --------------------------------------------------------- 0. Splash
          GetPage(name: Routes.page_blank_before_splash, page: () => BlankBeforeSplashPage(),),

          GetPage(name: Routes.page_splash, page: () => SplashPage(),),

          GetPage(name: Routes.page_signin_or_signup, page: () => SigninOrSignupPage(),),

          GetPage(name: Routes.page_signin, page: () => SignInPage(),),

          GetPage(name: Routes.page_signup, page: () => SignupPage(),),

          // ----------------------------------------------------------- 1. Home
          GetPage(name: Routes.page_home, page: () => HomePage(),),

          // --------------------------------------------------- 2. Notification
          GetPage(name: Routes.page_notification, page: () => NotificationPage(),),

          // ------------------------------------------------ 3. Medical History
          GetPage(name: Routes.page_medical_history, page: () => MedicalHistoryPage(),),

          // ------------------------------------------------- 4. Doctor Profile
          GetPage(name: Routes.page_doctor_profile, page: () => DoctorProfilePage(),),

          GetPage(name: Routes.page_confirm_appointment, page: () => ConfirmAppointmentPage(),),

          // -------------------------------------------------------- 5. Payment
          GetPage(name: Routes.page_pay_and_confirm, page: () => PayAndConfirmPage(),),

          // ---------------------------------------------------- 6. Appointment
          GetPage(name: Routes.page_appointment_all, page: () => AllAppointmentPage(),),
        ],
    );
  }
}
