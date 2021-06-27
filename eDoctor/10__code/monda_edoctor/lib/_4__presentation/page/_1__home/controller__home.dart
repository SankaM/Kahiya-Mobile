import 'dart:developer';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/Patient.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';

class HomeController extends AbstractController {
  HomeController.newInstance();

  static HomeController get instance => Get.find();

  late List<Patient> patientList;

  bool progressDialogShow = false;

  @override
  void init() {
    reset(doUpdate: false);
  }

  @override
  void reset({bool doUpdate = true}) {
    patientList = [];
    retrievePatientSummary();
    if(doUpdate) update();
  }

  void retrievePatientSummary() async {
    _changeProgressBarShow(true);

    StatusWrapper<GetPatientSummaryStatus, List<Patient>, String> statusWrapper = await PatientService.instance.getPatientSummary();
    switch (statusWrapper.status) {
      case GetPatientSummaryStatus.SUCCESS:
        {
          this.patientList = statusWrapper.data!;
          _changeProgressBarShow(false);
          break;
        }
      case GetPatientSummaryStatus.ERROR:
        {
          this.patientList = [];
          _changeProgressBarShow(false);
          break;
        }
      default:
        {
          this.patientList = [];
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
