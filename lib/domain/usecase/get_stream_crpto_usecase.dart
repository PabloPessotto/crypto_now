import 'package:crypto_now/domain/entities/crypto_ticker.dart';
import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';

class GetStreamCryptoUseCase {
  final CryptoTickerRepository _cryptoTickerRepository;

  GetStreamCryptoUseCase(this._cryptoTickerRepository);

  Stream<List<CryptoTicker>?>? call() {
    return _cryptoTickerRepository.cryptoTickerStream;
  }
}
