import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/core/domain/model/currency_conversion.dart';

abstract class CurrencyDataRepository {
  List<Currency> getAllCurrencies();
  Future<CurrencyConversion> convert(String fromId, String id);
}
