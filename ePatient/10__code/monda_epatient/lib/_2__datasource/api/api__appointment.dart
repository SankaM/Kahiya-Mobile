import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/appointment.dart';

class AppointmentApi {
  static AppointmentApi get instance => Get.find();

  AppointmentApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<Appointment>> makeAppointment({required String patientId, required String doctorId, required String workHourId, required String appointmentDate}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT__MAKE_NEW).toString();
    var data = {
      'patientId': patientId,
      'doctorId': doctorId,
      'workHourId': workHourId,
      'appointmentDate': appointmentDate,
    };
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Appointment>.success(data: Appointment.build(json['data']));
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Appointment>>> retrieveUpcomingAppointment({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT__UPCOMING_LIST, params: {'patientId': patientId}).toString();

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success(data: (json['data'] as List).map((e) => Appointment.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Appointment>>> retrievePastAppointment({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT__PAST_LIST, params: {'patientId': patientId}).toString();

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success(data: (json['data'] as List).map((e) => Appointment.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Appointment>>> retrieveAcceptedAppointment({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT__STATUS_ACCEPTED_LIST, params: {'patientId': patientId}).toString();

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Appointment>>.success(data: (json['data'] as List).map((e) => Appointment.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Appointment>> updateAppointment({required String patientId, required String appointmentId, required String status}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT__CANCEL, params: {'patientId': patientId, 'appointmentId': appointmentId}).toString();
    var data = {
      'status': status,
    };
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Appointment>.success(data: Appointment.build(json['data']));
    };

    return ApiUtil.put(url: url, putData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
