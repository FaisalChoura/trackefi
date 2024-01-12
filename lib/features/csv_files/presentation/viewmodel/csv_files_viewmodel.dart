import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/remove_file_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/update_file_usecase.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvFilesViewModelProvider =
    StateNotifierProvider<CsvFilesViewModel, AsyncValue<void>>(
        (ref) => CsvFilesViewModel(
              ref.watch(importFilesUseCaseProvider),
              ref.watch(removeFilesUseCaseProvider),
              ref.watch(updateFileUseCaseProvider),
            ));

class CsvFilesViewModel extends StateNotifier<AsyncValue<void>> {
  final ImportFilesUseCase _importFilesUseCase;
  final RemoveFileUseCase _removeFileUseCase;
  final UpdateFileUseCase _updateFileUseCase;

  CsvFilesViewModel(this._importFilesUseCase, this._removeFileUseCase,
      this._updateFileUseCase)
      : super(const AsyncValue.data(null));

  Future<List<XFile>> getFiles() async {
    try {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: <String>['csv'],
      );
      final List<XFile> files =
          await openFiles(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
      return files;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return [];
    }
  }

  void importFiles(List<CsvFileData> files) async {
    _importFilesUseCase.execute(files);
  }

  void removeFile(CsvFileData fileData) async {
    _removeFileUseCase.execute(fileData);
  }

  void updateFile(CsvFileData fileData) async {
    _updateFileUseCase.execute(fileData);
  }
}
