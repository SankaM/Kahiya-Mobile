import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/patient.dart';
import 'package:monda_epatient/_1__model/prescription.dart';
import 'package:monda_epatient/_2__datasource/api/api__patient.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';

class PatientService {
  PatientService.newInstance();

  static PatientService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<Status, Patient, String>> retrievePatientDetail() {
    var completer = Completer<StatusWrapper<Status, Patient, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    PatientApi.instance.retrievePatientDetail(patientId: patientId).then((ResponseWrapper<Patient> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Prescription>, String>> retrieveCurrentPrescription() {
    var completer = Completer<StatusWrapper<Status, List<Prescription>, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    PatientApi.instance.retrieveCurrentPrescription(patientId: patientId).then((ResponseWrapper<List<Prescription>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, List<Prescription>, String>> retrievePastPrescription() {
    var completer = Completer<StatusWrapper<Status, List<Prescription>, String>>();

    String patientId = UserSecureStorage.instance.user!.id;
    PatientApi.instance.retrievePastPrescription(patientId: patientId).then((ResponseWrapper<List<Prescription>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}
