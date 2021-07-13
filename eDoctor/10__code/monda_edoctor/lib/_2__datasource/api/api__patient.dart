import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_2__datasource/api/ResponseWrapper.dart';

class PatientApi extends ApiDatasource {
  PatientApi.newInstance();

  static PatientApi get instance => Get.find();

  Future<ResponseWrapper<List<Patient>>> getPatientSummary({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_SUMMARY, params: {'doctorId': doctorId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Patient>>.success(data: (json['data'] as List).map((e) => Patient.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<List<Patient>>> getSearchPatient({required String queryValue, required String field}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_SEARCH, params: {'queryValue': queryValue, 'field': field}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Patient>>.success(data: (json['data'] as List).map((e) => Patient.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<Patient>> getPatient({required String doctorId, required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_DETAIL, params: {'doctorId': doctorId, 'patientId': patientId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Patient>.success(data: Patient.buildDetail(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<List<Prescription>>> getPrescription({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_HISTORY, params: {'patientId': patientId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      // (json['data'] as List).forEach((element) {
      //   log('======================================= $element');
      // });
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
      // return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) {
      //   // log('===================================================== e: $e');
      //   log('===================================================== e: ${e.runtimeType}');
      //   return Prescription.buildDetail(e);
      //   // return Prescription(id: '123');
      // }).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
