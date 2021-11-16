import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_3__service/service__appointment.dart';

class AllAppointmentController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static AllAppointmentController get instance => Get.find();

  AllAppointmentController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();

    retrieveUpcomingAppointment();
    retrievePastAppointment();
  }

  void retrieveUpcomingAppointment() async {
    StatusWrapper<Status, List<Appointment>, String> statusWrapper = await AppointmentService.instance.retrieveUpcomingAppointment();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.upcomingAppointmentList.clear();
      vReference.upcomingAppointmentList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.upcomingAppointmentList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrievePastAppointment() async {
    StatusWrapper<Status, List<Appointment>, String> statusWrapper = await AppointmentService.instance.retrievePastAppointment();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.pastAppointmentList.clear();
      vReference.pastAppointmentList.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.pastAppointmentList.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void cancelAppointment({required String appointmentId}) async {
    StatusWrapper<Status, Appointment, String> statusWrapper = await AppointmentService.instance.cancelAppointment(appointmentId: appointmentId);

    if(statusWrapper.status == Status.SUCCESS) {
      init();
    } else {
      AlertUtil.showMessage(TextString.label__error);
    }
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {
  final List<Appointment> upcomingAppointmentList = [];

  final List<Appointment> pastAppointmentList = [];

  @override
  void reset() {
    upcomingAppointmentList.clear();
    pastAppointmentList.clear();
  }
}

class _ViewInput extends ViewInput {}
