import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/user.dart';
import 'package:monda_epatient/_2__datasource/api/api__account.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';

class AccountService {
  AccountService.newInstance();

  static AccountService get instance => Get.find();

  // ===========================================================================
  Future<StatusWrapper<Status, User, String>> login({required String username, required String password}) {
    var completer = Completer<StatusWrapper<Status, User, String>>();

    AccountApi.instance.login(username: username, password: password).then((ResponseWrapper<User> res) {
      if(res.isSuccess) {
        UserSecureStorage.instance.user = res.data;
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }
}
