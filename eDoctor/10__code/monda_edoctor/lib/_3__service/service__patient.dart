import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_2__datasource/api/ResponseWrapper.dart';
import 'package:monda_edoctor/_2__datasource/api/api__patient.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class PatientService {
  PatientService.newInstance();

  static PatientService get instance => Get.find();

  Future<StatusWrapper<GetPatientSummaryStatus, List<Patient>, String>> getPatientSummary() {
    var completer = Completer<StatusWrapper<GetPatientSummaryStatus, List<Patient>, String>>();

    PatientApi.instance.getPatientSummary(doctorId: UserSecureStorage.instance.user!.id).then((ResponseWrapper<List<Patient>> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPatientSummaryStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPatientSummaryStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  Future<StatusWrapper<GetSearchPatientStatus, List<Patient>, String>> getSearchPatient({required String queryValue, required SearchPatientField field}) {
    var completer = Completer<StatusWrapper<GetSearchPatientStatus, List<Patient>, String>>();

    PatientApi.instance.getSearchPatient(queryValue: queryValue, field: field.toString().split('.').last).then((ResponseWrapper<List<Patient>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetSearchPatientStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetSearchPatientStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  Future<StatusWrapper<GetPatientStatus, Patient, String>> getPatient({required String patientId}) {
    var completer = Completer<StatusWrapper<GetPatientStatus, Patient, String>>();

    PatientApi.instance.getPatient(doctorId: UserSecureStorage.instance.user!.id, patientId: patientId).then((ResponseWrapper<Patient> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPatientStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPatientStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  Future<StatusWrapper<GetPrescriptionStatus, List<Prescription>, String>> getPrescription({required String patientId}) {
    var completer = Completer<StatusWrapper<GetPrescriptionStatus, List<Prescription>, String>>();

    PatientApi.instance.getPrescription(patientId: patientId).then((ResponseWrapper<List<Prescription>> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPrescriptionStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPrescriptionStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}

enum SearchPatientField {
  NAME, USERNAME, EMAIL, MOBILE_PHONE
}

enum GetPatientSummaryStatus {
  SUCCESS,
  ERROR,
}

enum GetSearchPatientStatus {
  SUCCESS,
  ERROR,
}

enum GetPatientStatus {
  SUCCESS,
  ERROR,
}

enum GetPrescriptionStatus {
  SUCCESS,
  ERROR,
}
