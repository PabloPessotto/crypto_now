import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_now/data/models/crypto_ticker_data_dto.dart';
import 'package:crypto_now/data/models/ticker_dto.dart';
import 'package:crypto_now/data/network/service_client/ticker_service_client.dart';
import 'package:crypto_now/shared/utils/config_reader.dart';

abstract interface class CryptoRemoteDataSource {
  Stream<List<CryptoTickerDto>>? cryptoTickerStream();
  void connect();
  void disconnect();
  bool isConnected();
  Future<List<TickerDto>> getTicker24hr();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final TickerServiceClient _tickerServiceClient;

  CryptoRemoteDataSourceImpl(this._tickerServiceClient);
  WebSocket? _webSocket;

  @override
  void connect() async {
    try {
      print('isConnected connect- ${isConnected()}');
      if (!isConnected() && _webSocket == null) {
        _webSocket = await WebSocket.connect(
          '${ConfigReader.getWSBaseUrl()}/ws/!ticker@arr',
          headers: {
            "binance-api-key":
                "HsfWLTsOCnCyxz9EyapVENWDxXNHFiu5qeHnFKe4krN5XRPlQY3xWf1TWV1MeNfT",
            "binance-api-secret":
                "vqBKhL1K5ZGsG8mjFDFNxGfiyhoj0RNKz6go1qxZjYgL8qVDaLzXfpxD6nbbZNxe"
          },
        );
      }
    } catch (e) {
      print('Erro na conexão WebSocket: $e');
    }
  }

  @override
  Stream<List<CryptoTickerDto>>? cryptoTickerStream() async* {
    try {
      Stream? stream;
      if (isConnected()) {
        var allCrypto = const <CryptoTickerDto>[];
        stream ??= _webSocket!.map((event) => jsonDecode(event));
        await for (final i in stream) {
          final listWS = i.map((e) => CryptoTickerDto.fromJson(e)).toList();
          for (final j in listWS) {
            allCrypto = [...allCrypto, j];
          }
          yield allCrypto;
        }
      }
    } catch (e) {
      print('Erro stream: $e');
    }
  }

  @override
  Future<void> disconnect() async {
    await _webSocket?.close();
    _webSocket = null;
  }

  @override
  bool isConnected() {
    final isConnect = _webSocket?.readyState == WebSocket.open;
    return isConnect;
  }

  @override
  Future<List<TickerDto>> getTicker24hr() async {
    return await _tickerServiceClient.getTicker24hr();
  }
}
