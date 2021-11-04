
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_3__service/service__doctor.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static HomeController get instance => Get.find();

  HomeController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();

    retrieveAllDoctors();
  }

  void retrieveAllDoctors() async {
    StatusWrapper<Status, List<Doctor>, String> statusWrapper = await DoctorService.instance.findAll();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.doctorList.clear();
      vReference.doctorList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.doctorList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void searchDoctors() async {
    String? queryValue = vInput.searchForm.control('queryValue').value;
    if(queryValue == null || queryValue.length == 0) {
      retrieveAllDoctors();
      return;
    }

    StatusWrapper<Status, List<Doctor>, String> statusWrapper = await DoctorService.instance.searchDoctors(queryValue: queryValue, field: vInput.field);

    if(statusWrapper.status == Status.SUCCESS) {
      vReference.doctorList.clear();
      vReference.doctorList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.doctorList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {
  final List<Doctor> doctorList = [];

  @override
  void reset() {
    doctorList.clear();
  }
}

class _ViewInput extends ViewInput {
  SearchDoctorField field = SearchDoctorField.NAME;

  final searchForm = FormGroup({
    'queryValue': FormControl(),
  });

  @override
  void reset() {
    searchForm.reset(value: {'queryValue': ''});
  }
}
