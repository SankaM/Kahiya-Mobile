import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PatientRegisterController extends GetxController {
  static PatientRegisterController get instance => Get.find();

  final patientRegistrationForm = FormGroup({
    'firstName': FormControl(validators: [Validators.required]),
    'lastName': FormControl(validators: [Validators.required]),
    'age': FormControl<int>(value: -1, validators: [Validators.required, Validators.number]),
    'gender': FormControl<String>(value: 'M', validators: [Validators.required]),
    'phoneCountryCode': FormControl<String>(value: '+1', validators: [Validators.required]),
    'phoneNumber': FormControl(validators: [Validators.required]),
    'username': FormControl(validators: []),
    'email': FormControl(validators: [Validators.email]),
    'nic': FormControl(validators: []),
  });

  bool progressDialogShow = false;

  void reset() {
    this.patientRegistrationForm.reset(value: {
      'firstName': '',
      'lastName': '',
      'age': -1,
      'gender': 'M',
      'phoneCountryCode': '+1',
      'phoneNumber': '',
      'username': '',
      'email': '',
      'nic': '',
    });

    progressDialogShow = false;

    update();
  }
}
