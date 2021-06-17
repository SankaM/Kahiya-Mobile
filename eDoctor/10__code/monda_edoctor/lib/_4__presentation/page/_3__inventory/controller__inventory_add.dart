import 'package:get/get.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddInventoryController extends AbstractController {
  static AddInventoryController get instance => Get.find();

  final addInventoryForm = FormGroup({
    'nameOfDrug': FormControl<String>(validators: [Validators.required]),
    'typeOfDrug': FormControl<int>(value: -1, validators: [Validators.required]),
    'massOfDrug': FormControl<int>(value: -1, validators: [Validators.required, Validators.number]),
    'expiryDate': FormControl<String>(validators: [Validators.required]),
    'drugCount': FormControl<int>(value: 0, validators: [Validators.required]),
  });

  bool progressDialogShow = false;

  @override
  void reset() {
    this.addInventoryForm.reset(value: {
      'nameOfDrug': null,
      'typeOfDrug': -1,
      'massOfDrug': -1,
      'expiryDate': null,
      'drugCount': 0,
    });
  }
}
