import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_1__model/diagnosis.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_3__service/service__prescription.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/controller__home.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddPrescriptionController extends AbstractController {
  static AddPrescriptionController get instance => Get.find();

  // View
  bool progressDialogShow = true;

  String errorMessage = '';

  // Reff Data
  Appointment? appointment;

  List<Diagnosis> diagnosisList = [];

  List<Inventory> availableInventoryList = [];

  // Form
  Patient? patient;

  Diagnosis? selectedDiagnosis;

  String? illnessSeverity;

  Map<int, TreatmentItem> treatmentItemMap = {};

  String? notes;

  File? attachment;

  String? fileName;

  // New Diagnosis Form
  final newDiagnosisForm = FormGroup({
    'name': FormControl<String>(value: '', validators: [Validators.required]),
  });

  void initData({required Patient patient, Appointment? appointment}) async {
    this.patient = patient;
    this.appointment = appointment;

    this.errorMessage = '';
    this.progressDialogShow = true;
    this.selectedDiagnosis = null;
    this.illnessSeverity = null;
    this.treatmentItemMap = {};
    this.treatmentItemMap[DateTime.now().millisecondsSinceEpoch] = TreatmentItem();
    this.notes = '';
    this.attachment = null;
    this.fileName = null;

    var inventoryWrapper = await InventoryService.instance.getAllAvailableInventory();
    if(inventoryWrapper.status == GetAllInventoryStatus.SUCCESS) {
      availableInventoryList.clear();
      availableInventoryList.addAll(inventoryWrapper.data!);
      this.progressDialogShow = false;
      update();
    } else {
      AlertUtil.showMessage('${inventoryWrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }

  void changeDiagnosis(Diagnosis diagnosis) {
    this.selectedDiagnosis = diagnosis;
    update();
  }

  void resetNewDiagnosisForm() {
    this.newDiagnosisForm.reset(value: {'name': ''});
  }

  void createAndSelectDiagnosis() async {
    String diagnosisName = newDiagnosisForm.control('name').value;

    var wrapper = await PrescriptionService.instance.createDiagnosis(name: diagnosisName);
    if(wrapper.status == GetDiagnosisStatus.SUCCESS) {
      changeDiagnosis(wrapper.data!);
      Navigator.pop(Get.context!);
    } else {
      AlertUtil.showMessage('${wrapper.error}',);
      Navigator.pop(Get.context!);
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

  void prescribe() async {
    if(!isDataValid()) {
      return;
    }

    this.progressDialogShow = true;
    update();

    var wrapper = await PatientService.instance.newPrescription(
        patientId: patient!.id,
        diagnosisId: selectedDiagnosis!.id,
        illnessSeverity: illnessSeverity!,
        notes: notes!,
        treatmentItemList: treatmentItemMap.entries.map((entry) => entry.value,).toList(),
        attachmentFile: attachment,
        appointmentId: appointment != null ? appointment!.id : null,
    );

    if(wrapper.status == NewPrescriptionStatus.SUCCESS) {
      AlertUtil.showMessage('New prescription successfully created',);
      progressDialogShow = false;
      update();

      HomeController.instance.init();
      RouteNavigator.gotoHomePage();
    } else {
      AlertUtil.showMessage('${wrapper.error}',);
      progressDialogShow = false;
      update();
    }
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

    // --- Check illness severity
    if(illnessSeverity == null) {
      MySnackBar.show(Get.context!, 'Illness severity is empty');
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

    // --- Check stock enough
    Inventory? inventoryThatStockNotEnough;
    this.treatmentItemMap.forEach((key, value) {
      if(!value.isStockEnough()) {
        inventoryThatStockNotEnough = value.inventory;
      }
    });
    if(inventoryThatStockNotEnough != null) {
      MySnackBar.show(Get.context!, 'Stock of ${inventoryThatStockNotEnough!.drug!.completeName} not enough. Only have ${inventoryThatStockNotEnough!.availableUnits} unit');
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

  bool isStockEnough() {
    int neededStock = treatmentDays! * timesPerDay! * dosageCount!;

    return neededStock <= inventory!.availableUnits!.toInt();
  }

  @override
  String toString() {
    return 'TreatmentItem{drugId: ${inventory!.drug!.completeName}, treatmentDays: $treatmentDays, timesPerDay: $timesPerDay, dosageRule: $dosageRule, dosageCount: $dosageCount}';
  }

  Map toJson() => {
    'inventoryId': inventory!.id,
    'treatmentDays': treatmentDays,
    'timesPerDay': timesPerDay,
    'dosageRule': dosageRule,
    'dosageCount': dosageCount,
  };
}
