import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/doctor.dart';

class DoctorApi extends ApiDataSource {
  DoctorApi.newInstance();

  static DoctorApi get instance => Get.find();

  // ===========================================================================
  Future<ResponseWrapper<Doctor>> getProfile({required String doctorId,}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTOR_PROFILE, params: {'doctorId': doctorId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Doctor>.success(data: Doctor.buildDetail(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Doctor>> updateProfile({required String doctorId, required String name, required double doctorCost}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTOR_PROFILE, params: {'doctorId': doctorId}).toString();
    var data = {'doctorId': doctorId, 'name': name, 'doctorCost': doctorCost};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Doctor>.success(data: Doctor.buildDetail(json['data']));
    };

    return ApiUtil.put(url: url, putData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
