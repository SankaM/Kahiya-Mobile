import 'package:get/get.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_controller.dart';

class PayAndConfirmController extends AbstractController {
  static PayAndConfirmController get instance => Get.find();

  String assetImage = '';

  String doctorName = '';

  reset() {
    this.assetImage = '';
    this.doctorName = '';
  }

  initializeData({required String assetImage, required String doctorName,}) {
    this.assetImage = assetImage;
    this.doctorName = doctorName;
  }
}
