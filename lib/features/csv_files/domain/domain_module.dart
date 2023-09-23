import 'package:Trackefi/core/data/data_module.dart';
import 'package:Trackefi/features/csv_files/data/data_module.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/get_currencies_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/remove_file_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/update_file_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importFilesUseCaseProvider = Provider<ImportFilesUseCase>(
    (ref) => ImportFilesUseCase(ref.watch(csvFilesRepositoryProvider)));
final removeFilesUseCaseProvider = Provider<RemoveFileUseCase>(
  (ref) => RemoveFileUseCase(ref.watch(csvFilesRepositoryProvider)),
);
final updateFileUseCaseProvider = Provider<UpdateFileUseCase>(
  (ref) => UpdateFileUseCase(ref.watch(csvFilesRepositoryProvider)),
);
final getCurrenciesUseCaseProvider = Provider<GetCurrenciesUseCase>(
  (ref) => GetCurrenciesUseCase(ref.watch(currencyDataRepositoryProvider)),
);
