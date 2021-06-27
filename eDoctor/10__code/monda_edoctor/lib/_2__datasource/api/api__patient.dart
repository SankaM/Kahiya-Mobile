
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/response.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/Patient.dart';

class PatientApi extends ApiDatasource {
  PatientApi.newInstance();

  static PatientApi get instance => Get.find();

  Future<PatientListResult> getPatientSummary({required String doctorId}) async {
    var res;
    try {
      String url = TemplateString(stringWithParams: ApiEndPoint.PATIENT_SUMMARY, params: {'doctorId': doctorId}).toString();
      res = await ApiUtil.dio.get(url, options: await ApiUtil.generateDioOptions());
    } catch (e) {
      DioError de = e as DioError;
      String errorMessage = de.response != null ? de.response!.data != null ? de.response!.data['message'] : 'Error' : 'Error';

      return PatientListResult.error(errorMessage: errorMessage);
    }

    if(res.statusCode == 200 || res.statusCode == 201) {
      return PatientListResult.fromJson(res.data);
    } else {
      return PatientListResult.error();
    }
  }
}

// =============================================================================
// Result
// =============================================================================
class PatientListResult extends AbstractResult {
  late List<Patient>? patientList;

  PatientListResult.success({List<Patient>? patientList}) : this.patientList = patientList, super.success();

  PatientListResult.error({String? errorMessage}) : this.patientList = null, super.error(errorMessage: errorMessage);

  factory PatientListResult.fromJson(dynamic json) => PatientListResult.success(
    patientList: (json as List)
            .map((patientJson) => Patient(
                patientId: patientJson['patientId'],
                name: patientJson['name'],
                age: patientJson['age'],
                mobile: patientJson['mobile'],
                imageUrl: patientJson['imageUrl']))
            .toList(),
      );
}
