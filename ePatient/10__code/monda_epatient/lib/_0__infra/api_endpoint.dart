class ApiEndPoint {
  ApiEndPoint._();

  static const String PREFIX = 'http://192.168.0.101:3005/v1';

  // =================================================================== Account
  static const String LOGIN = PREFIX + '/patient/login';

  static const String SIGNUP = PREFIX + '/patient/signup';
}
