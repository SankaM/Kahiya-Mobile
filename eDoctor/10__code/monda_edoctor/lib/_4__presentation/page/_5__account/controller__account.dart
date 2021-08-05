
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/doctor.dart';
import 'package:monda_edoctor/_3__service/service__account.dart';
import 'package:monda_edoctor/_3__service/service__doctor.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AccountController extends AbstractController {
  static AccountController get instance => Get.find();

  final changePasswordForm = FormGroup({
    'oldPassword': FormControl(validators: [Validators.required]),
    'newPassword': FormControl(validators: [Validators.required]),
    'newPasswordRetype': FormControl(validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('newPassword', 'newPasswordRetype')
  ]);

  final updateDoctorProfileForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'doctorCost': FormControl<double>(validators: [Validators.required]),
  });

  bool progressDialogShow = false;

  void resetChangePasswordForm() {
    this.changePasswordForm.reset();
  }

  @override
  void reset({bool doUpdate = true}) {
  }

  void logout() {
    RouteNavigator.gotoBlankBeforeSplashPage();
    Phoenix.rebirth(Get.context!);
  }

  void changePassword() async {
    String oldPassword = changePasswordForm.control('oldPassword').value;
    String newPassword = changePasswordForm.control('newPassword').value;
    String newPasswordRetype = changePasswordForm.control('newPasswordRetype').value;

    if(newPassword != newPasswordRetype) {
      AlertUtil.showMessage('Password & password retype does not match');
      return;
    }

    var statusWrapper = await AccountService.instance.changePassword(oldPassword: oldPassword, newPassword: newPassword);

    if(statusWrapper.status == ChangePasswordStatus.SUCCESS) {
      Navigator.of(Get.context!).pop();
      AlertUtil.showMessage("Successfully change password");
    } else if(statusWrapper.status == ChangePasswordStatus.ERROR) {
      AlertUtil.showMessage("${statusWrapper.error}");
    }
  }

  void loadDoctorProfile() async {
    this.updateDoctorProfileForm.reset();
    this.progressDialogShow = true;
    update();

    var wrapper = await DoctorService.instance.getProfile();
    if(wrapper.status == GetDoctorProfileStatus.SUCCESS) {
      Doctor doctor = wrapper.data!;
      this.updateDoctorProfileForm.reset(value: {
        'name': doctor.name,
        'doctorCost': doctor.doctorCost
      });
      this.progressDialogShow = false;
      update();
    } else {
      Navigator.of(Get.context!).pop();
      AlertUtil.showMessage("Error load profile");
    }
  }

  void updateProfile() async {
    String name = updateDoctorProfileForm.control('name').value;
    double doctorCost = updateDoctorProfileForm.control('doctorCost').value;

    var statusWrapper = await DoctorService.instance.updateProfile(name: name, doctorCost: doctorCost);

    if(statusWrapper.status == UpdateDoctorProfileStatus.SUCCESS) {
      Navigator.of(Get.context!).pop();
      AlertUtil.showMessage("Successfully update profile");
    } else if(statusWrapper.status == UpdateDoctorProfileStatus.ERROR) {
      AlertUtil.showMessage("${statusWrapper.error}");
    }
  }
}
