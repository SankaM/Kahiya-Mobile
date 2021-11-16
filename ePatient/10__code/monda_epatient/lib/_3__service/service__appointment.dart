import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_2__datasource/api/api__appointment.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';

class AppointmentService {
  AppointmentService.newInstance();

  static AppointmentService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<Status, Appointment, String>> makeAppointment({required String patientId, required String doctorId, required String workHourId, required String appointmentDate}) {
    var completer = Completer<StatusWrapper<Status, Appointment, String>>();

    AppointmentApi.instance.makeAppointment(patientId: patientId, doctorId: doctorId, workHourId: workHourId, appointmentDate: appointmentDate).then((ResponseWrapper<Appointment> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Appointment>, String>> retrieveUpcomingAppointment() {
    var completer = Completer<StatusWrapper<Status, List<Appointment>, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.retrieveUpcomingAppointment(patientId: patientId).then((ResponseWrapper<List<Appointment>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Appointment>, String>> retrievePastAppointment() {
    var completer = Completer<StatusWrapper<Status, List<Appointment>, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.retrievePastAppointment(patientId: patientId).then((ResponseWrapper<List<Appointment>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Appointment>, String>> retrieveAllAppointment() {
    var completer = Completer<StatusWrapper<Status, List<Appointment>, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.retrieveAllAppointment(patientId: patientId).then((ResponseWrapper<List<Appointment>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, Appointment, String>> cancelAppointment({required String appointmentId}) {
    var completer = Completer<StatusWrapper<Status, Appointment, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.updateAppointment(patientId: patientId, appointmentId: appointmentId, status: AppointmentStatus.CANCELLED).then((ResponseWrapper<Appointment> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}
