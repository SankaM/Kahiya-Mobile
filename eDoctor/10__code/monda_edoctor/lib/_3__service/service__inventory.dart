import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_2__datasource/api/api__inventory.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class InventoryService {
  static InventoryService get instance => Get.find();

  InventoryService.newInstance();

  Future<StatusWrapper<GetSearchInventoryStatus, List<Inventory>, String>> getSearchInventory({required int page, required int itemPerPage, String? queryValue, SearchDrugField? field}) {
    var completer = Completer<StatusWrapper<GetSearchInventoryStatus, List<Inventory>, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    String? fieldAsString = field != null ? field.toString().split('.').last : null;

    InventoryApi.instance.getSearchInventory(doctorId: doctorId, page: page, itemPerPage: itemPerPage, queryValue: queryValue, field: fieldAsString).then((ResponseWrapper<List<Inventory>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetSearchInventoryStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetSearchInventoryStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }
}

enum SearchDrugField {
  NAME, TYPE, MEASUREMENT
}

enum GetSearchInventoryStatus {
  SUCCESS,
  ERROR,
}
