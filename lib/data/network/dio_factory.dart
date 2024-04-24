import 'package:crypto_now/data/network/dio_interceptor.dart';
import 'package:crypto_now/shared/utils/config_reader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = 'application/json';
const String contentType = 'Content-Type';
const String accept = 'accept';
const String authorization = 'Authorization';
const String defaultLanguage = 'language';
const String apiKey = 'x-api-key';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeout = 1; // 1 min
    String language = "pt";
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      defaultLanguage: language,
    };

    dio.options = BaseOptions(
      baseUrl: ConfigReader.getBaseUrl(),
      headers: headers,
      connectTimeout: Duration(minutes: timeout),
      receiveTimeout: Duration(minutes: timeout),
    );

    dio.interceptors.add(DioInterceptor());

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}
