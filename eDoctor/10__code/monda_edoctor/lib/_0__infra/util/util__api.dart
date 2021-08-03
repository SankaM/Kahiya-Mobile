import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef ResponseWrapper<T> ResponseDataBuilder<T>(Map<String, dynamic> json);

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

  static Future<ResponseWrapper<T>> post<T>({required String url, Map<String, dynamic>? postData, Options? options, required ResponseDataBuilder<T> responseDataBuilder}) async {
    var res;
    try {
      res = await ApiUtil.dio.post(url, options: options, data: postData);
    } catch (e) {
      DioError de = e as DioError;
      String errorMessage = de.response != null ? de.response!.data != null ? de.response!.data['message'] : 'Error' : 'Error';

      return ResponseWrapper<T>.error(message: errorMessage);
    }

    if(res.statusCode == 200 || res.statusCode == 201) {
      log('=========================================================== res: $res');
      var data;
      if(res != null && res.data != null) {
        data = res.data;
      }

      return responseDataBuilder(data);
    } else {
      return ResponseWrapper<T>.error();
    }
  }

  static Future<ResponseWrapper<T>> postWithFormData<T>({required String url, required FormData formData, Options? options, required ResponseDataBuilder<T> responseDataBuilder}) async {
    var res;
    try {
      res = await ApiUtil.dio.post(url, options: options, data: formData);
    } catch (e) {
      DioError de = e as DioError;
      String errorMessage = de.response != null ? de.response!.data != null ? de.response!.data['message'] : 'Error' : 'Error';

      return ResponseWrapper<T>.error(message: errorMessage);
    }

    if(res.statusCode == 200 || res.statusCode == 201) {
      log('=========================================================== res: $res');
      var data;
      if(res != null && res.data != null) {
        data = res.data;
      }

      return responseDataBuilder(data);
    } else {
      return ResponseWrapper<T>.error();
    }
  }

  static Future<ResponseWrapper<T>> get<T>({required String url, Options? options, required ResponseDataBuilder<T> responseDataBuilder}) async {
    var res;
    try {
      res = await ApiUtil.dio.get(url, options: options,);
    } catch (e) {
      DioError de = e as DioError;
      String errorMessage = de.response != null ? de.response!.data != null ? de.response!.data['message'] : 'Error' : 'Error';

      return ResponseWrapper<T>.error(message: errorMessage);
    }

    if(res.statusCode == 200 || res.statusCode == 201) {
      return responseDataBuilder(res.data);
    } else {
      return ResponseWrapper<T>.error();
    }
  }
}
