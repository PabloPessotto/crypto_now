import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/data/datasource/remote/crypto_remote_data_source.dart';
import 'package:crypto_now/data/mapper/crypto_dto_mapper.dart';
import 'package:crypto_now/domain/entities/crypto_ticker.dart';
import 'package:crypto_now/domain/entities/ticker.dart';
import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';

class CryptoTickerRepositoryImpl implements CryptoTickerRepository {
  final CryptoRemoteDataSource _cryptoRemoteDataSource;

  CryptoTickerRepositoryImpl(this._cryptoRemoteDataSource);

  @override
  void connect() {
    _cryptoRemoteDataSource.connect();
  }

  @override
  Stream<List<CryptoTicker>>? get cryptoTickerStream {
    return _cryptoRemoteDataSource
        .cryptoTickerStream()
        ?.map((event) => event.map((e) => e.toDomain()).toList());
  }

  @override
  void disconnect() {
    _cryptoRemoteDataSource.disconnect();
  }

  @override
  Future<Result<List<Tickers>, String>> getTicker24hr() async {
    try {
      final response = await _cryptoRemoteDataSource.getTicker24hr();
      return Success(response.map((e) => e.toDomain()).toList());
    } catch (e) {
      return const Failure("Couldn't get tickers'");
    }
  }
}
