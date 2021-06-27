
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/response.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/User.dart';

class AccountApi extends ApiDatasource {
  AccountApi.newInstance();

  static AccountApi get instance => Get.find();

  Future<LoginResult> login({required String username, required String password}) async {
    var res;
    var data = {'userName': username, 'password': password};
    try {
      String url = TemplateString(stringWithParams: ApiEndPoint.LOGIN).toString();
      res = await ApiUtil.dio.post(url, options: await ApiUtil.generateDioOptions(), data: data);
    } catch (e) {
      DioError de = e as DioError;
      String errorMessage = de.response != null ? de.response!.data != null ? de.response!.data['message'] : 'Error' : 'Error';

      return LoginResult.error(errorMessage: errorMessage);
    }

    if(res.statusCode == 200 || res.statusCode == 201) {
      return LoginResult.fromJson(res.data);
    } else {
      return LoginResult.error();
    }
  }
}

// =============================================================================
// Result
// =============================================================================
class LoginResult extends AbstractResult {
  late User? user;

  LoginResult.success(
      {String? doctorId,
      String? doctorName,
      String? userName,
      String? location,
      String? imageUrl})
      : this.user = User(
          id: doctorId,
          name: doctorName,
          userName: userName,
          location: location,
          imageUrl: imageUrl,
        ),
        super.success();

  LoginResult.error({String? errorMessage})
      : this.user = null,
        super.error(errorMessage: errorMessage);

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult.success(
    doctorId: json['doctorId'],
    doctorName: json['doctorName'],
    userName: json['userName'],
    location: json['location'],
    imageUrl: json['imageUrl'],
  );
}
