import 'package:get/get.dart' as _;
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';

class PaymentApi extends ApiDataSource {
  static PaymentApi get instance => _.Get.find();

  PaymentApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<void>> updateStatus({required String orderNumber, required String paymentId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PAYMENT__UPDATE_STATUS).toString();
    var data = {'orderNumber': orderNumber, 'paymentId': paymentId};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<void>.success(data: null);
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
