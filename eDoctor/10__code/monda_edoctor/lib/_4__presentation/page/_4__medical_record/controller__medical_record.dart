import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';

class MedicalRecordController extends AbstractController {
  MedicalRecordController.newInstance();

  static MedicalRecordController get instance => Get.find();

  bool progressDialogShow = false;

  Patient? patient;

  List<Prescription>? prescriptionList;

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
    } else {
      AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.error.toString() : TextString.label__error);
    }
  }

  Future<void> _retrievePrescription({required String patientId}) async {
    StatusWrapper<GetPrescriptionStatus, List<Prescription>, String> statusWrapper = await PatientService.instance.getPrescription(patientId: patientId);

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
}
