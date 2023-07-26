import 'package:expense_categoriser/features/csv_files/data/repository/csv_files_repository_impl.dart';
import 'package:expense_categoriser/features/csv_files/data/store/csv_files_store.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repository/csv_files_repository.dart';

final csvFilesStoreProvider =
    StateNotifierProvider<CsvFilesStore, List<CsvFileData>>(
        (ref) => CsvFilesStore());
final csvFilesRepositoryProvider = Provider<CsvFilesRepository>(
    (ref) => CsvFilesRepositoryImpl(ref.watch(csvFilesStoreProvider.notifier)));
