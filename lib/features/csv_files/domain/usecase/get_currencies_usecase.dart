import 'package:expense_categoriser/core/domain/model/currency.dart';
import 'package:expense_categoriser/core/domain/repository/currency_data_repository.dart';

class GetCurrenciesUseCase {
  final CurrencyDataRepository _currencyDataRepository;

  GetCurrenciesUseCase(this._currencyDataRepository);

  List<Currency> execute() {
    return _currencyDataRepository.getAllCurrencies();
  }
}
