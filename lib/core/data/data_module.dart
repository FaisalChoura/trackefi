import 'package:expense_categoriser/core/data/repository/currency_data_repository_impl.dart';
import 'package:expense_categoriser/core/domain/repository/currency_data_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyDataRepositoryProvider =
    Provider<CurrencyDataRepository>((ref) => CurrencyDataRepositoryImpl());
