import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_1__model/drug.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_2__datasource/api/api__drug.dart';
import 'package:monda_edoctor/_2__datasource/api/api__inventory.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';

class InventoryService {
  static InventoryService get instance => Get.find();

  InventoryService.newInstance();

  // ===========================================================================
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

  // ===========================================================================
  Future<StatusWrapper<GetSearchDrugStatus, List<Drug>, String>> getSearchDrug({required String name}) {
    var completer = Completer<StatusWrapper<GetSearchDrugStatus, List<Drug>, String>>();

    DrugApi.instance.getSearchDrug(name: name).then((ResponseWrapper<List<Drug>> responseWrapper,) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: GetSearchDrugStatus.SUCCESS, data: responseWrapper.data));
      } else {
        completer.complete(StatusWrapper(status: GetSearchDrugStatus.ERROR, error: responseWrapper.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<NewBatchInventoryStatus, void, String>> newBatchInventory({
        required String drugId,
        required double unitSellPrice,
        required String unitSellCurrency,
        required double unitBuyPrice,
        required String unitBuyCurrency,
        required double unitCount,
        required String batchDate,
        required String expiryDate,}) {

    var completer = Completer<StatusWrapper<NewBatchInventoryStatus, void, String>>();

    var doctorId = UserSecureStorage.instance.user!.id;
    InventoryApi.instance.newBatchInventory(doctorId: doctorId, drugId: drugId, unitSellPrice: unitSellPrice, unitSellCurrency: unitSellCurrency, unitBuyPrice: unitBuyPrice, unitBuyCurrency: unitBuyCurrency, unitCount: unitCount, batchDate: batchDate, expiryDate: expiryDate).then((responseWrapper) {
      if(responseWrapper.isSuccess) {
        completer.complete(StatusWrapper(status: NewBatchInventoryStatus.SUCCESS));
      } else {
        completer.complete(StatusWrapper(status: NewBatchInventoryStatus.ERROR, error: responseWrapper.message));
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

enum GetSearchDrugStatus {
  SUCCESS,
  ERROR,
}

enum NewBatchInventoryStatus {
  SUCCESS,
  ERROR
}
