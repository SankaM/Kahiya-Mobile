import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiUtil {
  static Dio? _dio;

  static Dio get dio {
    if(_dio == null) {
      _dio = Dio();

      _dio!.interceptors.add(PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 160),);
    }
    
    return _dio!;
  }

  static Future<Options> generateDioOptions() async {
    return Options();
  }
}
