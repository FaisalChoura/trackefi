import 'dart:convert';
import 'package:Trackefi/core/data/store/currencies_map.dart';
import 'package:http/http.dart' as http;
import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/core/domain/model/currency_conversion.dart';
import 'package:Trackefi/core/domain/repository/currency_data_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CurrencyDataRepositoryImpl implements CurrencyDataRepository {
  final CurrenciesMapStore _store;
  late String apiKey;
  CurrencyDataRepositoryImpl(this._store) {
    apiKey = dotenv.env['CURRENCY_API_KEY'] ?? '';
  }

  @override
  List<Currency> getAllCurrencies() {
    final body = jsonDecode(currencyDataJson);
    final List<dynamic> currencyData = body["results"].values.toList();
    final currencyList =
        currencyData.map((data) => Currency.fromJSON(data)).toList();
    return currencyList;
  }

  @override
  Future<CurrencyConversion> convert(String fromId, String id) async {
    final idPair = "${fromId}_$id";
    // Add a time condition
    if (_store.getConversion(idPair) != null) {
      return _store.getConversion(idPair)!;
    }

    final response = await http.get(Uri.parse(
        "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${fromId.toLowerCase()}/${id.toLowerCase()}.json"));

    if (response.statusCode == 200) {
      dynamic decodedRepose = jsonDecode(response.body);
      num value = decodedRepose[id.toLowerCase()];
      final conversion = CurrencyConversion(
        id: idPair,
        to: id,
        fr: fromId,
        dateTime: DateTime.now(),
        val: value,
      );
      _store.putConversion(conversion);
      return conversion;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

// TODO create call to get these on app init and store them should recall once in a while
const currencyDataJson =
    '{ "results": {"AED": {"currencyName": "UAE Dirham", "id": "AED"}, "USD":{"currencyName":"United States Dollar","currencySymbol":"\$","id":"USD"},"EUR":{"currencyName":"Euro","currencySymbol":"€","id":"EUR"},"GBP":{"currencyName":"British Pound","currencySymbol":"£","id":"GBP"}}}';
