import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/user.dart';
import 'package:monda_edoctor/_2__datasource/api/ResponseWrapper.dart';

class AccountApi extends ApiDatasource {
  AccountApi.newInstance();

  static AccountApi get instance => Get.find();

  Future<ResponseWrapper<User>> login({required String username, required String password}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.LOGIN).toString();
    var data = {'userName': username, 'password': password};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<User>.success(data: User.buildDetail(json['data']));
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
