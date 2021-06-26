import 'dart:developer';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_3__service/service__account.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInController extends AbstractController {
  SignInController.newInstance();

  static SignInController get instance => Get.find();

  final loginForm = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  bool progressDialogShow = false;

  @override
  void onInit() {
    super.onInit();
    reset(doUpdate: false);
  }

  @override
  void reset({bool doUpdate = true}) {
    this.progressDialogShow = false;
    this.loginForm.reset(value: {
      'username':'',
      'password':''
    });

    if(doUpdate) update();
  }

  void login() async {
    String username = loginForm.control('username').value;
    String password = loginForm.control('password').value;

    _changeProgressBarShow(true);

    StatusWrapper<LoginStatus> statusWrapper = await AccountService.instance.login(username: username, password: password);

    switch (statusWrapper.status) {
      case LoginStatus.SUCCESS:
        {
          log('===============================login success');
          _changeProgressBarShow(false);
          RouteNavigator.gotoHomePage();
          break;
        }
      case LoginStatus.ERROR:
        {
          log('===============================login error');
          AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.data.toString() : TextString.label__error);
          _changeProgressBarShow(false);
          break;
        }
      default:
        {
          log('===============================i dont know');
          _changeProgressBarShow(false);
          break;
        }
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}
