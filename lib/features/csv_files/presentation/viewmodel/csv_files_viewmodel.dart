import 'package:expense_categoriser/features/csv_files/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/remove_file_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvFilesViewModelProvider =
    Provider<CsvFilesViewModel>((ref) => CsvFilesViewModel(
          ref.watch(importFilesUseCaseProvider),
          ref.watch(removeFilesUseCaseProvider),
        ));

class CsvFilesViewModel {
  final ImportFilesUseCase _importFilesUseCase;
  final RemoveFileUseCase _removeFileUseCase;

  CsvFilesViewModel(
    this._importFilesUseCase,
    this._removeFileUseCase,
  );

  void importFiles() async {
    _importFilesUseCase.execute();
  }

  void removeFile(PlatformFile file) async {
    _removeFileUseCase.execute(file);
  }
}
