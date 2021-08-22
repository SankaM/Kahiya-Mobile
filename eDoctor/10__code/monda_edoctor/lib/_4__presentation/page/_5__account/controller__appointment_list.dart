
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_3__service/service__doctor.dart';

class AppointmentListController extends AbstractController {
  AppointmentListController.newInstance();

  static AppointmentListController get instance => Get.find();

  bool progressDialogShow = false;

  AppointmentListType? appointmentListType;

  List<Appointment>? appointmentList;

  @override
  void reset({bool doUpdate = true}) {
  }

  void retrieveData({required AppointmentListType appointmentListType}) {
    this.progressDialogShow = true;
    this.appointmentListType = appointmentListType;
    if(appointmentListType == AppointmentListType.PAST) {
      _retrievePastAppointment();
    } else {
      _retrieveFutureAppointment();
    }
  }

  void _retrievePastAppointment() async {
    var wrapper = await DoctorService.instance.retrievePastAppointment();
    if(wrapper.status == GetAppointmentListStatus.SUCCESS) {
      appointmentList = wrapper.data!;
      progressDialogShow = false;
      update();
    } else {
      progressDialogShow = false;
      update();
      AlertUtil.showMessage('Error retrieving appointment list');
    }
  }

  void _retrieveFutureAppointment() async {
    var wrapper = await DoctorService.instance.retrieveFutureAppointment();
    if(wrapper.status == GetAppointmentListStatus.SUCCESS) {
      appointmentList = wrapper.data!;
      progressDialogShow = false;
      update();
    } else {
      progressDialogShow = false;
      update();
      AlertUtil.showMessage('Error retrieving appointment list');
    }
  }
}

enum AppointmentListType {
  PAST, FUTURE
}
