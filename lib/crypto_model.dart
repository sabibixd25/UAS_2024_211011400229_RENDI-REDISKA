class Crypto {
  final String id;
  final String symbol;
  final String name;
  final int rank;
  final double priceUsd;
  final double percentChange24h;
  final double percentChange1h;
  final double percentChange7d;
  final double marketCapUsd;

  Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.rank,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange1h,
    required this.percentChange7d,
    required this.marketCapUsd,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'].toString(),
      symbol: json['symbol'],
      name: json['name'],
      rank: json['rank'],
      priceUsd: double.parse(json['price_usd']),
      percentChange24h: double.parse(json['percent_change_24h']),
      percentChange1h: double.parse(json['percent_change_1h']),
      percentChange7d: double.parse(json['percent_change_7d']),
      marketCapUsd: double.parse(json['market_cap_usd']),
    );
  }
}
