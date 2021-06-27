import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/User.dart';
import 'package:monda_edoctor/_2__datasource/api/api__account.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class AccountService {
  AccountService.newInstance();

  static AccountService get instance => Get.find();

  Future<StatusWrapper<LoginStatus, User, String>> login({required String username, required String password}) {
    var completer = Completer<StatusWrapper<LoginStatus, User, String>>();

    AccountApi.instance.login(username: username, password: password).then((LoginResult loginResult) {
      if(loginResult.success) {
        UserSecureStorage.instance.user = loginResult.user;
        completer.complete(StatusWrapper(status: LoginStatus.SUCCESS, data: loginResult.user));
      } else {
        completer.complete(StatusWrapper(status: LoginStatus.ERROR, error: loginResult.errorMessage),);
      }
    });

    return completer.future;
  }
}

enum LoginStatus {
  SUCCESS,
  ERROR,
}
