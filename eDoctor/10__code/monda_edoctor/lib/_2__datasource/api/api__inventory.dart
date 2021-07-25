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
      url = TemplateString(stringWithParams: ApiEndPoint.INVENTORY_ALL, params: {
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
}
