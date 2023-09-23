import 'package:Trackefi/core/domain/model/currency_conversion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrenciesMapStore
    extends StateNotifier<Map<String, CurrencyConversion>> {
  CurrenciesMapStore() : super(<String, CurrencyConversion>{});

  void putConversion(CurrencyConversion conversion) {
    final tempState = {...state};
    tempState[conversion.id] = conversion;
    state = tempState;
  }

  CurrencyConversion? getConversion(String id) {
    return state[id];
  }
}
