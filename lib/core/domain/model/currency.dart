class Currency {
  String id;
  String currencyName;
  String currencySymbol;
  Currency(
      {required this.id,
      required this.currencyName,
      required this.currencySymbol});

  factory Currency.fromJSON(Map json) {
    return Currency(
      id: json['id'] ?? '',
      currencyName: json['currencyName'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
    );
  }
}
