
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_3__service/service__doctor.dart';

class UpcomingAppointmentListController extends AbstractController {
  UpcomingAppointmentListController.newInstance();

  static UpcomingAppointmentListController get instance => Get.find();

  bool progressDialogShow = false;

  List<Appointment>? appointmentList;

  @override
  void reset({bool doUpdate = true}) {
  }

  void retrieveData() {
    this.progressDialogShow = true;
    _retrieveUpcomingAppointment();
  }

  void _retrieveUpcomingAppointment() async {
    var wrapper = await DoctorService.instance.retrieveUpcomingAppointment();
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

  void acceptAppointment(Appointment appointment) async {
    var wrapper = await DoctorService.instance.acceptAppointment(appointmentId: appointment.id);
    if(wrapper.status == UpdateAppointmentStatus.SUCCESS) {
      appointment.status = 'ACCEPTED';
      update();
      Navigator.pop(Get.context!);
    } else if(wrapper.status == UpdateAppointmentStatus.ERROR) {
      Navigator.pop(Get.context!);
      AlertUtil.showMessage(wrapper.error!);
    }
  }

  void declineAppointment(Appointment appointment) async {
    var wrapper = await DoctorService.instance.declineAppointment(appointmentId: appointment.id);
    if(wrapper.status == UpdateAppointmentStatus.SUCCESS) {
      appointment.status = 'DECLINED';
      update();
      Navigator.pop(Get.context!);
    } else if(wrapper.status == UpdateAppointmentStatus.ERROR) {
      Navigator.pop(Get.context!);
      AlertUtil.showMessage(wrapper.error!);
    }
  }
}
