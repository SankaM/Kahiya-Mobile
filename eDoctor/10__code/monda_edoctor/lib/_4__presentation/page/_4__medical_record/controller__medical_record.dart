import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';

class MedicalRecordController extends AbstractController {
  MedicalRecordController.newInstance();

  static MedicalRecordController get instance => Get.find();

  bool progressDialogShow = false;

  Patient? patient;

  @override
  void reset({bool doUpdate = true}) {
    this.progressDialogShow = false;
    if(doUpdate) update();
  }

  void retrievePatient({required String patientId}) async {
    _changeProgressBarShow(true);

    StatusWrapper<GetPatientStatus, Patient, String> statusWrapper = await PatientService.instance.getPatient(patientId: patientId);

    switch (statusWrapper.status) {
      case GetPatientStatus.SUCCESS:
        {
          this.patient = statusWrapper.data;
          _changeProgressBarShow(false);

          break;
        }
      case GetPatientStatus.ERROR:
        {
          AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.error.toString() : TextString.label__error);
          _changeProgressBarShow(false);
          break;
        }
      default:
        {
          _changeProgressBarShow(false);
          break;
        }
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}
