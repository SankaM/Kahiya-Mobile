import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';

class InventoryApi {
  static InventoryApi get instance => Get.find();

  InventoryApi.newInstance();

  Future<ResponseWrapper<List<Inventory>>> getSearchInventory({required String doctorId, required int page, required int itemPerPage, String? queryValue, String? field,}) async {
    String url;
    if(queryValue == null) {
      url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_ALL_PER_PAGE, params: {
        'doctorId': doctorId,
        'page': page.toString(),
        'itemPerPage': itemPerPage.toString(),
      }).toString();
    } else {
      url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_SEARCH, params: {
            'doctorId': doctorId,
            'page': page.toString(),
            'itemPerPage': itemPerPage.toString(),
            'field': field!,
            'queryValue': queryValue,
          }).toString();
    }

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Inventory>>.success(data: (json['data'] as List).map((e) => Inventory.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<List<Inventory>>> getAllInventory({required String doctorId,}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_ALL, params: {'doctorId': doctorId,}).toString();

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Inventory>>.success(data: (json['data'] as List).map((e) => Inventory.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper<Inventory>> getInventory({required String doctorId, required String inventoryId,}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_DETAIL, params: {
      'doctorId': doctorId,
      'inventoryId': inventoryId,
    }).toString();

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Inventory>.success(data: Inventory.build(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  Future<ResponseWrapper> newBatchInventory(
      {required String doctorId,
      required String drugId,
      required double unitSellPrice,
      required String unitSellCurrency,
      required double unitBuyPrice,
      required String unitBuyCurrency,
      required double unitCount,
      required String batchDate,
      required String expiryDate}) async {

    String url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_NEW_BATCH, params: {'doctorId': doctorId}).toString();
    var data = {
      'drugId': drugId,
      'unitSellPrice': unitSellPrice,
      'unitSellCurrency': unitSellCurrency,
      'unitBuyPrice': unitBuyPrice,
      'unitBuyCurrency': unitBuyCurrency,
      'unitCount': unitCount,
      'batchDate': batchDate,
      'expiryDate': expiryDate,
    };
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper.success();
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
