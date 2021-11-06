import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/doctor_statistic.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';
import 'package:monda_epatient/_2__datasource/api/api__doctor.dart';

class DoctorService {
  DoctorService.newInstance();

  static DoctorService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<Status, List<Doctor>, String>> findAll() {
    var completer = Completer<StatusWrapper<Status, List<Doctor>, String>>();

    DoctorApi.instance.findAll().then((ResponseWrapper<List<Doctor>> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Doctor>, String>> searchDoctors({required String queryValue, required SearchDoctorField field}) {
    var completer = Completer<StatusWrapper<Status, List<Doctor>, String>>();

    DoctorApi.instance.searchDoctors(queryValue: queryValue, field: field.toString().split('.').last).then((ResponseWrapper<List<Doctor>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, Doctor, String>> doctorProfile({required String doctorId}) {
    var completer = Completer<StatusWrapper<Status, Doctor, String>>();

    DoctorApi.instance.retrieveDoctorProfile(doctorId: doctorId).then((ResponseWrapper<Doctor> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<WorkHour>, String>> doctorWorkHours({required String doctorId}) {
    var completer = Completer<StatusWrapper<Status, List<WorkHour>, String>>();

    DoctorApi.instance.retrieveDoctorWorkHours(doctorId: doctorId).then((ResponseWrapper<List<WorkHour>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, DoctorStatistic, String>> doctorStatistic({required String doctorId}) {
    var completer = Completer<StatusWrapper<Status, DoctorStatistic, String>>();

    DoctorApi.instance.retrieveDoctorStatistic(doctorId: doctorId).then((ResponseWrapper<DoctorStatistic> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}

enum SearchDoctorField {
  NAME, MOBILE_PHONE,
}
