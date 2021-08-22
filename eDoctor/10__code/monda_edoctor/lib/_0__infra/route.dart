import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/inventoryBatch.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_4__presentation/page/_5__account/controller__appointment_list.dart';

class Routes {
  static const String page_blank_before_splash = '/blank-before-splash';

  static const String page_splash = '/splash';

  static const String page_signin = '/signin';

  static const String page_home = '/home';

  static const String page_invoice_detail = '/invoice-detail';

  static const String page_invoice_list = '/invoice-list';

  static const String page_inventory = '/inventory';

  static const String page_add_inventory = '/inventory/add';

  static const String page_detail_inventory = '/inventory/detail';

  static const String page_update_inventory_batch = '/inventory/batch/update';

  static const String page_medical_record = '/medical-record';

  static const String page_patient_register = '/patient/register';

  static const String page_add_prescription = '/add-prescription';

  static const String page_account = '/account';

  static const String page_appointment = '/appointment';

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

  static Future<dynamic> gotoInvoiceListPage() {
    return _goto(Routes.page_invoice_list, forgetBefore: false,);
  }

  static Future<dynamic> gotoInvoiceDetailPage({required String prescriptionId}) {
    var arguments = {
      'prescriptionId': prescriptionId,
    };
    return _goto(Routes.page_invoice_detail, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoInventoryPage() {
    return _goto(Routes.page_inventory, forgetBefore: false);
  }

  static Future<dynamic> gotoMedicalRecordPage({required String patientId, bool forgetBefore = false}) {
    var arguments = {
      'patientId': patientId,
    };
    return _goto(Routes.page_medical_record, forgetBefore: forgetBefore, arguments: arguments);
  }

  static Future<dynamic> gotoRegisterPatientPage() {
    return _goto(Routes.page_patient_register, forgetBefore: false);
  }

  static Future<dynamic> gotoAddPrescriptionPage({required Patient patient}) {
    var arguments = {
      'patient': patient,
    };
    return _goto(Routes.page_add_prescription, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoAddInventoryPage() {
    return _goto(Routes.page_add_inventory, forgetBefore: false);
  }

  static Future<dynamic> gotoDetailInventoryPage({required String inventoryId}) {
    var arguments = {
      'inventoryId': inventoryId,
    };
    return _goto(Routes.page_detail_inventory, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoUpdateInventoryBatchPage({required Inventory inventory, required InventoryBatch inventoryBatch}) {
    var arguments = {
      'inventory': inventory,
      'inventoryBatch': inventoryBatch,
    };
    return _goto(Routes.page_update_inventory_batch, forgetBefore: false, arguments: arguments);
  }

  static Future<dynamic> gotoAccountPage() {
    return _goto(Routes.page_account, forgetBefore: false);
  }

  static Future<dynamic> gotoAppointmentPage({required AppointmentListType type}) {
    return _goto(Routes.page_appointment, forgetBefore: false, arguments: type);
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
