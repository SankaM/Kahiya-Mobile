
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_3__service/service__doctor.dart';

class PastAppointmentListController extends AbstractController {
  PastAppointmentListController.newInstance();

  static PastAppointmentListController get instance => Get.find();

  bool progressDialogShow = false;

  List<Appointment>? appointmentList;

  @override
  void reset({bool doUpdate = true}) {
  }

  void retrieveData() {
    this.progressDialogShow = true;
    _retrievePastAppointment();
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
}
