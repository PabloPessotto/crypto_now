import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';

class ConnectSocketCryptoUseCase {
  final CryptoTickerRepository _cryptoTickerRepository;

  ConnectSocketCryptoUseCase(this._cryptoTickerRepository);

  void call() => _cryptoTickerRepository.connect();
}
