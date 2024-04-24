import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/ticker.dart';
import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';

class GetTickers24hrsUseCase {
  final CryptoTickerRepository _cryptoTickerRepository;

  GetTickers24hrsUseCase(this._cryptoTickerRepository);

  Future<Result<List<Tickers>, String>> call() =>
      _cryptoTickerRepository.getTicker24hr();
}
