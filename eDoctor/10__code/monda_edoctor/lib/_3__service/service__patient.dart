import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/Patient.dart';
import 'package:monda_edoctor/_2__datasource/api/api__patient.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class PatientService {
  PatientService.newInstance();

  static PatientService get instance => Get.find();

  Future<StatusWrapper<GetPatientSummaryStatus, List<Patient>, String>> getPatientSummary() {
    var completer = Completer<StatusWrapper<GetPatientSummaryStatus, List<Patient>, String>>();

    PatientApi.instance.getPatientSummary(doctorId: UserSecureStorage.instance.user!.id!).then((PatientListResult patientListResult) {
      if(patientListResult.success) {
        completer.complete(StatusWrapper(status: GetPatientSummaryStatus.SUCCESS, data: patientListResult.patientList));
      } else {
        completer.complete(StatusWrapper(status: GetPatientSummaryStatus.ERROR, error: patientListResult.errorMessage),);
      }
    });

    return completer.future;
  }
}

enum GetPatientSummaryStatus {
  SUCCESS,
  ERROR,
}
