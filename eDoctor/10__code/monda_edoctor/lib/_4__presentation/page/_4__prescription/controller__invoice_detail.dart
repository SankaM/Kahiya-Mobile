import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';

class InvoiceDetailController extends AbstractController {
  static InvoiceDetailController get instance => Get.find();

  // View
  bool progressDialogShow = true;

  // Reff Data
  Prescription? prescription;

  void initData({required String prescriptionId}) async {
    this.prescription = null;
    this.progressDialogShow = true;

    var wrapper = await PatientService.instance.getPrescriptionById(prescriptionId: prescriptionId);
    if(wrapper.status == GetPrescriptionListStatus.SUCCESS) {
      this.progressDialogShow = false;
      this.prescription = wrapper.data;
      update();
    } else {
      AlertUtil.showMessage('${wrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }
}
