import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/user.dart';
import 'package:monda_epatient/_2__datasource/api/api__payment.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_epatient/config.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class PaymentService {
  static PaymentService get instance => Get.find();

  PaymentService.newInstance();

  // ===========================================================================
  void payhereCheckout({required String orderId, required String items, required double amount}) async {
    User user = UserSecureStorage.instance.user!;

    Map paymentObject = {
      "sandbox": Config.PAYHERE__SANDBOX,
      "merchant_id": Config.PAYHERE__MERCHANT_ID,
      "merchant_secret": Config.PAYHERE__SECRET_KEY,
      "notify_url": Config.PAYHERE__NOTIFY_URL,
      "order_id": orderId,
      "items": items,
      "amount": amount.toString(),
      "currency": Config.PAYHERE__CURRENCY,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email": user.email,
      "phone": user.mobilePhone,
      "address": "",
      "city": "",
      "country": "",
    };

    PayHere.startPayment(paymentObject, (paymentId) {
        PaymentApi.instance.updateStatus(orderNumber: orderId, paymentId: paymentId);
        AlertUtil.showMessage(TextString.label__payment_success);
        RouteNavigator.gotoHomePage();
      }, (error) {
        AlertUtil.showMessage(TextString.label__payment_failed);
      }, () {
        AlertUtil.showMessage(TextString.label__payment_cancelled);
      }
    );
  }
}
