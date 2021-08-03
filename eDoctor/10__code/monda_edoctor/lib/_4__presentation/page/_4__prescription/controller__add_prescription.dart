import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/diagnosis.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_3__service/service__prescription.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';

class AddPrescriptionController extends AbstractController {
  static AddPrescriptionController get instance => Get.find();

  // View
  bool progressDialogShow = true;

  String errorMessage = '';

  // Reff Data
  List<Diagnosis> diagnosisList = [];

  List<Inventory> inventoryList = [];

  // Form
  Patient? patient;

  //String? selectedDiagnosisId;
  Diagnosis? selectedDiagnosis;

  Map<int, TreatmentItem> treatmentItemMap = {};

  String? notes;

  File? attachment;

  String? fileName;

  void initData({required Patient patient}) async {
    this.errorMessage = '';
    this.patient = patient;
    this.progressDialogShow = true;
    this.selectedDiagnosis = null;
    this.treatmentItemMap = {};
    this.treatmentItemMap[DateTime.now().millisecondsSinceEpoch] = TreatmentItem();
    this.notes = '';
    this.attachment = null;
    this.fileName = null;

    var diagnosisWrapper = await PrescriptionService.instance.getDiagnosis();
    if(diagnosisWrapper.status == GetDiagnosisStatus.SUCCESS) {
      diagnosisList.clear();
      diagnosisList.addAll(diagnosisWrapper.data!);
      update();
    } else {
      AlertUtil.showMessage('${diagnosisWrapper.error}',);
      update();
    }

    var inventoryWrapper = await InventoryService.instance.getAllInventory();
    if(inventoryWrapper.status == GetAllInventoryStatus.SUCCESS) {
      inventoryList.clear();
      inventoryList.addAll(inventoryWrapper.data!);
      this.progressDialogShow = false;
      update();
    } else {
      AlertUtil.showMessage('${inventoryWrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }

  void addTreatmentItem() {
    this.treatmentItemMap[DateTime.now().millisecondsSinceEpoch] = TreatmentItem();
    update();
  }

  void removeTreatmentItem(int key) {
    this.treatmentItemMap.remove(key);
    update();
  }

  void updateTreatmentItemInventory(int key, Inventory inventory) {
    this.treatmentItemMap[key]!.inventory = inventory;
  }

  void updateTreatmentItemTreatmentDays(int key, int treatmentDays) {
    this.treatmentItemMap[key]!.treatmentDays = treatmentDays;
  }

  void updateTreatmentItemTimesPerDay(int key, int timesPerDay) {
    this.treatmentItemMap[key]!.timesPerDay = timesPerDay;
  }

  void updateTreatmentItemDosageRule(int key, String dosageRule) {
    this.treatmentItemMap[key]!.dosageRule = dosageRule;
  }

  void updateTreatmentItemDosageCount(int key, int dosageCount) {
    this.treatmentItemMap[key]!.dosageCount = dosageCount;
  }

  bool isLastTreatmentItem(int key) {
    if(treatmentItemMap.isEmpty) {
      return false;
    }

    var keyList = treatmentItemMap.keys.toList();
    if(keyList[keyList.length - 1] == key) {
      return true;
    } else {
      return false;
    }
  }

  bool isFirstTreatmentItem(int key) {
    if(treatmentItemMap.isEmpty) {
      return false;
    }

    var keyList = treatmentItemMap.keys.toList();
    if(keyList[0] == key) {
      return true;
    } else {
      return false;
    }
  }

  void attachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result != null) {
      attachment = File(result.files.single.path!);
      fileName = result.files.first.name;

      update();
    }
  }

  void removeFile() {
    attachment = null;
    update();
  }

  void nextPage() {
    if(!isDataValid()) {
      return;
    }

    log('================================================ patientId   : ${patient!.id}');
    log('================================================ diagnosisId : ${selectedDiagnosis!.id}');
    log('================================================ notes       : $notes');
    this.treatmentItemMap.forEach((key, value) {
      log('\t================================================ treatmentItem : $value');
    });

    RouteNavigator.gotoInvoicePage();
  }

  bool isDataValid() {
    // --- Check patient
    if(patient == null) {
      MySnackBar.show(Get.context!, 'Patient is empty');
      return false;
    }

    // --- Check selected diagnosis
    if(selectedDiagnosis == null) {
      MySnackBar.show(Get.context!, 'Diagnosis is empty');
      return false;
    }

    // --- Check treatment items
    bool errorOnTreatmentItem = false;
    this.treatmentItemMap.forEach((key, value) {
      if(!value.isValid()) {
        errorOnTreatmentItem = true;
      }
    });
    if(errorOnTreatmentItem) {
      MySnackBar.show(Get.context!, 'Please fix treatment item data');
      return false;
    }

    // --- Check notes
    if(notes == null || notes!.isEmpty) {
      MySnackBar.show(Get.context!, 'Notes is empty');
      return false;
    }

    // No Error at all
    this.errorMessage = '';
    update();
    return true;
  }
}

class TreatmentItem {
  Inventory? inventory;

  int? treatmentDays;

  int? timesPerDay;

  String? dosageRule;

  int? dosageCount;

  bool isValid() {
    if(inventory != null && treatmentDays != null && timesPerDay != null && dosageRule != null && dosageCount != null) {
      return true;
    }

    return false;
  }

  @override
  String toString() {
    return 'TreatmentItem{drugId: ${inventory!.drug!.completeName}, treatmentDays: $treatmentDays, timesPerDay: $timesPerDay, dosageRule: $dosageRule, dosageCount: $dosageCount}';
  }
}
