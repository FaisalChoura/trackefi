import 'package:expense_categoriser/core/domain/model/currency_conversion.dart';
import 'package:expense_categoriser/core/domain/repository/currency_data_repository.dart';

class ConvertCurrencyUseCase {
  final CurrencyDataRepository _currencyDataRepository;

  ConvertCurrencyUseCase(this._currencyDataRepository);

  Future<CurrencyConversion> execute(String fromId, String toId) async {
    return await _currencyDataRepository.convert(fromId, toId);
  }
}
