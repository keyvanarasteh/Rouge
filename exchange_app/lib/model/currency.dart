class Currency {
  String? base;
  String? to;
  int? amount;
  double? converted;
  double? rate;
  int? lastUpdate;

  Currency({this.base,
    this.to,
    this.amount,
    this.converted,
    this.rate,
    this.lastUpdate});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        base: json['base'],
        to: json['to'],
        amount: json['amount'],
        converted: json['converted'],
        rate: json['rate'],
        lastUpdate : json['lastUpdate']);
  }
}
