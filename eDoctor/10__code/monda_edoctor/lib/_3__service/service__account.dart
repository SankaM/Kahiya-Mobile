import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_2__datasource/api/api__account.dart';

class AccountService {
  AccountService.newInstance();

  static AccountService get instance => Get.find();

  Future<StatusWrapper<LoginStatus>> login({required String username, required String password}) {
    var completer = Completer<StatusWrapper<LoginStatus>>();

    AccountApi.instance.login(username: username, password: password).then((LoginResult loginResult) {
      if(loginResult.success) {
        completer.complete(StatusWrapper(status: LoginStatus.SUCCESS));
      } else {
        completer.complete(StatusWrapper(status: LoginStatus.ERROR, data: loginResult.errorMessage),);
      }
    });

    return completer.future;
  }
}

enum LoginStatus {
  SUCCESS,
  ERROR,
}
