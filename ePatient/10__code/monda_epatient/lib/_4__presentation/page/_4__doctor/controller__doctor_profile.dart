import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/doctor_statistic.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';
import 'package:monda_epatient/_3__service/service__doctor.dart';

class DoctorProfileController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static DoctorProfileController get instance => Get.find();

  DoctorProfileController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();


    if(data != null) {
      vReference.doctorId = data;
      retrieveDoctorProfile();
      retrieveDoctorWorkHours();
      retrieveDoctorStatistics();
    }
  }

  void retrieveDoctorProfile() async {
    StatusWrapper<Status, Doctor, String> statusWrapper = await DoctorService.instance.doctorProfile(doctorId: vReference.doctorId!);

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.doctor = statusWrapper.data!;
      update();
    } else {
      vReference.doctor = null;
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrieveDoctorWorkHours() async {
    StatusWrapper<Status, List<WorkHour>, String> statusWrapper = await DoctorService.instance.doctorWorkHours(doctorId: vReference.doctorId!);

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.workHours.clear();
      vReference.workHours.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.workHours.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrieveDoctorStatistics() async {
    StatusWrapper<Status, DoctorStatistic, String> statusWrapper = await DoctorService.instance.doctorStatistic(doctorId: vReference.doctorId!);

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.doctorStatistic = statusWrapper.data!;
      update();
    } else {
      vReference.doctorStatistic = null;
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  WorkHour? findWorkHour(String dayOfWeek) {
    if(vReference.workHours.isEmpty) {
      return null;
    }

    for(var workHour in vReference.workHours) {
      if(workHour.dayOfWeek != null && workHour.dayOfWeek == dayOfWeek) {
        return workHour;
      }
    }
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {
  String? doctorId;

  Doctor? doctor;

  final List<WorkHour> workHours = [];

  DoctorStatistic? doctorStatistic;

  @override
  void reset() {
    doctorId = null;
    doctor = null;
    workHours.clear();
    doctorStatistic = null;
  }
}

class _ViewInput extends ViewInput {}
