import 'package:crypto_now/data/models/crypto_ticker_data_dto.dart';
import 'package:crypto_now/data/models/ticker_dto.dart';
import 'package:crypto_now/domain/entities/crypto_ticker.dart';
import 'package:crypto_now/domain/entities/ticker.dart';

extension CryptoDtpMapper on CryptoTickerDto? {
  CryptoTicker toDomain() {
    return CryptoTicker(
      event: this?.event,
      symbol: this?.symbol,
      bestAskPrice: this?.bestAskPrice,
      bestAskQuantity: this?.bestAskQuantity,
      bestBidPrice: this?.bestBidPrice,
      bestBidQuantity: this?.bestBidQuantity,
      eventTime: this?.eventTime,
      firstTradePrice: this?.firstTradePrice,
      highPrice: this?.highPrice,
      lastPrice: this?.lastPrice,
      lastQuantity: this?.lastQuantity,
      lowPrice: this?.lowPrice,
      openPrice: this?.openPrice,
      priceChange: this?.priceChange,
      priceChangePercent: this?.priceChangePercent,
      totalTradedBaseAssetVolume: this?.totalTradedBaseAssetVolume,
      totalTradedQuoteAssetVolume: this?.totalTradedQuoteAssetVolume,
      weightedAveragePrice: this?.weightedAveragePrice,
    );
  }
}

extension TickerDtoMapper on TickerDto? {
  Tickers toDomain() {
    return Tickers(
      askPrice: this?.askPrice,
      priceChangePercent: this?.priceChangePercent,
      priceChange: this?.priceChange,
      openPrice: this?.openPrice,
      lowPrice: this?.lowPrice,
      lastPrice: this?.lastPrice,
      highPrice: this?.highPrice,
      weightedAvgPrice: this?.weightedAvgPrice,
      symbol: this?.symbol,
      askQty: this?.askQty,
      bidPrice: this?.bidPrice,
      bidQty: this?.bidQty,
      closeTime: this?.closeTime,
      count: this?.count,
      firstId: this?.firstId,
      lastId: this?.lastId,
      lastQty: this?.lastQty,
      openTime: this?.openTime,
      prevClosePrice: this?.prevClosePrice,
      quoteVolume: this?.quoteVolume,
      volume: this?.volume,
    );
  }
}
