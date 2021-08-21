import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/diagnosis.dart';

class DiagnosisApi {
  static DiagnosisApi get instance => Get.find();

  DiagnosisApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<List<Diagnosis>>> getDiagnosisList({required String name}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DIAGNOSIS_LIST, params: {'name': name}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Diagnosis>>.success(data: (json['data'] as List).map((e) => Diagnosis.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Diagnosis>> createDiagnosis({required String name}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DIAGNOSIS_LIST, params: {'name': name}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Diagnosis>.success(data: Diagnosis.buildDetail(json['data']));
    };

    return ApiUtil.post(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
