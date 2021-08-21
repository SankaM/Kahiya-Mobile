import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/diagnosis.dart';
import 'package:monda_edoctor/_2__datasource/api/api__diagnosis.dart';

class PrescriptionService {
  static PrescriptionService get instance => Get.find();

  PrescriptionService.newInstance();

  // ===========================================================================
  Future<StatusWrapper<GetDiagnosisStatus, List<Diagnosis>, String>> getDiagnosis({required String name}) {
    var completer = Completer<StatusWrapper<GetDiagnosisStatus, List<Diagnosis>, String>>();

    DiagnosisApi.instance.getDiagnosisList(name: name).then((ResponseWrapper<List<Diagnosis>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetDiagnosisStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetDiagnosisStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetDiagnosisStatus, Diagnosis, String>> createDiagnosis({required String name}) {
    var completer = Completer<StatusWrapper<GetDiagnosisStatus, Diagnosis, String>>();

    DiagnosisApi.instance.createDiagnosis(name: name).then((ResponseWrapper<Diagnosis> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetDiagnosisStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetDiagnosisStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}

enum GetDiagnosisStatus {
  SUCCESS,
  ERROR,
}
