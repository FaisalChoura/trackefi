import 'package:Trackefi/core/data/repository/currency_data_repository_impl.dart';
import 'package:Trackefi/core/data/store/currencies_map.dart';
import 'package:Trackefi/core/domain/model/currency_conversion.dart';
import 'package:Trackefi/core/domain/repository/currency_data_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currenciesStoreProvider =
    StateNotifierProvider<CurrenciesMapStore, Map<String, CurrencyConversion>>(
        (ref) => CurrenciesMapStore());

final currencyDataRepositoryProvider = Provider<CurrencyDataRepository>((ref) =>
    CurrencyDataRepositoryImpl(ref.watch(currenciesStoreProvider.notifier)));
