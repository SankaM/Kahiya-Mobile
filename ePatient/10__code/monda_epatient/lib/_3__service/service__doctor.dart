import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
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
}

enum SearchDoctorField {
  NAME, MOBILE_PHONE,
}
