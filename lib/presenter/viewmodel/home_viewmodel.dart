import 'dart:async';

import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/data/datasource/remote/crypto_remote_data_source.dart';
import 'package:crypto_now/data/repository/crypto_ticker_repository_impl.dart';
import 'package:crypto_now/domain/entities/crypto_ticker.dart';
import 'package:crypto_now/domain/entities/ticker.dart';
import 'package:crypto_now/domain/repository/crypto_ticker_repository.dart';
import 'package:crypto_now/domain/usecase/get_tickers_24hrs_usecase.dart';
import 'package:crypto_now/presenter/view/app/cryto_now.dart';
import 'package:crypto_now/shared/utils/mock_crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRemoteDataSourceProvider = Provider<CryptoRemoteDataSource>((ref) {
  final tickerServiceClient = ref.watch(tickerServiceClientProvider);
  return CryptoRemoteDataSourceImpl(tickerServiceClient);
});

final cryptoTickerRepositoryProvider = Provider<CryptoTickerRepository>((ref) {
  final cryptoRemoteDataSource = ref.watch(cryptoRemoteDataSourceProvider);
  return CryptoTickerRepositoryImpl(cryptoRemoteDataSource);
});

final getTickersProvider = Provider<GetTickers24hrsUseCase>((ref) {
  final cryptoRepository = ref.read(cryptoTickerRepositoryProvider);
  return GetTickers24hrsUseCase(cryptoRepository);
});

final cryptoTickerNotifierProvider =
    StateNotifierProvider<HomeViewModel, List<Tickers>>((ref) {
  final getTickers = ref.watch(getTickersProvider);
  return HomeViewModel(getTickers);
});

class HomeViewModel extends StateNotifier<List<Tickers>> {
  final GetTickers24hrsUseCase _getTickers24hrsUseCase;

  HomeViewModel(this._getTickers24hrsUseCase) : super([]);
  List<CryptoTicker> listCryptoTickers = [];
  Timer? _timer;

  void loadTickers() async {
    final result = await _getTickers24hrsUseCase.call();
    if (result case Success(value: final tickers)) {
      if (tickers.isNotEmpty) {
        _timer ??= Timer.periodic(const Duration(seconds: 10), (timer) {
          print('Teste - ${state.length}');
          state = tickers
              .where((e) =>
                  e.priceChangePercent!.contains('+') ||
                  e.priceChangePercent!.contains('-'))
              .toList();
        });
        return;
      }
    }

    if (result case Failure(value: final message)) {
      print('Teste Failure- ${message}');
      if (state.isEmpty) {
        _loadMockCrypto();
      }
      return;
    }
  }

  void _loadMockCrypto() {
    state = listMockCrypto
        .map((e) => Tickers.fromJson(e))
        .where((element) =>
            element.priceChangePercent!.contains('+') ||
            element.priceChangePercent!.contains('-'))
        .toList();
  }
}
