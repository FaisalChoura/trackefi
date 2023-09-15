import 'package:expense_categoriser/core/domain/model/currency.dart';

abstract class CurrencyDataRepository {
  List<Currency> getAllCurrencies();
}
