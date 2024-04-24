import 'package:crypto_now/data/models/ticker_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'ticker_service_client.g.dart';

@RestApi()
abstract interface class TickerServiceClient {
  factory TickerServiceClient(Dio dio, {String? baseUrl}) = _TickerServiceClient;

  @GET('/api/v3/ticker/24hr')
  Future<List<TickerDto>> getTicker24hr();
}
