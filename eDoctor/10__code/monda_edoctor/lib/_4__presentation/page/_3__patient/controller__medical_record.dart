
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

  String prescriptionLabel = 'Prescription';

  List<Prescription>? currentPrescriptionList;

  List<Prescription>? lastPrescriptionList;

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
    await _retrieveCurrentPrescription(patientId: patientId);
    await _retrieveLastPrescription(patientId: patientId);

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

  Future<void> _retrieveCurrentPrescription({required String patientId}) async {
    var wrapperCurrentPrescription = await PatientService.instance.getCurrentPrescriptionByPatient(patientId: patientId);

    if(wrapperCurrentPrescription.status == GetPrescriptionListStatus.SUCCESS) {
      this.currentPrescriptionList = wrapperCurrentPrescription.data;
    } else {
      AlertUtil.showMessage(wrapperCurrentPrescription.data != null ? wrapperCurrentPrescription.error.toString() : TextString.label__error);
    }
  }

  Future<void> _retrieveLastPrescription({required String patientId}) async {
    var wrapperLastPrescription = await PatientService.instance.getLastPrescriptionByPatient(patientId: patientId);

    if(wrapperLastPrescription.status == GetPrescriptionListStatus.SUCCESS) {
      this.lastPrescriptionList = wrapperLastPrescription.data;
    } else {
      AlertUtil.showMessage(wrapperLastPrescription.data != null ? wrapperLastPrescription.error.toString() : TextString.label__error);
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }

  void updateHealthProfile() async {
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
