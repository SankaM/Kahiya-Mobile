import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/user.dart';
import 'package:monda_edoctor/_2__datasource/api/api__account.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class AccountService {
  AccountService.newInstance();

  static AccountService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<LoginStatus, User, String>> login({required String username, required String password}) {
    var completer = Completer<StatusWrapper<LoginStatus, User, String>>();

    AccountApi.instance.login(username: username, password: password).then((ResponseWrapper<User> res) {
      if(res.isSuccess) {
        UserSecureStorage.instance.user = res.data;
        completer.complete(StatusWrapper(status: LoginStatus.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: LoginStatus.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }
}

enum LoginStatus {
  SUCCESS,
  ERROR,
}
