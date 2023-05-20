import 'package:expense_categoriser/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importFilesUseCaseProvider =
    Provider<ImportFilesUseCase>((ref) => ImportFilesUseCase());
