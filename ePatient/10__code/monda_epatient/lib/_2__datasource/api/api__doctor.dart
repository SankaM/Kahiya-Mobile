import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/doctor_statistic.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';

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

  // ===========================================================================
  Future<ResponseWrapper<List<Doctor>>> searchDoctors({required String queryValue, required String field}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTORS__SEARCH, params: {'queryValue': queryValue, 'field': field}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Doctor>>.success(data: (json['data'] as List).map((e) => Doctor.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Doctor>> retrieveDoctorProfile({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTORS__PROFILE, params: {'doctorId': doctorId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Doctor>.success(data: Doctor.buildDetail(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<WorkHour>>> retrieveDoctorWorkHours({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTORS__WORK_HOURS, params: {'doctorId': doctorId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<WorkHour>>.success(data: (json['data'] as List).map((e) => WorkHour.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<DoctorStatistic>> retrieveDoctorStatistic({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTORS__STATISTIC, params: {'doctorId': doctorId,}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<DoctorStatistic>.success(data: DoctorStatistic.build(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
