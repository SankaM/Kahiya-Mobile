
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/Patient.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeController extends AbstractController {
  HomeController.newInstance();

  static HomeController get instance => Get.find();

  late List<Patient> patientList;

  bool progressDialogShow = false;

  final searchForm = FormGroup({
    'queryValue': FormControl(),
  });

  @override
  void init() {
    reset(doUpdate: false);
  }

  @override
  void reset({bool doUpdate = true}) {
    this.progressDialogShow = false;
    this.searchForm.reset(value: {
      'queryValue':'',
    });
    patientList = [];
    getPatientSummary();
    if(doUpdate) update();
  }

  void getPatientSummary() async {
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

  void getSearchPatient() async {
    String? queryValue = searchForm.control('queryValue').value;
    if(queryValue == null || queryValue.isEmpty) {
      getPatientSummary();
      return;
    }

    _changeProgressBarShow(true);


    StatusWrapper<GetSearchPatientStatus, List<Patient>, String> statusWrapper = await PatientService.instance.getSearchPatient(queryValue: queryValue);
    switch (statusWrapper.status) {
      case GetSearchPatientStatus.SUCCESS:
        {
          this.patientList = statusWrapper.data!;
          _changeProgressBarShow(false);
          break;
        }
      case GetSearchPatientStatus.ERROR:
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
