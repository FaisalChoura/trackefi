import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/core/domain/repository/currency_data_repository.dart';

class GetCurrenciesUseCase {
  final CurrencyDataRepository _currencyDataRepository;

  GetCurrenciesUseCase(this._currencyDataRepository);

  List<Currency> execute() {
    return _currencyDataRepository.getAllCurrencies();
  }
}
