
import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_1__model/taken_medicine.dart';
import 'package:monda_epatient/_3__service/service__appointment.dart';
import 'package:monda_epatient/_3__service/service__prescription.dart';
import 'package:monda_epatient/_8__notif/local_notification_api.dart';

class NotificationController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static NotificationController get instance => Get.find();

  NotificationController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();

    retrieveAcceptedAppointment();
    retrieveAllTakenMedicine();
  }

  void retrieveAcceptedAppointment() async {
    StatusWrapper<Status, List<Appointment>, String> statusWrapper = await AppointmentService.instance.retrieveAcceptedAppointment();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      vReference.acceptedAppointment.clear();
      vReference.acceptedAppointment.addAll(statusWrapper.data!);
      update();
    } else {
      vReference.acceptedAppointment.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void retrieveAllTakenMedicine() async {
    StatusWrapper<Status, List<TakenMedicine>, String> statusWrapper = await PrescriptionService.instance.findAll();

    if(statusWrapper.status == Status.SUCCESS && statusWrapper.data != null) {
      LocalNotificationApi.cancelAllScheduledNotification();

      vReference.allTakenMedicine.clear();
      statusWrapper.data!.forEach((takenMedicine) {
        vReference.allTakenMedicine.add(takenMedicine);

        // Make local notification
        if(takenMedicine.isFuture() && takenMedicine.scheduledTakenDate != null) {
          String bodyMessage = 'Scheduled to take ${takenMedicine.dosage!.drug!.name} at ${takenMedicine.scheduledTakenDateLabel}';
          LocalNotificationApi.showScheduledNotification(title: TextString.app_name_epatient, body: bodyMessage, scheduledTime: takenMedicine.scheduledTakenDate!);
        }
      });
      update();
    } else {
      vReference.allTakenMedicine.clear();
      update();
      AlertUtil.showMessage(TextString.label__error_retrieving_data);
    }
  }

  void markTaken({required String id}) async {
    await PrescriptionService.instance.updateTakenMedicineStatus(takenMedicineId: id, taken: true);
    init();
  }

  void markNotTaken({required String id}) async {
    await PrescriptionService.instance.updateTakenMedicineStatus(takenMedicineId: id, taken: false);
    init();
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {
  final List<Appointment> acceptedAppointment = [];

  final List<TakenMedicine> allTakenMedicine = [];

  @override
  void reset() {
    acceptedAppointment.clear();
    allTakenMedicine.clear();
  }
}

class _ViewInput extends ViewInput {}
