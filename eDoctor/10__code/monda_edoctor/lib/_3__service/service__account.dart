import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/User.dart';
import 'package:monda_edoctor/_2__datasource/api/api__account.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class AccountService {
  AccountService.newInstance();

  static AccountService get instance => Get.find();

  Future<StatusWrapper<LoginStatus>> login({required String username, required String password}) {
    var completer = Completer<StatusWrapper<LoginStatus>>();

    AccountApi.instance.login(username: username, password: password).then((LoginResult loginResult) {
      if(loginResult.success) {
        User user = User(id: loginResult.doctorId, userName: loginResult.userName, name: loginResult.doctorName, location: loginResult.location, imageUrl: loginResult.imageUrl);
        UserSecureStorage.instance.user = user;
        completer.complete(StatusWrapper(status: LoginStatus.SUCCESS, data: user));
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
