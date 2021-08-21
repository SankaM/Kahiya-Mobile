import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MedicalRecordController extends AbstractController {
  MedicalRecordController.newInstance();

  static MedicalRecordController get instance => Get.find();

  bool progressDialogShow = false;

  Patient? patient;

  List<Prescription>? prescriptionList;

  final updateHealthProfileForm = FormGroup({
    'healthProfile': FormControl<String>(validators: [Validators.required]),
  });

  @override
  void reset({bool doUpdate = true}) {
    this.progressDialogShow = false;
    if(doUpdate) update();
  }

  void retrieveData({required String patientId}) async {
    _changeProgressBarShow(true);

    await _retrievePatient(patientId: patientId);
    await _retrievePrescription(patientId: patientId);

    _changeProgressBarShow(false);
  }

  Future<void> _retrievePatient({required String patientId}) async {
    StatusWrapper<GetPatientStatus, Patient, String> statusWrapper = await PatientService.instance.getPatient(patientId: patientId);

    if(statusWrapper.status == GetPatientStatus.SUCCESS) {
      this.patient = statusWrapper.data;
      this.updateHealthProfileForm.control('healthProfile').value = this.patient!.healthProfile != null ? this.patient!.healthProfile : '';
    } else {
      AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.error.toString() : TextString.label__error);
    }
  }

  Future<void> _retrievePrescription({required String patientId}) async {
    StatusWrapper<GetPrescriptionStatus, List<Prescription>, String> statusWrapper = await PatientService.instance.getPrescriptionByPatient(patientId: patientId);

    if(statusWrapper.status == GetPrescriptionStatus.SUCCESS) {
      this.prescriptionList = statusWrapper.data;
    } else {
      AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.error.toString() : TextString.label__error);
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }

  void updateHealthProfile() async {
    log('=============================== Update Health Profile');
    this.progressDialogShow = true;
    update();

    String healthProfile = updateHealthProfileForm.control('healthProfile').value;

    var wrapper = await PatientService.instance.updatePatientProfileHealth(
      patientId: patient!.id,
      healthProfile: healthProfile,
    );

    if(wrapper.status == PatientUpdateProfileHealthStatus.SUCCESS) {
      progressDialogShow = false;
      patient!.healthProfile = healthProfile;
      update();

      AlertUtil.showMessage('Health profile updated',);
      Navigator.pop(Get.context!);
    } else {
      progressDialogShow = false;
      update();

      AlertUtil.showMessage('${wrapper.error}',);
      Navigator.pop(Get.context!);
    }
  }
}
