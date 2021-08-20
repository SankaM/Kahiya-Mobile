import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeController extends AbstractController {
  HomeController.newInstance();

  static HomeController get instance => Get.find();

  late List<Patient> patientList;

  bool progressDialogShow = false;

  SearchPatientField field = SearchPatientField.NAME;

  final searchForm = FormGroup({
    'queryValue': FormControl(),
  });

  @override
  void init() {
    reset(doUpdate: false);
  }

  @override
  void reset({bool doUpdate = true}) {
    this.field = SearchPatientField.NAME;
    this.progressDialogShow = false;
    this.searchForm.reset(value: {
      'queryValue':'',
    });
    patientList = [];
    getPatientSummary();
    if(doUpdate) update();
  }

  void getPatientSummary() async {
    StatusWrapper<GetPatientSummaryStatus, List<Patient>, String> statusWrapper = await PatientService.instance.getPatientSummary();

    if(statusWrapper.status == GetPatientSummaryStatus.SUCCESS) {
      this.patientList = statusWrapper.data!;
      update();
    } else {
      this.patientList = [];
      update();
    }
  }

  void getSearchPatient() async {
    String? queryValue = searchForm.control('queryValue').value;
    if(queryValue == null || queryValue.length < 3) {
      getPatientSummary();
      return;
    }

    StatusWrapper<GetSearchPatientStatus, List<Patient>, String> statusWrapper = await PatientService.instance.getSearchPatient(queryValue: queryValue, field: field);

    if(statusWrapper.status == GetSearchPatientStatus.SUCCESS) {
      this.patientList = statusWrapper.data!;
      update();
    } else {
      this.patientList = [];
      update();
    }
  }
}
