import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_2__datasource/api/api__account.dart';
import 'package:monda_edoctor/_2__datasource/api/api__diagnosis.dart';
import 'package:monda_edoctor/_2__datasource/api/api__drug.dart';
import 'package:monda_edoctor/_2__datasource/api/api__inventory.dart';
import 'package:monda_edoctor/_2__datasource/api/api__patient.dart';
import 'package:monda_edoctor/_2__datasource/api/api__prescription.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_edoctor/_3__service/service__account.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_3__service/service__prescription.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/controller__signin.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__blank_before_splash.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__signin.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__splash.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/controller__home.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/page__home.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_add.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_detail.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_update.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/page__inventory.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/page__inventory_add.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/page__inventory_detail.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/page__inventory_update.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__patient/controller__medical_record.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__patient/controller__patient_register.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__patient/page__medical_record.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__patient/page__patient_register.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__add_prescription.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__invoice.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__invoice_detail.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/page__add_prescription.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/page__invoice.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/page__invoice_detail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
    Get.put(InventoryApi.newInstance());
    Get.put(DrugApi.newInstance());
    Get.put(DiagnosisApi.newInstance());
    Get.put(PrescriptionApi.newInstance());

    // Secure Storage
    Get.put(UserSecureStorage.newInstance());
    UserSecureStorage.instance.init();

    // Service
    Get.put(AccountService.newInstance());
    Get.put(PatientService.newInstance());
    Get.put(InventoryService.newInstance());
    Get.put(PrescriptionService.newInstance());

    // Controller
    Get.put(SignInController.newInstance());
    Get.put(HomeController.newInstance());
    Get.put(MedicalRecordController.newInstance());

    Get.put(PatientRegisterController());
    Get.put(AddPrescriptionController());
    Get.put(InvoiceDetailController());
    Get.put(InventoryController());
    Get.put(AddInventoryController());
    Get.put(UpdateInventoryController());
    Get.put(DetailInventoryController());
    Get.put(InvoiceController());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: _onInit,
      title: TextString.app_name,
      initialRoute: Routes.page_blank_before_splash,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Style.appMaterialColor,
        backgroundColor: Style.backgroundColor,
        primaryColorLight: Style.colorPrimary,
      ),
      getPages: [
        // ----------------------------------------------------------- 0. Splash
        GetPage(name: Routes.page_blank_before_splash, page: () => BlankBeforeSplashPage(),),

        GetPage(name: Routes.page_splash, page: () => SplashPage(),),

        GetPage(name: Routes.page_signin, page: () => SignInPage(),),

        // ------------------------------------------------------------- 1. Home
        GetPage(name: Routes.page_home, page: () => HomePage(),),

        // ---------------------------------------------------------- 2. Invoice
        GetPage(name: Routes.page_invoice_list, page: () => InvoicePage(),),

        GetPage(name: Routes.page_invoice_detail, page: () => InvoiceDetailPage(),),

        // -------------------------------------------------------- 3. Inventory
        GetPage(name: Routes.page_inventory, page: () => InventoryPage(),),
        GetPage(name: Routes.page_add_inventory, page: () => AddInventoryPage(),),
        GetPage(name: Routes.page_detail_inventory, page: () => DetailInventoryPage(),),
        GetPage(name: Routes.page_update_inventory, page: () => UpdateInventoryPage(),),

        // --------------------------------------------------- 4. Medical Record
        GetPage(name: Routes.page_medical_record, page: () => MedicalRecordPage(),),

        // ---------------------------------------------------------- 5. Patient
        GetPage(name: Routes.page_patient_register, page: () => RegisterPatientPage(),),

        // ------------------------------------------------- 6. Add Prescription
        GetPage(name: Routes.page_add_prescription, page: () => AddPrescriptionPage(),),
      ],
    );
  }
}
