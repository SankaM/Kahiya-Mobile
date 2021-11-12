import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/patient.dart';
import 'package:monda_epatient/_1__model/prescription.dart';
import 'package:monda_epatient/_3__service/service__patient.dart';

class MedicalHistoryController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static MedicalHistoryController get instance => Get.find();

  MedicalHistoryController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();

    retrievePatientDetail();
    retrieveCurrentPrescription();
    retrievePastPrescription();
  }

  void retrievePatientDetail() async {
    StatusWrapper<Status, Patient, String> statusWrapper = await PatientService.instance.retrievePatientDetail();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.patient = statusWrapper.data;
      update();
    } else {
      vReference.patient = null;
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrieveCurrentPrescription() async {
    StatusWrapper<Status, List<Prescription>, String> statusWrapper = await PatientService.instance.retrieveCurrentPrescription();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.currentPrescriptionList.clear();
      vReference.currentPrescriptionList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.currentPrescriptionList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrievePastPrescription() async {
    StatusWrapper<Status, List<Prescription>, String> statusWrapper = await PatientService.instance.retrievePastPrescription();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.pastPrescriptionList.clear();
      vReference.pastPrescriptionList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.pastPrescriptionList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {
  Patient? patient;

  final List<Prescription> currentPrescriptionList = [];

  final List<Prescription> pastPrescriptionList = [];

  @override
  void reset() {
    patient = null;
    currentPrescriptionList.clear();
    pastPrescriptionList.clear();
  }
}

class _ViewInput extends ViewInput {}
