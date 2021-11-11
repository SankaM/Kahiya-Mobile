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
    String url = TemplateString(stringWithParams: ApiEndPoint.APPOINTMENT_MAKE_NEW).toString();
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
}
