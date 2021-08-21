import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_2__datasource/api/api__patient.dart';
import 'package:monda_edoctor/_2__datasource/api/api__prescription.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__add_prescription.dart';

import '../_0__infra/util/status_wrapper.dart';
import '../_2__datasource/api/api__patient.dart';
import '../_2__datasource/securestorage/secure_storage__user.dart';

class PatientService {
  PatientService.newInstance();

  static PatientService get instance => Get.find();

  // ===========================================================================
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

  // ===========================================================================
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

  // ===========================================================================
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

  // ===========================================================================
  Future<StatusWrapper<GetPrescriptionListStatus, List<Prescription>, String>> getLastPrescriptionByPatient({required String patientId}) {
    var completer = Completer<StatusWrapper<GetPrescriptionListStatus, List<Prescription>, String>>();

    PrescriptionApi.instance.getLastPrescriptionByPatient(patientId: patientId).then((ResponseWrapper<List<Prescription>> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetPrescriptionListStatus, List<Prescription>, String>> getCurrentPrescriptionByPatient({required String patientId}) {
    var completer = Completer<StatusWrapper<GetPrescriptionListStatus, List<Prescription>, String>>();

    PrescriptionApi.instance.getCurrentPrescriptionByPatient(patientId: patientId).then((ResponseWrapper<List<Prescription>> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetPrescriptionListStatus, Prescription, String>> getPrescriptionById({required String prescriptionId}) {
    var completer = Completer<StatusWrapper<GetPrescriptionListStatus, Prescription, String>>();

    PrescriptionApi.instance.getPrescriptionById(prescriptionId: prescriptionId).then((ResponseWrapper<Prescription> responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetPrescriptionListStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<GetSearchPrescriptionStatus, List<Prescription>, String>> getSearchPrescription({required int page, required int itemPerPage, String? queryValue,}) {
    var completer = Completer<StatusWrapper<GetSearchPrescriptionStatus, List<Prescription>, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;

    PrescriptionApi.instance.getSearchPrescription(doctorId: doctorId, page: page, itemPerPage: itemPerPage, queryValue: queryValue,).then((ResponseWrapper<List<Prescription>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetSearchPrescriptionStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetSearchPrescriptionStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<NewPrescriptionStatus, Prescription, String>> newPrescription({required String patientId, required String diagnosisId, required String illnessSeverity, required String notes, required List<TreatmentItem> treatmentItemList, File? attachmentFile}) {
    var completer = Completer<StatusWrapper<NewPrescriptionStatus, Prescription, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    PrescriptionApi.instance.newPrescription(doctorId: doctorId, patientId: patientId, diagnosisId: diagnosisId, illnessSeverity: illnessSeverity, notes: notes, treatmentItemList: treatmentItemList, attachmentFile: attachmentFile).then((responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: NewPrescriptionStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: NewPrescriptionStatus.ERROR, error: responseWrapper.message));
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<PatientRegistrationStatus, void, String>> registerPatient({required String firstName, required String lastName, required String birthDate, required String gender, required mobilePhone, String? nic, String? username, String? email, String? healthProfile}) {
    var completer = Completer<StatusWrapper<PatientRegistrationStatus, void, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    PatientApi.instance.registerPatient(doctorId: doctorId, firstName: firstName, lastName: lastName, birthDate: birthDate, gender: gender, mobilePhone: mobilePhone, nic: nic, username: username, email: email, healthProfile: healthProfile).then((responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: PatientRegistrationStatus.SUCCESS));
      } else {
        completer.complete(StatusWrapper(status: PatientRegistrationStatus.ERROR, error: responseWrapper.message));
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<PatientUpdateProfileHealthStatus, void, String>> updatePatientProfileHealth({required String patientId, required String healthProfile}) {
    var completer = Completer<StatusWrapper<PatientUpdateProfileHealthStatus, void, String>>();

    PatientApi.instance.updatePatientProfileHealth(patientId: patientId, healthProfile: healthProfile).then((responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: PatientUpdateProfileHealthStatus.SUCCESS));
      } else {
        completer.complete(StatusWrapper(status: PatientUpdateProfileHealthStatus.ERROR, error: responseWrapper.message));
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

enum GetPrescriptionListStatus {
  SUCCESS,
  ERROR,
}

enum PatientRegistrationStatus {
  SUCCESS,
  ERROR
}

enum PatientUpdateProfileHealthStatus {
  SUCCESS,
  ERROR
}

enum NewPrescriptionStatus {
  SUCCESS,
  ERROR
}

enum GetSearchPrescriptionStatus {
  SUCCESS,
  ERROR
}