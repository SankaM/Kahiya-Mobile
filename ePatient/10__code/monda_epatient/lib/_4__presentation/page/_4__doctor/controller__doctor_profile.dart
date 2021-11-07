
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/appointment_option_hour.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/doctor_statistic.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';
import 'package:monda_epatient/_3__service/service__doctor.dart';

class DoctorProfileController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static const int nextDaysCount = 30;
  
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
      vReference.doctorId = data['doctorId'];
      vReference.doctorName = data['doctorName'];
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
      generateAppointmentOptionHours();
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

    return null;
  }

  void generateAppointmentOptionHours() {
    vState.appointmentOptionHours.clear();

    var now = DateTime.now();

    for(int i = 1; i <= nextDaysCount; i++) {
      var nextDay = now.add(Duration(days: i));
      WorkHour? availableWorkHour;

      switch(nextDay.weekday) {
        case DateTime.monday:
          availableWorkHour = findWorkHour('MONDAY');
          break;
        case DateTime.tuesday:
          availableWorkHour = findWorkHour('TUESDAY');
          break;
        case DateTime.wednesday:
          availableWorkHour = findWorkHour('WEDNESDAY');
          break;
        case DateTime.thursday:
          availableWorkHour = findWorkHour('THURSDAY');
          break;
        case DateTime.friday:
          availableWorkHour = findWorkHour('FRIDAY');
          break;
        case DateTime.saturday:
          availableWorkHour = findWorkHour('SATURDAY');
          break;
        case DateTime.sunday:
          availableWorkHour = findWorkHour('SUNDAY');
          break;
      }

      if(availableWorkHour != null) {
        String dayLabel = availableWorkHour.nonNullDayOfWeek.capitalizeFirst!;
        if(dayLabel.length > 3) {
          dayLabel = dayLabel.substring(0, 3);
        }

        AppointmentOptionHour appointmentOptionHour = AppointmentOptionHour(
          id: i,
          workHourId: availableWorkHour.id,
          dayLabel: dayLabel,
          timeLabel: availableWorkHour.nonNullTime,
          dateLabel: DateFormat('d MMM, yyy').format(nextDay),
        );

        vState.appointmentOptionHours.add(appointmentOptionHour);
      }
    }

    update();
  }

  void selectOptionHour(AppointmentOptionHour appointmentOptionHour) {
    vInput.selectedAppointmentOptionHour = appointmentOptionHour;
  }

  void makeAppointment() {
    if(vInput.selectedAppointmentOptionHour == null) {
      AlertUtil.showMessage(TextString.label__please_select_appointment_hour);
    } else {
      RouteNavigator.gotoConfirmAppointmentPage();
    }
  }
}

class _ViewState extends ViewState {
  final List<AppointmentOptionHour> appointmentOptionHours = [];

  @override
  void reset() {
    appointmentOptionHours.clear();
  }
}

class _ViewReference extends ViewReference {
  String? doctorId;

  Doctor? doctor;

  String? doctorName;

  final List<WorkHour> workHours = [];

  DoctorStatistic? doctorStatistic;

  @override
  void reset() {
    doctorId = null;
    doctor = null;
    doctorName = null;
    doctorStatistic = null;
    workHours.clear();
  }
}

class _ViewInput extends ViewInput {
  AppointmentOptionHour? selectedAppointmentOptionHour;

  @override
  void reset() {
    selectedAppointmentOptionHour = null;
  }
}
