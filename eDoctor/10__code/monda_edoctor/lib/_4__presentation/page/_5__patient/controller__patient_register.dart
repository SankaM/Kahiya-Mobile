import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PatientRegisterController extends AbstractController {
  static PatientRegisterController get instance => Get.find();

  final patientRegistrationForm = FormGroup({
    'firstName': FormControl<String>(value: '', validators: [Validators.required]),
    'lastName': FormControl<String>(value: '', validators: [Validators.required]),
    'dateOfBirth': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
    'gender': FormControl<String>(value: 'MALE', validators: [Validators.required]),
    'phoneCountryCode': FormControl<String>(value: '+65', validators: [Validators.required]),
    'phoneNumber': FormControl<String>(value: '', validators: [Validators.required]),
    'username': FormControl<String>(value: '', validators: []),
    'email': FormControl<String>(value: '', validators: [Validators.email]),
    'nic': FormControl<String>(value: '', validators: []),

  });

  bool progressDialogShow = false;

  @override
  void reset() {
    this.patientRegistrationForm.reset(value: {
      'firstName': '',
      'lastName': null,
      'dateOfBirth': DateTime.now(),
      'gender': 'MALE',
      'phoneCountryCode': '+65',
      'phoneNumber': '',
      'username': '',
      'email': '',
      'nic': '',

    });

    progressDialogShow = false;

    update();
  }

  void register() async {
    this.progressDialogShow = true;
    update();

    String firstName = patientRegistrationForm.control('firstName').value;
    String lastName = patientRegistrationForm.control('lastName').value;
    String dateOfBirth = DateFormat("yyyy-MM-dd").format(patientRegistrationForm.control('dateOfBirth').value);
    String gender = patientRegistrationForm.control('gender').value;
    String mobilePhone = patientRegistrationForm.control('phoneCountryCode').value + patientRegistrationForm.control('phoneNumber').value;
    String? username = patientRegistrationForm.control('username').value;
    String? email = patientRegistrationForm.control('email').value;
    String? nic = patientRegistrationForm.control('nic').value;

    username = username!.isEmpty ? null : username;
    email = email!.isEmpty ? null : email;
    nic = nic!.isEmpty ? null : nic;

    var wrapper = await PatientService.instance.registerPatient(
      firstName: firstName,
      lastName: lastName,
      birthDate: dateOfBirth,
      gender: gender,
      mobilePhone: mobilePhone,
      username: username,
      nic: nic,
      email: email,
    );

    if(wrapper.status == PatientRegistrationStatus.SUCCESS) {
      AlertUtil.showMessage('Patient registration success',);
      reset();

    } else {
      AlertUtil.showMessage('${wrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }
}
