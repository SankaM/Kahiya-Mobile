import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/user.dart';

class AccountApi extends ApiDataSource {
  AccountApi.newInstance();

  static AccountApi get instance => Get.find();

  // ===========================================================================
  Future<ResponseWrapper<User>> login({required String username, required String password}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.LOGIN).toString();
    var data = {'userName': username, 'password': password};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<User>.success(data: User.buildDetail(json['data']));
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<User>> signup({required String email, required String username, required String password}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.SIGNUP).toString();
    var data = {'email': email, 'userName': username, 'password': password};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<User>.success(data: User.buildDetail(json['data']));
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
