import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/drug.dart';

class DrugApi {
  static DrugApi get instance => Get.find();

  DrugApi.newInstance();

  Future<ResponseWrapper<List<Drug>>> getSearchDrug({required String name}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DRUG_SEARCH, params: {
      'name': name
    }).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Drug>>.success(data: (json['data'] as List).map((e) => Drug.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
