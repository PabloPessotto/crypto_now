import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/crypto_ticker.dart';
import 'package:crypto_now/domain/entities/ticker.dart';

abstract interface class CryptoTickerRepository {
  Stream<List<CryptoTicker>?>? get cryptoTickerStream;
  void connect();
  void disconnect();
  Future<Result<List<Tickers>, String>> getTicker24hr();
}
