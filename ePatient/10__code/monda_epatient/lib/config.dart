class Config {
  Config._();

  static const String VERSION = 'Version 0.1';

  //static const String PREFIX_API_ENDPOINT = 'http://192.168.0.101:3005/v1';

  static const String PREFIX_API_ENDPOINT = 'http://192.168.43.34:3005/v1';

  static const bool PAYHERE__SANDBOX = true;

  static const String PAYHERE__MERCHANT_ID = '1219145';

  static const String PAYHERE__SECRET_KEY = '4eVLmlVP0cs8W1AHVnxve88hheDbCWm5F8cQEjj0TJDA';

  static const String PAYHERE__CHECKOUT_ENDPOINT__SANDBOX = 'https://sandbox.payhere.lk/pay/checkout';

  static const String PAYHERE__CHECKOUT_ENDPOINT__LIVE = 'https://www.payhere.lk/pay/checkout';

  static const String PAYHERE__NOTIFY_URL = PREFIX_API_ENDPOINT + '/payment/payhere-notify';

  static const String PAYHERE__CURRENCY = 'USD'; // USD or LKR only
}
