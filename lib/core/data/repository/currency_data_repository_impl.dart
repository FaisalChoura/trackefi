import 'dart:convert';
import 'package:expense_categoriser/core/data/store/currencies_map.dart';
import 'package:http/http.dart' as http;
import 'package:expense_categoriser/core/domain/model/currency.dart';
import 'package:expense_categoriser/core/domain/model/currency_conversion.dart';
import 'package:expense_categoriser/core/domain/repository/currency_data_repository.dart';
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
        "https://free.currconv.com/api/v7/convert?q=${fromId}_$id&apiKey=$apiKey"));

    if (response.statusCode == 200) {
      final conversion = CurrencyConversion.fromJson(
          jsonDecode(response.body)['results']["${fromId}_$id"]);
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
