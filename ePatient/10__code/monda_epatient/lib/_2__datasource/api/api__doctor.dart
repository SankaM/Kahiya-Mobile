import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/doctor.dart';

class DoctorApi extends ApiDataSource {
  DoctorApi.newInstance();

  static DoctorApi get instance => Get.find();

  // ===========================================================================
  Future<ResponseWrapper<List<Doctor>>> findAll() async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTORS__FIND_ALL).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Doctor>>.success(data: (json['data'] as List).map((e) => Doctor.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
