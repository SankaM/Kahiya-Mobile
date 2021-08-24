import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';

class AppointmentApi {
  static AppointmentApi get instance => Get.find();

  AppointmentApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<List<Appointment>>> getPastAppointment({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTOR_APPOINTMENT_PAST, params: {'doctorId': doctorId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success(data: (json['data'] as List).map((e) => Appointment.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Appointment>>> getUpcomingAppointment({required String doctorId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.DOCTOR_APPOINTMENT_UPCOMING, params: {'doctorId': doctorId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success(data: (json['data'] as List).map((e) => Appointment.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper> updateAppointment({required String doctorId, required String appointmentId, required String status}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT_UPDATE, params: {'doctorId': doctorId, 'appointmentId': appointmentId}).toString();
    var putData = {
      'status': status,
    };
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success();
    };

    return ApiUtil.put(url: url, putData: putData, options: options, responseDataBuilder: responseDataBuilder);
  }
}
