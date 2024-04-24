class CryptoTickerDto {
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

  CryptoTickerDto(
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

  factory CryptoTickerDto.fromJson(Map<String, dynamic> json) {
    return CryptoTickerDto(
      event: json['e'] as String,
      eventTime: json['E'] as int,
      symbol: json['s'] as String,
      priceChange: double.parse(json['p'] as String),
      priceChangePercent: double.parse(json['P'] as String),
      weightedAveragePrice:
          json['w'] != null ? double.parse(json['w'] as String) : 0.0,
      firstTradePrice: json['x'] != null ? double.parse(json['x'] as String) : 0.0,
      lastPrice: json['c'] != null ? double.parse(json['c'] as String) : 0.0,
      lastQuantity: json['Q'] != null ? double.parse(json['Q'] as String) : 0.0,
      bestBidPrice: json['b'] != null ? double.parse(json['b'] as String) : 0.0,
      bestBidQuantity: json['B'] != null ? double.parse(json['B'] as String) : 0.0,
      bestAskPrice: json['a'] != null ? double.parse(json['a'] as String) : 0.0,
      bestAskQuantity: json['A'] != null ? double.parse(json['A'] as String) : 0.0,
      openPrice: json['o'] != null ? double.parse(json['o'] as String) : 0.0,
      highPrice: json['h'] != null ? double.parse(json['h'] as String) : 0.0,
      lowPrice: json['l'] != null ? double.parse(json['l'] as String) : 0.0,
      totalTradedBaseAssetVolume:
          json['v'] != null ? double.parse(json['v'] as String) : 0.0,
      totalTradedQuoteAssetVolume:
          json['q'] != null ? double.parse(json['q'] as String) : 0.0,
    );
  }

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
