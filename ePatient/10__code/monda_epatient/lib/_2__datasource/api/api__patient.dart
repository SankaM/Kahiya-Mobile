import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/patient.dart';
import 'package:monda_epatient/_1__model/prescription.dart';

class PatientApi extends ApiDataSource {
  PatientApi.newInstance();

  static PatientApi get instance => Get.find();

  // ===========================================================================
  Future<ResponseWrapper<Patient>> retrievePatientDetail({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT__DETAIL, params: {'patientId': patientId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Patient>.success(data: Patient.buildDetail(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Prescription>>> retrieveCurrentPrescription({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT__CURRENT_PRESCRIPTION, params: {'patientId': patientId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Prescription>>> retrievePastPrescription({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT__PAST_PRESCRIPTION, params: {'patientId': patientId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
