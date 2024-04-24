class CryptoTicker {
  String? event;
  int? eventTime;
  String? symbol;

  // Essential properties
  double? priceChange; // Price change (positive or negative)
  double? priceChangePercent; // Price change percentage

  // Additional properties
  double? weightedAveragePrice; // Weighted average price
  double? firstTradePrice; // First trade price (before the 24hr window)
  double? lastPrice; // Last traded price
  double? lastQuantity; // Quantity of the last trade
  double? bestBidPrice; // Best bid price
  double? bestBidQuantity; // Quantity of the best bid price
  double? bestAskPrice; // Best ask price
  double? bestAskQuantity; // Quantity of the best ask price
  double? openPrice; // Opening price
  double? highPrice; // Highest price
  double? lowPrice; // Lowest price
  double? totalTradedBaseAssetVolume; // Total traded base asset volume
  double? totalTradedQuoteAssetVolume; // Total traded quote asset volume

  CryptoTicker(
      {this.event,
      this.eventTime,
      this.symbol,
      this.priceChange,
      this.priceChangePercent,
      this.weightedAveragePrice,
      this.firstTradePrice,
      this.lastPrice,
      this.lastQuantity,
      this.bestBidPrice,
      this.bestBidQuantity,
      this.bestAskPrice,
      this.bestAskQuantity,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.totalTradedBaseAssetVolume,
      this.totalTradedQuoteAssetVolume});

  Map<String, dynamic> toJson() {
    return {
      "event": event,
      "eventTime": eventTime,
      "symbol": symbol,
      "priceChange": priceChange,
      "priceChangePercent": priceChangePercent,
      "weightedAveragePrice": weightedAveragePrice,
      "firstTradePrice": firstTradePrice,
      "lastPrice": lastPrice,
      "lastQuantity": lastQuantity,
      "bestBidPrice": bestBidPrice,
      "bestBidQuantity": bestBidQuantity,
      "bestAskPrice": bestAskPrice,
      "bestAskQuantity": bestAskQuantity,
      "openPrice": openPrice,
      "highPrice": highPrice,
      "lowPrice": lowPrice,
      "totalTradedBaseAssetVolume": totalTradedBaseAssetVolume,
      "totalTradedQuoteAssetVolume": totalTradedQuoteAssetVolume,
    };
  }
}
