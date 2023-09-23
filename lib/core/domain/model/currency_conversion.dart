class CurrencyConversion {
  String id;
  num val;
  String to;
  String fr;
  DateTime dateTime;
  CurrencyConversion({
    required this.id,
    required this.val,
    required this.to,
    required this.fr,
    required this.dateTime,
  });

  factory CurrencyConversion.fromJson(Map json) {
    return CurrencyConversion(
      id: json['id'],
      val: json['val'],
      to: json['to'],
      fr: json['fr'],
      dateTime: DateTime.now(),
    );
  }
}
