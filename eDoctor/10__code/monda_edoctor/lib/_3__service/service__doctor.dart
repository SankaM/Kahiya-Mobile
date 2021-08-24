import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_1__model/doctor.dart';
import 'package:monda_edoctor/_2__datasource/api/api__appointment.dart';
import 'package:monda_edoctor/_2__datasource/api/api__doctor.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class DoctorService {
  DoctorService.newInstance();

  static DoctorService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<GetDoctorProfileStatus, Doctor, String>> getProfile() {
    var completer = Completer<StatusWrapper<GetDoctorProfileStatus, Doctor, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    DoctorApi.instance.getProfile(doctorId: doctorId).then((ResponseWrapper<Doctor> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: GetDoctorProfileStatus.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: GetDoctorProfileStatus.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<UpdateDoctorProfileStatus, Doctor, String>> updateProfile({required String name, required double doctorCost}) {
    var completer = Completer<StatusWrapper<UpdateDoctorProfileStatus, Doctor, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    DoctorApi.instance.updateProfile(doctorId: doctorId, name: name, doctorCost: doctorCost).then((ResponseWrapper<Doctor> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: UpdateDoctorProfileStatus.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: UpdateDoctorProfileStatus.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetAppointmentListStatus, List<Appointment>, String>> retrievePastAppointment() {
    var completer = Completer<StatusWrapper<GetAppointmentListStatus, List<Appointment>, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.getPastAppointment(doctorId: doctorId).then((ResponseWrapper<List<Appointment>> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: GetAppointmentListStatus.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: GetAppointmentListStatus.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetAppointmentListStatus, List<Appointment>, String>> retrieveUpcomingAppointment() {
    var completer = Completer<StatusWrapper<GetAppointmentListStatus, List<Appointment>, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    AppointmentApi.instance.getUpcomingAppointment(doctorId: doctorId).then((ResponseWrapper<List<Appointment>> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: GetAppointmentListStatus.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: GetAppointmentListStatus.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }
}

enum GetDoctorProfileStatus {
  SUCCESS,
  ERROR,
}

enum UpdateDoctorProfileStatus {
  SUCCESS,
  ERROR,
}

enum GetAppointmentListStatus {
  SUCCESS,
  ERROR,
}