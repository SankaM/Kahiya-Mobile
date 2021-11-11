import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_2__datasource/api/api__appointment.dart';

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
}
