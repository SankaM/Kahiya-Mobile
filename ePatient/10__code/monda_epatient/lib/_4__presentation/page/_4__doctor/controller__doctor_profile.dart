import 'package:get/get.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_controller.dart';

class DoctorProfileController extends AbstractController {
  static DoctorProfileController get instance => Get.find();

  String assetImage = '';

  String firstLineText = '';

  String secondLineText = '';

  String thirdLineText = '';

  String assetIcon = '';

  reset() {
    this.assetImage = '';
    this.firstLineText = '';
    this.secondLineText = '';
    this.thirdLineText = '';
    this.assetIcon = '';
  }

  initializeData({required String assetImage, required String firstLineText, required String secondLineText, required String thirdLineText, required String assetIcon}) {
    this.assetImage = assetImage;
    this.firstLineText = firstLineText;
    this.secondLineText = secondLineText;
    this.thirdLineText = thirdLineText;
    this.assetIcon = assetIcon;
  }
}
