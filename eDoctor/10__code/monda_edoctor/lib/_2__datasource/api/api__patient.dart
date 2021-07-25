import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';

class PatientApi extends ApiDataSource {
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
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper> registerPatient(
      {required String doctorId,
      required String firstName,
      required String lastName,
      required String birthDate,
      required String gender,
      required mobilePhone,
      String? nic,
      String? username,
      String? email}) async {

    String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_REGISTRATION, params: {'doctorId': doctorId}).toString();
    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "gender": gender,
      "mobilePhone": mobilePhone,
      "nic": nic,
      "userName": username,
      "email": email
    };
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper.success();
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
