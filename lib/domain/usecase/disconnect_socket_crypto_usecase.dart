import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';

class DisconnectSocketCryptoUseCase {
  final CryptoTickerRepository _cryptoTickerRepository;

  DisconnectSocketCryptoUseCase(this._cryptoTickerRepository);

  void call() => _cryptoTickerRepository.disconnect();
}
