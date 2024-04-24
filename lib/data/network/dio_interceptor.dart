import 'package:crypto_now/shared/utils/config_reader.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['binance-api-key'] = ConfigReader.getApiKey();
    options.headers['binance-api-secret'] = ConfigReader.getApiSecret();

    super.onRequest(options, handler);
  }
}
